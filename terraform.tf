# We need the Heroku provider in order to create the Heroku application
provider "heroku" {
    email = "${var.heroku_email}"
    api_key = "${var.heroku_api_key}"
}

# We need the AWS provider in order to create the S3 bucket
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.aws_region}"
}

# Creates the IAM key for write access to the S3 bucket
# We need to create the IAM users, give that user an access
# key, and finally give that user write access to the bucket
# with a policy
resource "aws_iam_user" "iam_user" {
    name = "${var.app_name}-user"

    # You cannot tag a user, but you can give them a path
    # to help identify the context of the user
    path = "/${var.app_name}/"
}

# Creates the API key for the user
resource "aws_iam_access_key" "iam_key" {
    user = "${aws_iam_user.iam_user.name}"
}

# Restricts the user to only the S3 bucket they should
# have access to
resource "aws_iam_user_policy" "policy" {
  # We concatenate the user name with the policy to ensure that
  # the policy name is unique, but still recognizable
  name = "${aws_iam_user.iam_user.name}-policy"
  user = "${aws_iam_user.iam_user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3::::${var.s3_bucket}"
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "aws_bucket_static" {
    bucket = "${var.s3_bucket}"
    acl    = "private"

    tags {
        Name        = "${var.app_name}"
        Environment = "${var.app_environment}"
    }

    acl    = "public-read"

    cors_rule {
        allowed_origins = ["*"]
        allowed_methods = ["GET"]
        max_age_seconds = 3000
        allowed_headers = ["*"]
    }
}

# Creates the primary Heroku application.
resource "heroku_app" "default" {
    name = "${var.app_name}-${var.app_environment}"
    region = "${var.heroku_app_region}"

    config_vars = {
        APP_DEBUG = "${var.app_debug}"
        APP_URL = "${var.app_url}"
        AWS_ACCESS_KEY = "${aws_iam_access_key.iam_key.id}"
        AWS_SECRET_KEY = "${aws_iam_access_key.iam_key.secret}"
        S3_BUCKET = "${var.s3_bucket}"
        S3_REGION = "${var.aws_region}"
    }

    buildpacks = [
        "heroku/python"
    ]
}

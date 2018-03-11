# Creates the IAM key for write access to the S3 bucket
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

# Restricts the user to only the S3 bucket they should have access to
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
    region = "${var.s3_region}"
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

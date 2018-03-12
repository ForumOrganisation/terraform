# Creates the IAM key
resource "aws_iam_user" "default" {
    name = "${var.app_name}-${var.app_environment}"

    # You cannot tag a user, but you can give them a path
    # to help identify the context of the user
    path = "/${var.app_name}/"
}

# Creates the API key for the user
resource "aws_iam_access_key" "default" {
    user = "${aws_iam_user.default.name}"
}

# Restricts the user to only the S3 bucket they should have access to
resource "aws_iam_user_policy" "default" {
  # We concatenate the user name with the policy to ensure that
  # the policy name is unique, but still recognizable
  name = "${aws_iam_user.default.name}-policy"
  user = "${aws_iam_user.default.name}"

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

resource "aws_s3_bucket" "default" {
    bucket = "${var.s3_bucket}"
    acl    = "private"

    tags {
        Name        = "${var.app_name}"
        Environment = "${var.app_environment}"
    }
}

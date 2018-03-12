output "name" {
  value = "${aws_s3_bucket.default.id}"
}
output "access_key" {
  value = "${aws_iam_access_key.default.id}"
}
output "secret_key" {
  value = "${aws_iam_access_key.default.secret}"
}

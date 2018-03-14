resource "heroku_app" "default" {
  name   = "${var.app_name}"
  region = "${var.app_region}"

  config_vars = {
    APP_DEBUG             = "${var.app_debug}"
    APP_ENVIRONMENT       = "${var.app_environment}"
    AWS_ACCESS_KEY_ID     = "${var.s3_access_key}"
    AWS_SECRET_ACCESS_KEY = "${var.s3_secret_key}"
    BUCKET_NAME           = "${var.s3_bucket}"
    CLOUDFRONT_DOMAIN     = "${var.cdn_domain}"
  }

}

# Creates the primary Heroku application.
resource "heroku_app" "default" {
    name = "${var.app_name}"
    region = "${var.app_region}"

    config_vars = {
        APP_DEBUG       = "${var.app_debug}"
        APP_ENVIRONMENT = "${var.app_environment}"
        S3_ACCESS_KEY   = "${var.s3_access_key}"
        S3_SECRET_KEY   = "${var.s3_secret_key}"
        S3_BUCKET       = "${var.s3_bucket}"
        S3_REGION       = "${var.s3_region}"
    }

    buildpacks = [
        "heroku/python"
    ]
}

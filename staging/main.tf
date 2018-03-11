module "heroku_app" {
  # The source field can be a path on your file system or a Git URL (even a versioned one!)
  source = "./modules/heroku_app"

  # Pass parameters to the module
  app_name = "${var.app_name}"
  app_region = "${var.heroku_app_region}"
  app_environment = "staging"
  app_debug       = "false"
  s3_access_key   = "${module.aws_s3_bucket.access_key}"
  s3_secret_key   = "${module.aws_s3_bucket.secret_key}"
  s3_bucket       = "${module.aws_s3_bucket.name}"
  s3_region       = "${module.aws_s3_bucket.region}"
}

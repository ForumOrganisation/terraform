#####################################
############# PROVIDERS #############
#####################################

# We need the Heroku provider in order to create the Heroku application
provider "heroku" {
  email   = "${var.heroku_email}"
  api_key = "${var.heroku_api_key}"
}

# We need the AWS provider in order to create the S3 bucket
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

#####################################
########## HEROKU PIPELINE ##########
#####################################

module "heroku_pipeline" {
  source        = "./modules/heroku_pipeline"

  pipeline_name = "${var.app_name}"
}

#####################################
########### STAGING ENV #############
#####################################

module "cdn_staging" {
  source          = "./modules/aws_cdn"

  app_name        = "${var.app_name}"
  domain_name     = "${module.heroku_staging.hostname}"
  app_environment = "staging"
}

module "s3_staging" {
  source          = "./modules/aws_s3_bucket"

  app_name        = "${var.app_name}"
  app_environment = "staging"
  s3_bucket = "${var.app_name}-staging"
}

module "heroku_staging" {
  source          = "./modules/heroku_app"

  # App settings
  app_name        = "${var.app_name}-staging"
  app_environment = "staging"
  app_region      = "${var.heroku_app_region}"
  # S3 settings
  s3_bucket       = "${module.s3_staging.name}"
  s3_access_key   = "${module.s3_staging.access_key}"
  s3_secret_key   = "${module.s3_staging.secret_key}"
  cdn_domain      = "${module.cdn_staging.domain_name}"
}

module "papertrail" {
  source     = "./modules/heroku_addon"

  # Addon settings
  app_name   = "${module.heroku_staging.name}"
  addon_plan = "papertrail:fixa"
}

#####################################
########## PRODUCTION ENV ###########
#####################################

module "cdn_prod" {
  source          = "./modules/aws_cdn"

  app_name        = "${var.app_name}"
  # served behind Heroku Custom Domain
  domain_name     = "${module.custom_domain.hostname}"
  app_environment = "prod"
}

module "s3_prod" {
  source          = "./modules/aws_s3_bucket"

  app_name        = "${var.app_name}"
  app_environment = "prod"
  s3_bucket = "${var.app_name}-prod"
}

module "heroku_prod" {
  source          = "./modules/heroku_app"

  # App settings
  app_name        = "${var.app_name}-prod"
  app_environment = "prod"
  app_region      = "${var.heroku_app_region}"
  # S3 settings
  s3_bucket       = "${module.s3_prod.name}"
  s3_access_key   = "${module.s3_prod.access_key}"
  s3_secret_key   = "${module.s3_prod.secret_key}"
  cdn_domain      = "${module.cdn_prod.domain_name}"
}

module "papertrail_attachment" {
  source   = "./modules/heroku_addon_attachment"

  app_id   = "${module.heroku_prod.id}"
  addon_id = "${module.papertrail.id}"
  name = "PAPERTRAIL"
}

module "custom_domain" {
  source   = "./modules/heroku_domain"

  app_name = "${module.heroku_prod.name}"
  hostname = "${var.app_url}"
}

#####################################
###### HEROKU PIPELINE COUPLING #####
#####################################

module "heroku_pipeline_coupling" {
  source      = "./modules/heroku_pipeline_coupling"

  pipeline_id = "${module.heroku_pipeline.id}"
  staging_app = "${module.heroku_staging.name}"
  prod_app    = "${module.heroku_prod.name}"
}

# General settings - we use this to define general info about our app
variable "app_name" {
    default = "forumorg"
}
variable "app_url" {
    default = "forumorg.org"
}

# Application environment - it will be 'staging' or 'prod'
variable "app_environment" {}

# Defines whether our application is a debug version
# The default should be false
variable "app_debug" {
  default = "false"
}

# Authentication for the AWS provider - we use this access
# key in order to be able to create a new AWS user and the S3
# bucket that the application needs.
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "eu-west-3"
}

# Authentication for the Heroku provider - we use this access
# key in order to be able to create a new Heroku application
# and provision the addon
variable "heroku_email" {}
variable "heroku_api_key" {}

# Heroku app settings
# This is the name of the Heroku application that we will create
# This needs to be unique (no two accounts can have the same name)
variable "heroku_app_region" {
    default = "eu"
}
variable "s3_bucket" {
    default = "forumorg"
}

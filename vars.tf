# General settings
variable "app_name" {
  default = "forumorg"
}
variable "app_url" {
  default = "www.forumorg.org"
}

# AWS settings
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "eu-west-1"
}

# Heroku settings
variable "heroku_email" {}
variable "heroku_api_key" {}
variable "heroku_app_region" {
  default = "eu"
}

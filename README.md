# Terraform

## What is terraform
Terraform provides a common configuration to launch infrastructure — from physical and virtual servers to email and DNS providers. Once launched, Terraform safely and efficiently changes infrastructure as the configuration is evolved.

Simple file based configuration gives you a single view of your entire infrastructure.

https://www.terraform.io/

## Our infrastructure
This terraform repository is used to have a complete and accurate description of our organization's infrastructure, stored in a repository where it can be safely retrieved and updated at will.

The current configuration generates:
- a [Heroku pipeline](https://devcenter.heroku.com/articles/pipelines) with 2 environments ([staging](https://forumorg-staging.herokuapp.com) & [production](https://www.forumorg.org)), with [Review Apps](https://devcenter.heroku.com/articles/github-integration-review-apps) available and the following add-ons enabled:
    * [Compose](https://www.compose.com/databases/mongodb) for MongoDB hosting
    * [Papertrail](https://papertrailapp.com/) for cloud-hosted log management
    * [Sendgrid](https://sendgrid.com/) as our email delivery service
- 2 [S3](https://aws.amazon.com/s3/) storage buckets (staging & environment) for hosting file uploads in our application.
- a [CloudFront CDN](https://aws.amazon.com/fr/cloudfront/) used to offload static file hosting to a distributed storage system (internally, this uses a third additional S3 bucket).
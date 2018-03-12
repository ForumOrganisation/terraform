resource "heroku_pipeline_coupling" "staging" {
  app      = "${var.staging_app}"
  pipeline = "${var.pipeline_id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "prod" {
  app      = "${var.prod_app}"
  pipeline = "${var.pipeline_id}"
  stage    = "production"
}

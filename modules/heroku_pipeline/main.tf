resource "heroku_pipeline" "default" {
  name = "${var.pipeline_name}"
}

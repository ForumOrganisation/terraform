resource "heroku_domain" "default" {
  app  = "${var.app_name}"
  hostname = "${var.hostname}"
}

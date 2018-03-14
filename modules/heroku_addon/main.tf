resource "heroku_addon" "default" {
  app  = "${var.app_name}"
  plan = "${var.addon_plan}"
}

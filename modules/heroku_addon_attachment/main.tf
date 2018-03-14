resource "heroku_addon_attachment" "default" {
  app_id   = "${var.app_id}"
  addon_id = "${var.addon_id}"
  name     = "${var.name}"
}

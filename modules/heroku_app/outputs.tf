output "name" {
  value = "${heroku_app.default.name}"
}
output "vars" {
  value = "${heroku_app.default.all_config_vars}"
}

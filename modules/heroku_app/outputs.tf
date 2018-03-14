output "id" {
  value = "${heroku_app.default.id}"
}
output "name" {
  value = "${heroku_app.default.name}"
}
output "hostname" {
  value = "${heroku_app.default.heroku_hostname}"
}

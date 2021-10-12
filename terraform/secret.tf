resource "aws_secretsmanager_secret" "mysecretmanager" {
  name = "mysecret003"
}
resource "aws_secretsmanager_secret_version" "mysecretmanager" {
  secret_id     = aws_secretsmanager_secret.mysecretmanager.id
  secret_string = "mysecretvalue003"
}
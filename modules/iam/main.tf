resource "aws_iam_user" "this" {
  for_each = toset(var.usernames)
  name     = each.key
}

resource "aws_iam_access_key" "this" {
  for_each = toset(var.usernames)
  user     = aws_iam_user.this[each.key].name
}

resource "aws_secretsmanager_secret" "iam_user_credentials" {
  for_each = toset(var.usernames)
  name     = "iam-user-credentials-${each.key}" // Unique name for each secret
}

resource "aws_secretsmanager_secret_version" "iam_user_credentials_version" {
  for_each = toset(var.usernames)
  secret_id = aws_secretsmanager_secret.iam_user_credentials[each.key].id
  secret_string = jsonencode({
    access_key_id     = aws_iam_access_key.this[each.key].id
    secret_access_key = aws_iam_access_key.this[each.key].secret
  })
}

output "iam_user_credentials" {
  value = {
    for username in var.usernames :
    username => {
      secret_arn = aws_secretsmanager_secret.iam_user_credentials[username].arn
    }
  }
  sensitive = true
}
resource "aws_iam_user" "this" {
  for_each = toset(var.usernames)
  name     = each.key
}

resource "aws_iam_access_key" "this" {
  for_each = toset(var.usernames)
  user     = aws_iam_user.this[each.key].name
}

output "iam_user_credentials" {
  value = {
    for username in var.usernames :
    username => {
      access_key_id     = aws_iam_access_key.this[username].id
      secret_access_key = aws_iam_access_key.this[username].secret
    }
  }
  sensitive = true
}

resource "aws_secretsmanager_secret" "iam_secrets" {
  for_each = toset(var.usernames)

  name        = "iam/credentials/${each.key}"
  description = "Access credentials for IAM user ${each.key}"
  tags = {
    Owner  = "Terraform"
    Env    = var.environment
    Module = "IAM"
  }
}

resource "aws_secretsmanager_secret_version" "iam_secret_values" {
  for_each = toset(var.usernames)

  secret_id     = aws_secretsmanager_secret.iam_secrets[each.key].id
  secret_string = jsonencode({
    access_key_id     = aws_iam_access_key.this[each.key].id
    secret_access_key = aws_iam_access_key.this[each.key].secret
  })
  depends_on = [aws_iam_access_key.this]
}

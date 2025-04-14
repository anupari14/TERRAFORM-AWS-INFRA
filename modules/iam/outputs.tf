output "iam_usernames" {
  value = [for user in aws_iam_user.this : user.name]
}
output "iam_user_secrets" {
  value = {
    for user, secret in aws_secretsmanager_secret.iam_secrets :
    user => secret.arn
  }
}

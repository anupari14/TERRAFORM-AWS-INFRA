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
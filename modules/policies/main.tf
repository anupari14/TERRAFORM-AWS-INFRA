resource "aws_iam_group" "this" {
  name = var.group_name
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.name
  policy_arn = var.policy_arn
}

resource "aws_iam_user_group_membership" "membership" {
  for_each = toset(var.usernames)
  user     = each.key
  groups   = [aws_iam_group.this.name]
}
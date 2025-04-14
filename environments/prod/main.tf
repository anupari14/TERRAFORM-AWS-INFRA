provider "aws" {
  region = "ap-southeast-1"
}

module "iam_users" {
  source    = "../../modules/iam"
  usernames = var.usernames
}

module "admin_group" {
  source      = "../../modules/policies"
  group_name  = "admin-group"
  policy_arn  = "arn:aws:iam::aws:policy/AdministratorAccess"
  usernames   = var.usernames
}
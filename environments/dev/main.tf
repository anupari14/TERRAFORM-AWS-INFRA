provider "aws" {
  region = "ap-southeast-2"
}

module "iam_users" {
  source    = "../../modules/iam"
  usernames = var.usernames
  environment = "dev"
}
provider "aws" {
  region = "ap-southeast-2"
}

module "iam_users" {
  source    = "../../modules/iam"
  usernames = var.usernames
  environment = "dev"
}

module "vpc" {
  source              = "../../modules/vpc"
  environment         = "dev"
}

module "rds_postgres" {
  source      = "../../modules/rds"
  environment = "dev"
  db_name     = "ccfraud"
  username    = "postgresadmin"
  password    = "securepass123!"
  allowed_cidrs = ["0.0.0.0/0"]
}

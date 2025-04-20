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
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.private_subnet_ids
}

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
  allowed_cidrs = ["10.0.0.0/16"]
}

module "ec2_webserver" {
  source      = "../../modules/ec2"
  environment = "dev"
  ami_id      = "ami-0f5ee92e2d63afc18"  # Ubuntu 22.04 in ap-southeast-1
  subnet_id   = module.vpc.public_subnet_ids[0]
  vpc_id      = module.vpc.vpc_id
  key_name    = "anupariti-ec2-key"
  allowed_cidrs = ["0.0.0.0/0"]
}

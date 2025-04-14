terraform {
  backend "s3" {
    bucket         = "my-iac-terraform-state"
    key            = "env/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
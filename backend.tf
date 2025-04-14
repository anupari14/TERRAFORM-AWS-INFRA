terraform {
  backend "s3" {
    bucket         = "ccfraud-iac-terraform-state"
    key            = "env/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "ccfraud-terraform-locks"
    encrypt        = true
  }
}
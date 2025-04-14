variable "region" {
  default = "ap-southeast-2"
}

variable "bucket_name" {
  default = "my-iac-terraform-state"
}

variable "lock_table_name" {
  default = "terraform-locks"
}

variable "tags" {
  type = map(string)
  default = {
    ManagedBy = "Terraform"
    Owner     = "Anusha"
    Project   = "terraform-aws-infra"
  }
}

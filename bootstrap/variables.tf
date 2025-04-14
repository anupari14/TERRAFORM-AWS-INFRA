variable "region" {
  default = "ap-southeast-2"
}

variable "bucket_name" {
  default = "ccfraud-iac-terraform-state"
}

variable "lock_table_name" {
  default = "ccfraud-terraform-locks"
}

variable "tags" {
  type = map(string)
  default = {
    ManagedBy = "Terraform"
    Owner     = "Anusha"
    Project   = "terraform-aws-infra"
  }
}

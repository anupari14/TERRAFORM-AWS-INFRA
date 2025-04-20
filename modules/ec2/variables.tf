variable "environment" {}
variable "subnet_id" {
  description = "Public subnet to launch instance in"
}
variable "vpc_id" {}
variable "key_name" {
  description = "SSH key pair name"
}
variable "allowed_cidrs" {
  type = list(string)
  default = ["0.0.0.0/0"]  # For dev, replace with your IPs for prod
}
variable "aws_region" {
  type    = string
  default = "ap-southeast-2"  # or your actual region
}


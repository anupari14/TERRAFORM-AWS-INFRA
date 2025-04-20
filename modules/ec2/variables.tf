variable "environment" {}
variable "ami_id" {
  description = "AMI ID for Ubuntu 22.04"
}
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

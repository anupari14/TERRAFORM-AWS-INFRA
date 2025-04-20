variable "environment" {}
variable "db_name" {}
variable "username" {}
variable "password" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "allowed_cidrs" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

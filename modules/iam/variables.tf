variable "usernames" {
  type = list(string)
}
variable "environment" {
  type        = string
  description = "Environment identifier (e.g., dev, staging, prod)"
}

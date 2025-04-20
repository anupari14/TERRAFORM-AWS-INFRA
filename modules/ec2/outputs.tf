output "instance_public_ip" {
  value = aws_instance.webserver.public_ip
}

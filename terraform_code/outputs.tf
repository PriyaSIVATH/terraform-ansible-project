output "public-ip-address" {
  value = aws_instance.target-server.public_ip
}

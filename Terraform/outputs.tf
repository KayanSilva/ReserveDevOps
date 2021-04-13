output "ips" {
  value = aws_instance.dev4[0].public_ip
}
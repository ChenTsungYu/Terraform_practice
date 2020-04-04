output "aws_security_group_http_server_detail" {
  value = aws_security_group.http_server_sg
}

output "aws_http_server_public_dns_detail" {
  value = aws_instance.http_server.public_dns
}
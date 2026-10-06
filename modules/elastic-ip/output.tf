output "public_ip" {
  description = "Public IP address of the Elastic IP"
  value       = aws_eip.aws_assignment_eip.public_ip
}
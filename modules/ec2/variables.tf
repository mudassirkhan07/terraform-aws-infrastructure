variable "ami_id" {
  description = "AMI ID used to launch the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the EC2 instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs attached to the EC2 instance"
  type        = list(string)
}

variable "name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "user_data" {
  description = "User data script to configure the EC2 instance"
  type        = string
  default     = <<-EOF
              #!bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              EOF
}
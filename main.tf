module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                  = "10.0.0.0/16"
  public_subnet_cidr        = "10.0.1.0/24"
  private_subnet_cidr       = "10.0.2.0/24"
  public_availability_zone  = "us-east-1a"
  private_availability_zone = "us-east-1b"

  name = "assignment-vpc"
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id = module.vpc.vpc_id
  name   = "assignment-ec2-sg"
}

module "ec2" {
  source = "./modules/ec2"

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.security_group.security_group_id]

  name = "assignment-ec2"
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}

module "lambda" {
  source = "./modules/lambda"

  function_name = "terraform-test-function"
  runtime       = "python3.12"
  zip_file      = "${path.root}/lambda/function.zip"
  handler       = "lambda_function.lambda_handler"
}

module "elastic_ip" {
  source = "./modules/elastic-ip"

  instance_id = module.ec2.instance_id
  name        = "assignment-ec2-eip"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  instance_id = module.ec2.instance_id
}
# Terraform AWS Infrastructure

A modular **Infrastructure as Code (IaC)** project using **Terraform** to provision and manage AWS infrastructure. This project demonstrates how multiple AWS services can be deployed, configured, and connected together using reusable Terraform modules.

## 🚀 Project Overview

This project provisions an AWS environment containing:

* Amazon VPC
* Public and Private Subnets
* Internet Gateway
* Public Route Table
* Security Group
* Amazon EC2
* Elastic IP
* Amazon S3
* AWS Lambda
* IAM Role and Policy
* Amazon CloudWatch Alarm

The infrastructure is managed entirely through Terraform, making it easier to create, modify, and reproduce the environment.

---

## 🏗️ Architecture

```text
                         AWS Cloud
                            │
                     ┌──────┴──────┐
                     │     VPC     │
                     │             │
              ┌──────┴──────┐      │
              │    Public   │      │
              │   Subnet    │      │
              │             │      │
              │    EC2      │      │
              │     │       │      │
              │ Elastic IP  │      │
              └──────┬──────┘      │
                     │              │
              Internet Gateway      │
                                    │
              ┌─────────────────────┤
              │                     │
        Private Subnet              │
                                    │
        ┌───────────────┐           │
        │   Private     │           │
        │   Resources   │           │
        └───────────────┘           │
                                    │
        ┌───────────────┐    ┌──────┴──────┐
        │      S3       │    │   Lambda    │
        │    Bucket     │    │   Function  │
        └───────────────┘    └──────┬──────┘
                                    │
                               IAM Role
                                    │
                             CloudWatch Alarm
```

---

## ☁️ AWS Services Used

| AWS Service          | Purpose                                             |
| -------------------- | --------------------------------------------------- |
| **Amazon VPC**       | Creates the isolated AWS network                    |
| **Subnet**           | Separates public and private resources              |
| **Internet Gateway** | Provides internet connectivity to the public subnet |
| **Route Table**      | Controls network traffic routing                    |
| **EC2**              | Hosts the web server                                |
| **Elastic IP**       | Provides a static public IP address for EC2         |
| **Security Group**   | Controls inbound and outbound traffic               |
| **S3**               | Provides object storage                             |
| **AWS Lambda**       | Runs serverless code                                |
| **IAM**              | Provides permissions for Lambda                     |
| **CloudWatch**       | Monitors EC2 CPU utilization                        |

---

## 📁 Project Structure

```text
terraform-aws/
│
├── .gitignore
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
│
├── modules/
│   │
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── elastic_ip/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── lambda/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── cloudwatch/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── ...
```

---

# 🔧 Prerequisites

Before deploying the infrastructure, install:

* Terraform
* AWS CLI
* Git

Verify Terraform:

```powershell
terraform version
```

Verify AWS CLI:

```powershell
aws --version
```

Configure AWS CLI:

```powershell
aws configure
```

Set the default region:

```text
us-east-1
```

Verify your AWS credentials:

```powershell
aws sts get-caller-identity
```

---

# 🚀 Deployment

## 1. Clone the Repository

```bash
git clone <YOUR-GITHUB-REPOSITORY-URL>
```

Navigate to the project:

```bash
cd terraform-aws
```

---

## 2. Initialize Terraform

```bash
terraform init
```

This initializes the Terraform working directory and downloads the required providers.

---

## 3. Validate Configuration

```bash
terraform validate
```

Expected output:

```text
Success! The configuration is valid.
```

---

## 4. Format Terraform Files

```bash
terraform fmt -recursive
```

---

## 5. Review the Execution Plan

```bash
terraform plan
```

Terraform displays the resources that will be created, modified, or destroyed.

---

## 6. Deploy the Infrastructure

```bash
terraform apply
```

Confirm by entering:

```text
yes
```

Terraform then provisions the AWS infrastructure.

---

# 🖥️ EC2 Configuration

The project creates an EC2 instance using:

```text
Instance Type: t3.micro
Region: us-east-1
```

The EC2 instance uses an AWS Key Pair and receives a public IP address.

Nginx is automatically installed using EC2 user data:

```bash
#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
```

Once the instance is running, the Nginx web server can be accessed through the EC2 public IP when HTTP traffic is allowed by the Security Group.

---

# 📊 CloudWatch Monitoring

A CloudWatch alarm monitors EC2 CPU utilization.

Configuration:

```text
Metric: CPUUtilization
Namespace: AWS/EC2
Statistic: Average
Period: 120 seconds
Evaluation Periods: 2
Threshold: 80%
Condition: GreaterThanOrEqualToThreshold
```

Alarm name:

```text
assignment-ec2-high-cpu
```

The alarm helps monitor high CPU utilization on the EC2 instance.

---

# 🪣 Amazon S3

The project creates and manages an Amazon S3 bucket using Terraform.

The bucket is configured with versioning, allowing different versions of objects to be maintained.

Terraform manages the S3 configuration instead of manually creating the bucket through the AWS Console.

---

# ⚡ AWS Lambda

The project creates a Lambda function:

```text
terraform-test-function
```

The Lambda function uses an IAM role with:

```text
AWSLambdaBasicExecutionRole
```

This allows Lambda to write execution logs to Amazon CloudWatch Logs.

---

# 🌐 Networking

The project creates a custom VPC containing public and private subnets.

### Public Subnet

The public subnet hosts the EC2 instance and uses the Internet Gateway for internet connectivity.

### Private Subnet

A separate private subnet is created for resources that should not directly receive public internet access.

### Internet Gateway

The Internet Gateway allows resources in the public subnet to communicate with the internet.

### Route Table

The public route table controls traffic from the public subnet toward the Internet Gateway.

### Security Group

The Security Group controls inbound and outbound network traffic for the EC2 instance.

---

# 📤 Terraform Outputs

After running:

```bash
terraform apply
```

Terraform displays useful infrastructure information such as:

```text
bucket_arn
bucket_name
elastic_ip_public_ip
instance_id
instance_public_ip
lambda_function_arn
lambda_function_name
private_subnet_id
public_subnet_id
security_group_id
vpc_id
```

View all outputs again:

```bash
terraform output
```

View a specific output:

```bash
terraform output instance_public_ip
```

---

# 🧹 Destroy Infrastructure

When the infrastructure is no longer required, it can be removed using:

```bash
terraform destroy
```

Confirm with:

```text
yes
```

> **Important:** Review the destroy plan carefully before confirming.

---

# 🔐 Security

Sensitive files should never be committed to GitHub.

The `.gitignore` file excludes:

```text
*.tfstate
*.tfstate.*
.terraform/
*.tfvars
*.pem
.env
```

Never commit:

* AWS Access Keys
* AWS Secret Keys
* Private SSH Keys
* Terraform State Files
* Passwords
* API Tokens

AWS credentials should be managed securely using the AWS CLI, IAM roles, environment variables, or other secure credential mechanisms.

---

# 📚 Key Concepts Demonstrated

This project demonstrates practical experience with:

* Infrastructure as Code
* Terraform
* Terraform Modules
* Terraform Variables
* Terraform Outputs
* Terraform State
* Terraform Providers
* AWS VPC
* Public and Private Subnets
* Internet Gateway
* Route Tables
* Security Groups
* Amazon EC2
* Elastic IP
* Amazon S3
* AWS Lambda
* IAM Roles and Policies
* Amazon CloudWatch
* AWS CLI
* Nginx
* Linux
* Git and GitHub

---

# 🛠️ Technologies Used

```text
Terraform
AWS
AWS CLI
Amazon EC2
Amazon VPC
Amazon S3
AWS Lambda
AWS IAM
Amazon CloudWatch
Nginx
Linux
Git
GitHub
```

---

# 👨‍💻 Author

**Mohd Mudassir Khan**

Computer Science Engineering

### Interests

* ☁️ Cloud Computing
* 🚀 DevOps
* 🔐 Cloud Security
* 🏗️ Infrastructure as Code
* 🛠️ Terraform
* 🐳 Docker
* ☸️ Kubernetes
* ☁️ AWS

---

## ⭐ Project Purpose

This project was built as a hands-on **Terraform and AWS infrastructure project** to gain practical experience with Infrastructure as Code.

Instead of manually creating AWS resources through the AWS Management Console, Terraform is used to define, provision, and manage cloud infrastructure in a repeatable and automated way.
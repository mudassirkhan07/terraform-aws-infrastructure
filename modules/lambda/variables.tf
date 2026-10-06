variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime used by the Lambda function"
  type        = string
}

variable "zip_file" {
  description = "Path to the Lambda function ZIP file"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
}

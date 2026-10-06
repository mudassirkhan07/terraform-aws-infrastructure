resource "aws_iam_role" "aws_server_lambda_role" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_server_lambda_policy" {
  role       = aws_iam_role.aws_server_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "aws_server_lambda" {
  function_name = var.function_name
  runtime       = var.runtime
  role          = aws_iam_role.aws_server_lambda_role.arn

  filename         = var.zip_file
  source_code_hash = filebase64sha256(var.zip_file)

  handler = var.handler
}
resource "aws_s3_bucket" "aws_server_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_versioning" "aws_server_bucket_versioning" {
  bucket = aws_s3_bucket.aws_server_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "aws_server_bucket_public_access_block" {
  bucket = aws_s3_bucket.aws_server_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
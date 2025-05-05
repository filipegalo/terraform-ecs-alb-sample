resource "aws_s3_bucket" "state_bucket" {
  bucket = "tf-${var.project_name}-state"

  tags = var.tags
}


resource "aws_s3_bucket_versioning" "state_bucket_versioning" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

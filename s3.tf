resource "aws_s3_bucket" "one" {
  bucket = "ruksar.devops.project.bucket"
}

resource "aws_s3_bucket_ownership_controls" "two" {
  bucket = aws_s3_bucket.one.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "four" {
  depends_on = [aws_s3_bucket.one]  # Direct dependency on the bucket

  bucket = aws_s3_bucket.one.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "five" {
  bucket = aws_s3_bucket.one.id

  versioning_configuration {
    status = "Enabled"
  }
}
terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "ruksar.devops.project.bucket"
    key    = "prod/terraform.tfstate"
  }
}



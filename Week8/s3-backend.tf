resource "aws_s3_bucket" "terraform_state" {
  bucket = var.aws_s3_bucket
}

resource "aws_s3_bucket_versioning" "state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}




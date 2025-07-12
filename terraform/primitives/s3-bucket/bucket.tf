locals {
  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
      mode = var.mode
    }
  )
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags = var.tags
  force_destroy = var.force_destroy_bucket
  
  object_lock_enabled = var.object_lock_enabled
}

resource "aws_s3_bucket_ownership_controls" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.ownership_controls
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl = var.acl
  count = var.ownership_controls == "BucketOwnershipEnforced" ? 0 : 1

  depends_on = [
    aws_s3_bucket_ownership_controls.bucket
  ]
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }

  count = var.versioning_enabled ? 1 : 0
}

data "aws_kms_alias" "s3" {
  name = var.s3_encryption_key_alias
  count = var.s3_encryption_key_alias == "" ? 0 : 1
}

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
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }

  count = var.versioning_enabled ? 1 : 0
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.s3_encryption_key_alias != "" ? "aws:kms" : "AES256"
      kms_master_key_id =  var.s3_encryption_key_alias != "" ? data.aws_kms_alias.s3[0].arn : null
    }
    bucket_key_enabled = var.s3_encryption_key_alias != "" ? true : null
  }
  count = var.encryption_enabled ? 1 : 0
}

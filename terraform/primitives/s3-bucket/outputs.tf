output "arn" {
  value = aws_s3_bucket.bucket.arn
}

output "bucket" {
  value = aws_s3_bucket.bucket
}

output "id" {
  value = aws_s3_bucket.bucket.id
}

output "region" {
  value = data.aws_region.current.region
}

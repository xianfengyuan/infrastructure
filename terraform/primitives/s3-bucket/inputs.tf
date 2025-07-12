variable "acl" {
  type = string
  description = "ACL to apply to bucket"
  default = "private"
}

variable "mode" {
  type = string
  description = "deploymenty mode"
}

variable "bucket_name" {
  type = string
  description = "Override bucket name if not in default pattern"
  default = ""
}

variable "force_destroy_bucket" {
  type = bool
  default = false
}

variable "object_lock_enabled" {
  type = bool
  default = false
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "ownership_controls" {
  type = string
  default = "BucketOwnerPreferred"
  description = <<-EOT
    If "BucketOwnerEnforced" is defined, bucket ACL is disabled
  EOT
}

variable "versioning_enabled" {
  type = bool
  default = true
}

variable "s3_encryption_key_alias" {
  type = string
  default = ""
}

variable "encryption_enabled" {
  type = bool
  default = true
}

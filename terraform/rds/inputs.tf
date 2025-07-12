variable "mode" {
  type = string
}

variable "version_string" {
  type = string
}

variable "role" {
  type = string
  default = "simplebank"
}

variable "additional_tags" {
  type = map(string)
  default = {}
}

variable "owner_email" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "db_parameter_group_name" {
  type = string
}

variable "instance_class" {
  type = string
  default = "db.t3.small"
}

variable "allocated_storage" {
  type = number
  default = 10
}

variable "skip_final_snapshot" {
  type = bool
  default = true
}

variable "vpc_id" {
  type = string
}

variable "db_subnets" {
  type = list(string)
}

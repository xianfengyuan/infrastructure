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

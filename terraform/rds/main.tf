locals {
  deployment_name = "${var.role}-${var.mode}-${var.version_string}"

  tags = merge(
    var.additional_tags,
    {
      OwnedBy = var.owner_email
      mode = var.mode
      Name = "DB@${local.deployment_name}"
    }
  )
}

resource "aws_db_instance" "rds_db" {
  instance_class = var.mode != "prod" ? "db.t3.small" : "db.m5.large"
  identifier = "${local.deployment_name}-db"
  engine = "postgres"
  username = var.username
  password = var.password

  parameter_group_name = var.db_parameter_group_name

  tags = local.tags

  lifecycle {
    ignore_changes = [ 
      engine_version,
      password
     ]
  }
}

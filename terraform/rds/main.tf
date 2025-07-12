locals {
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
  instance_class = var.instance_class
  identifier = "${local.deployment_name}-db"
  engine = "postgres"
  username = var.username
  password = var.password

  parameter_group_name = var.db_parameter_group_name
  allocated_storage = var.allocated_storage
  skip_final_snapshot = var.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.db_base_sg.id, aws_security_group.db_internal_sg.id]

  tags = local.tags

  lifecycle {
    ignore_changes = [ 
      engine_version,
      password
     ]
  }
}

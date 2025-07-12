resource "aws_default_security_group" "db_default_sg" {
  vpc_id = var.vpc_id
  tags = merge(var.additional_tags, {
    Name = "DefaultSG@${local.deployment_name}"
  })
}

resource "aws_security_group" "db_base_sg" {
  name = "BaseSG@${local.deployment_name}"
  vpc_id = var.vpc_id

  ingress {
    protocol = -1
    self = true
    from_port = 0
    to_port = 0
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = merge(var.additional_tags, {
    Name = "BaseSG@${local.deployment_name}"
  })
}

resource "aws_security_group" "db_internal_sg" {
  name = "InternalSG@${local.deployment_name}"
  vpc_id = var.vpc_id

  ingress {
    protocol = "tcp"
    from_port = 5432
    to_port = 5432
    cidr_blocks = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  }

  tags = merge(var.additional_tags, {
    Name = "InternalSG@${local.deployment_name}"
  })
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "DBSubnetGrp@${local.deployment_name}"
  subnet_ids = var.db_subnets
}

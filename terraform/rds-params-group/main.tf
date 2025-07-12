resource "aws_db_parameter_group" "postgres_16" {
  family = "postgres16"
  name = "${var.db_app_name}-pg16-param-group"

  parameter {
    name = "ssl_min_protocol_version"
    value = "TLSv1.2"
  }

  parameter {
    name = "pgaudit.log"
    value = "ddl,write"
  }
}

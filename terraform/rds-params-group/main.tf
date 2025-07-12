resource "aws_db_parameter_group" "postgres" {
  family = "postgres16"
  name = "${var.db_app_name}-pg-param-group"

  parameter {
    name = "ssl_min_protocol_version"
    value = "TLSv1.2"
  }

  parameter {
    name = "pgaudit.log"
    value = "ddl,write"
  }
}

resource "aws_db_parameter_group" "psotgres_18" {
  family = "postgres18"
  name = "${var.db_app_name}-pg18-param-group"

  parameter {
    name = "ssl_min_protocol_version"
    value = "TLSv1.2"
  }

  parameter {
    name = "pgaudit.log"
    value = "ddl,write"
  }
}


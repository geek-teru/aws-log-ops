resource "aws_glue_catalog_database" "logs" {
  name = "${var.env}_${var.sys_name}_logs"
}

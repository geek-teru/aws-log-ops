locals {
  columns = [
    {
      name        = "dt"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "awsaccountid"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "awsregion"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "resourcetype"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "resourceid"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "resourcename"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "arn"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "tags"
      hive_type   = "map<string,string>"
      presto_type = "map(varchar,varchar)"
    },
    {
      name        = "configurationitemversion"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "configurationitemcapturetime"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "configurationstateid"
      hive_type   = "bigint"
      presto_type = "bigint"
    },
    {
      name        = "configurationitemstatus"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "configurationstatemd5hash"
      hive_type   = "string",
      presto_type = "varchar",
    },
    {
      name        = "relatedevents"
      hive_type   = "array<string>"
      presto_type = "array(varchar)"
    },
    {
      name        = "relationships"
      hive_type   = "array<string>"
      presto_type = "array(varchar)"
    },
    {
      name        = "supplementaryconfiguration"
      hive_type   = "map<string,string>"
      presto_type = "map(varchar,varchar)"
    }
  ]

  view_text = jsonencode({
    originalSql = file("${path.module}/sql/config_view.sql"),
    catalog     = "awsdatacatalog",
    schema      = aws_glue_catalog_database.logs.name,
    columns     = [for c in local.columns : { name = c.name, type = c.presto_type }],
  })

}

resource "aws_glue_catalog_table" "config_logs_view" {
  name          = "config_logs_view_new"
  database_name = aws_glue_catalog_database.logs.name
  table_type    = "VIRTUAL_VIEW"

  storage_descriptor {
    dynamic "columns" {
      for_each = local.columns
      content {
        name = columns.value.name
        type = columns.value.hive_type
      }
    }
  }

  view_original_text = "/* Presto View: ${base64encode(local.view_text)} */"

  parameters = {
    presto_view = "true"
  }
}

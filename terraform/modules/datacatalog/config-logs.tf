resource "aws_glue_catalog_table" "config_logs" {
  name          = "config_logs"
  database_name = aws_glue_catalog_database.logs.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "projection.dt.range"         = "2020/01/01,NOW"
    "projection.dt.digits"        = "2"
    "projection.dt.interval.unit" = "DAYS"
    "EXTERNAL"                    = "TRUE"
    "projection.dt.type"          = "date"
    "projection.enabled"          = "true"
    "projection.dt.interval"      = "1"
    "projection.dt.format"        = "yyyy/M/d"
    "storage.location.template"   = "s3://${var.logs_bucket_name}/Config/AWSLogs/${var.aws_account_id}/Config/ap-northeast-1/$${dt}/ConfigHistory/"
  }

  storage_descriptor {
    location      = "s3://${var.logs_bucket_name}/Config/AWSLogs/${var.aws_account_id}/Config/ap-northeast-1"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat"

    columns {
      name = "fileversion"
      type = "string"
    }

    columns {
      name = "configurationitems"
      type = "array<struct<relatedEvents:array<string>,relationships:array<string>,supplementaryConfiguration:map<string,string>,tags:map<string,string>,configurationItemVersion:string,configurationItemCaptureTime:string,configurationStateId:bigint,awsAccountId:string,configurationItemStatus:string,resourceType:string,resourceId:string,resourceName:string,ARN:string,awsRegion:string,configurationStateMd5Hash:string>>"
    }

    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
      parameters = {
        "serialization.format" = "1"
      }
    }
  }

  partition_keys {
    name = "dt"
    type = "string"
  }
}

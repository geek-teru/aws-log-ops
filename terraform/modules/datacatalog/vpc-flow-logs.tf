# resource "aws_glue_catalog_table" "vpc_flow_logs" {
#   name          = "vpc_flow_logs"
#   database_name = aws_glue_catalog_database.logs.name
#   table_type    = "EXTERNAL_TABLE"

#   parameters = {
#     "projection.dt.range"         = "2020/01/01,NOW"
#     "projection.dt.interval.unit" = "DAYS"
#     "EXTERNAL"                    = "TRUE"
#     "projection.dt.type"          = "date"
#     "projection.enabled"          = "true"
#     "projection.dt.interval"      = "1"
#     "projection.dt.format"        = "yyyy/MM/dd"
#     "storage.location.template"   = "s3://${var.logs_bucket_name}/${var.env}/vpc-flow-logs/${var.vpc_id}/AWSLogs/${var.aws_account_id}/vpcflowlogs/ap-northeast-1/$${dt}"
#   }

#   storage_descriptor {
#     location      = "s3://${var.logs_bucket_name}/VpcFlowLogs/${var.vpc_id}/AWSLogs/${var.aws_account_id}/vpcflowlogs/ap-northeast-1"
#     input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
#     output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

#     columns {
#       name = "account_id"
#       type = "string"
#     }

#     columns {
#       name = "action"
#       type = "string"
#     }

#     columns {
#       name = "az_id"
#       type = "string"
#     }

#     columns {
#       name = "bytes"
#       type = "bigint"
#     }

#     columns {
#       name = "dstaddr"
#       type = "string"
#     }

#     columns {
#       name = "dstport"
#       type = "int"
#     }

#     columns {
#       name = "end"
#       type = "bigint"
#     }

#     columns {
#       name = "flow_direction"
#       type = "string"
#     }

#     columns {
#       name = "instance_id"
#       type = "string"
#     }

#     columns {
#       name = "interface_id"
#       type = "string"
#     }

#     columns {
#       name = "log_status"
#       type = "string"
#     }

#     columns {
#       name = "packets"
#       type = "int"
#     }

#     columns {
#       name = "pkt_dst_aws_service"
#       type = "string"
#     }

#     columns {
#       name = "pkt_dstaddr"
#       type = "string"
#     }

#     columns {
#       name = "pkt_src_aws_service"
#       type = "string"
#     }

#     columns {
#       name = "pkt_srcaddr"
#       type = "string"
#     }

#     columns {
#       name = "protocol"
#       type = "int"
#     }

#     columns {
#       name = "region"
#       type = "string"
#     }

#     columns {
#       name = "srcaddr"
#       type = "string"
#     }

#     columns {
#       name = "srcport"
#       type = "int"
#     }

#     columns {
#       name = "start"
#       type = "bigint"
#     }

#     columns {
#       name = "sublocation_id"
#       type = "string"
#     }

#     columns {
#       name = "sublocation_type"
#       type = "string"
#     }

#     columns {
#       name = "subnet_id"
#       type = "string"
#     }

#     columns {
#       name = "tcp_flags"
#       type = "int"
#     }

#     columns {
#       name = "traffic_path"
#       type = "int"
#     }

#     columns {
#       name = "version"
#       type = "int"
#     }

#     columns {
#       name = "vpc_id"
#       type = "string"
#     }

#     columns {
#       name = "type"
#       type = "string"
#     }

#     ser_de_info {
#       serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
#       parameters = {
#         "serialization.format" = "1"
#       }
#     }
#   }

#   partition_keys {
#     name = "dt"
#     type = "string"
#   }
# }

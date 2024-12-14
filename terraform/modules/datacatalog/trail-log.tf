resource "aws_glue_catalog_table" "trail_logs" {
  name          = "trail_logs"
  database_name = aws_glue_catalog_database.logs.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    "EXTERNAL"                    = "TRUE"
    "projection.enabled"          = "true"
    "projection.dt.range"         = "2020/01/01,NOW"
    "projection.dt.interval.unit" = "DAYS"
    "projection.dt.type"          = "date"
    "projection.dt.interval"      = "1"
    "projection.dt.format"        = "yyyy/MM/dd"
    "projection.region.type"      = "enum"
    "projection.region.values"    = "ap-south-2,ap-south-1,eu-south-1,eu-south-2,me-central-1,il-central-1,ca-central-1,eu-central-1,eu-central-2,us-west-1,us-west-2,af-south-1,eu-north-1,eu-west-3,eu-west-2,eu-west-1,ap-northeast-3,ap-northeast-2,me-south-1,ap-northeast-1,sa-east-1,ap-east-1,ca-west-1,ap-southeast-1,ap-southeast-2,ap-southeast-3,ap-southeast-4,us-east-1,ap-southeast-5,us-east-2"
    "storage.location.template"   = "s3://${var.logs_bucket_name}/Trail/AWSLogs/${var.aws_account_id}/CloudTrail/$${region}/$${dt}"
  }

  storage_descriptor {
    location      = "s3://${var.logs_bucket_name}/Trail/AWSLogs/${var.aws_account_id}/CloudTrail/"
    input_format  = "com.amazon.emr.cloudtrail.CloudTrailInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    columns {
      name = "eventversion"
      type = "string"
    }

    columns {
      name = "useridentity"
      type = "struct<type:string,principalId:string,arn:string,accountId:string,invokedBy:string,accessKeyId:string,userName:string,onBehalfOf:struct<userId:string,identityStoreArn:string>,sessionContext:struct<attributes:struct<mfaAuthenticated:string,creationDate:string>,sessionIssuer:struct<type:string,principalId:string,arn:string,accountId:string,userName:string>,ec2RoleDelivery:string,webIdFederationData:struct<federatedProvider:string,attributes:map<string,string>>>>"
    }

    columns {
      name = "eventtime"
      type = "string"
    }

    columns {
      name = "eventsource"
      type = "string"
    }

    columns {
      name = "eventname"
      type = "string"
    }

    columns {
      name = "awsregion"
      type = "string"
    }

    columns {
      name = "sourceipaddress"
      type = "string"
    }

    columns {
      name = "useragent"
      type = "string"
    }

    columns {
      name = "errorcode"
      type = "string"
    }

    columns {
      name = "errormessage"
      type = "string"
    }

    columns {
      name = "requestparameters"
      type = "string"
    }

    columns {
      name = "responseelements"
      type = "string"
    }

    columns {
      name = "additionaleventdata"
      type = "string"
    }

    columns {
      name = "requestid"
      type = "string"
    }

    columns {
      name = "eventid"
      type = "string"
    }

    columns {
      name = "readonly"
      type = "string"
    }

    columns {
      name = "resources"
      type = "array<struct<arn:string,accountId:string,type:string>>"
    }

    columns {
      name = "eventtype"
      type = "string"
    }

    columns {
      name = "apiversion"
      type = "string"
    }

    columns {
      name = "recipientaccountid"
      type = "string"
    }

    columns {
      name = "serviceeventdetails"
      type = "string"
    }

    columns {
      name = "sharedeventid"
      type = "string"
    }

    columns {
      name = "vpcendpointid"
      type = "string"
    }

    columns {
      name = "eventcategory"
      type = "string"
    }

    columns {
      name = "tlsdetails"
      type = "struct<tlsVersion:string,cipherSuite:string,clientProvidedHostHeader:string>"
    }

    ser_de_info {
      serialization_library = "org.apache.hive.hcatalog.data.JsonSerDe"
      parameters = {
        "serialization.format" = "1"
      }
    }
  }

  partition_keys {
    name = "region"
    type = "string"
  }

  partition_keys {
    name = "dt"
    type = "string"
  }
}

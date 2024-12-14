CREATE EXTERNAL TABLE config_logs (
  fileVersion string,
  configurationItems array<struct<
    relatedEvents: array<string>,
    relationships: array<string>,
    supplementaryConfiguration: map<string, string>,
    tags: map<string, string>,
    configurationItemVersion: string,
    configurationItemCaptureTime: string,
    configurationStateId: bigint,
    awsAccountId: string,
    configurationItemStatus: string,
    resourceType: string,
    resourceId: string,
    resourceName: string,
    ARN: string,
    awsRegion: string,
    configurationStateMd5Hash: string
  >>
)
PARTITIONED BY (
   `dt` string
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION
  's3://${bucket_name}/Config/AWSLogs/${aws_account_id}/Config/ap-northeast-1/'
TBLPROPERTIES (
  'projection.enabled'='true', 
  'projection.dt.format'='yyyy/M/d', 
  'projection.dt.interval'='1', 
  'projection.dt.interval.unit'='DAYS', 
  'projection.dt.range'='2020/01/01,NOW', 
  'projection.dt.type'='date', 
  'projection.dt.digits' = '2',
  'storage.location.template'='s3://${bucket_name}/Config/AWSLogs/${aws_account_id}/Config/ap-northeast-1/${dt}/ConfigHistory/'
);

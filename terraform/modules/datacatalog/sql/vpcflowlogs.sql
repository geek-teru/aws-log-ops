CREATE EXTERNAL TABLE vpc_flow_logs_new (
  account_id STRING,
  action STRING,
  az_id STRING,
  bytes BIGINT,
  dstaddr STRING,
  dstport INT,
  `end` BIGINT,
  flow_direction STRING,
  instance_id STRING,
  interface_id STRING,
  log_status STRING,
  packets INT,
  pkt_dst_aws_service STRING,
  pkt_dstaddr STRING,
  pkt_src_aws_service STRING,
  pkt_srcaddr STRING,
  protocol INT,
  region STRING,
  srcaddr STRING,
  srcport INT,
  `start` BIGINT,
  sublocation_id STRING,
  sublocation_type STRING,
  subnet_id STRING,
  tcp_flags INT,
  traffic_path INT,
  type STRING,
  version INT,
  vpc_id STRING
)
PARTITIONED BY (
   `dt` string
)
STORED AS PARQUET
LOCATION 's3://${bucket_name}/VpcFlowLogs/${vpc_id}/AWSLogs/${aws_account_id}/vpcflowlogs/ap-northeast-1/'
TBLPROPERTIES (
  'projection.enabled'='true', 
  'projection.dt.format'='yyyy/MM/dd', 
  'projection.dt.interval'='1', 
  'projection.dt.interval.unit'='DAYS', 
  'projection.dt.range'='2020/01/01,NOW', 
  'projection.dt.type'='date', 
  'storage.location.template' = 's3://${bucket_name}/VpcFlowLogs/${vpc_id}/AWSLogs/${aws_account_id}/vpcflowlogs/ap-northeast-1/${dt}'
);

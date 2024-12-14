CREATE EXTERNAL TABLE cloudtrail_logs(
    eventVersion STRING,
    userIdentity STRUCT<
        type: STRING,
        principalId: STRING,
        arn: STRING,
        accountId: STRING,
        invokedBy: STRING,
        accessKeyId: STRING,
        userName: STRING,
        onBehalfOf: STRUCT<
             userId: STRING,
             identityStoreArn: STRING>,
        sessionContext: STRUCT<
            attributes: STRUCT<
                mfaAuthenticated: STRING,
                creationDate: STRING>,
            sessionIssuer: STRUCT<
                type: STRING,
                principalId: STRING,
                arn: STRING,
                accountId: STRING,
                userName: STRING>,
            ec2RoleDelivery:string,
            webIdFederationData: STRUCT<
                federatedProvider: STRING,
                attributes: map<string,string>
            >
        >
    >,
    eventTime STRING,
    eventSource STRING,
    eventName STRING,
    awsRegion STRING,
    sourceIpAddress STRING,
    userAgent STRING,
    errorCode STRING,
    errorMessage STRING,
    requestparameters STRING,
    responseelements STRING,
    additionaleventdata STRING,
    requestId STRING,
    eventId STRING,
    readOnly STRING,
    resources ARRAY<STRUCT<
        arn: STRING,
        accountId: STRING,
        type: STRING>>,
    eventType STRING,
    apiVersion STRING,
    recipientAccountId STRING,
    serviceEventDetails STRING,
    sharedEventID STRING,
    vpcendpointid STRING,
    eventCategory STRING,
    tlsDetails struct<
        tlsVersion:string,
        cipherSuite:string,
        clientProvidedHostHeader:string>
)
PARTITIONED BY (
   `dt` string
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS INPUTFORMAT 'com.amazon.emr.cloudtrail.CloudTrailInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://${bucket_name}/trail/AWSLogs/${aws_account_id}/CloudTrail/'
TBLPROPERTIES (
  'projection.enabled'='true', 
  'projection.dt.format'='yyyy/MM/dd', 
  'projection.dt.interval'='1', 
  'projection.dt.interval.unit'='DAYS', 
  'projection.dt.range'='2020/01/01,NOW', 
  'projection.dt.type'='date',
  'projection.region.type'='enum',
  'projection.region.values'='ap-south-2,ap-south-1,eu-south-1,eu-south-2,me-central-1,il-central-1,ca-central-1,eu-central-1,eu-central-2,us-west-1,us-west-2,af-south-1,eu-north-1,eu-west-3,eu-west-2,eu-west-1,ap-northeast-3,ap-northeast-2,me-south-1,ap-northeast-1,sa-east-1,ap-east-1,ca-west-1,ap-southeast-1,ap-southeast-2,ap-southeast-3,ap-southeast-4,us-east-1,ap-southeast-5,us-east-2',
  'storage.location.template'='s3://${bucket_name}/trail/AWSLogs/${aws_account_id}/CloudTrail/${region}/${dt}'
);

resource "aws_cloudwatch_log_group" "trail_log_group" {
  name              = "${var.env}-${var.sys_name}-trail"
  retention_in_days = 7
}

resource "aws_cloudtrail" "trail" {
  name                          = "${var.sys_name}-${var.env}-trail"
  s3_bucket_name                = var.logs_bucket_name
  s3_key_prefix                 = "Trail"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.trail_log_group.arn}:*"
  cloud_watch_logs_role_arn  = var.trail_role_arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3"]
    }
  }
  depends_on = [aws_cloudwatch_log_group.trail_log_group]
}

module "iam" {
  source         = "../../modules/iam"
  env            = var.env
  sys_name       = var.sys_name
  aws_account_id = data.aws_caller_identity.current.account_id
}

module "s3" {
  source         = "../../modules/s3"
  env            = var.env
  sys_name       = var.sys_name
  aws_account_id = data.aws_caller_identity.current.account_id
}

module "trail" {
  source         = "../../modules/trail"
  env            = var.env
  sys_name       = var.sys_name
  aws_account_id = data.aws_caller_identity.current.account_id

  trail_role_arn   = module.iam.trail_role.arn
  logs_bucket_name = module.s3.logs_bucket.bucket
  depends_on       = [module.iam, module.s3]
}

module "config" {
  source   = "../../modules/config"
  env      = var.env
  sys_name = var.sys_name

  logs_bucket_name = module.s3.logs_bucket.bucket
  depends_on       = [module.s3]
}

# module "vpc_flow_log" {
#   source         = "../../modules/vpc-flow-log"
#   vpc_id = "" # dataで取得する。
#   logs_bucket_name = module.s3.logs_bucket.bucket
# }

module "datacatalog" {
  source         = "../../modules/datacatalog"
  env            = var.env
  sys_name       = var.sys_name
  aws_account_id = data.aws_caller_identity.current.account_id

  logs_bucket_name = module.s3.logs_bucket.bucket
}

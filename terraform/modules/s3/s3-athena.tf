# S3 Buckets

resource "aws_s3_bucket" "athena" {
  bucket              = "${var.aws_account_id}-${var.env}-${var.sys_name}-athena-query-result-bucket"
  object_lock_enabled = true

  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "athena_encryption" {
  bucket = aws_s3_bucket.athena.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" // SSE-S3
    }
  }
}

resource "aws_s3_bucket_public_access_block" "athena_public_access_block" {
  bucket                  = aws_s3_bucket.athena.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# resource "aws_s3_bucket_policy" "athena_policy" {
#   bucket = aws_s3_bucket.athena.id
#   policy = templatefile("${path.module}/policies/policy.json", {
#     bucket_arn = aws_s3_bucket.athena.arn,
#     account_id = var.aws_account_id
#   })
# }


output "athena_bucket" {
  value = aws_s3_bucket.athena
}

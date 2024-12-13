# iam_policy
resource "aws_iam_policy" "trail" {
  name   = "${var.env}-${var.sys_name}-trail"
  policy = file("${path.module}/policies/iam-policy-trail.json")
}

# iam role
resource "aws_iam_role" "trail" {
  name = "${var.env}-${var.sys_name}-trail"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      },
    ]
  })

}

resource "aws_iam_role_policy_attachment" "trail" {
  role       = aws_iam_role.trail.name
  policy_arn = aws_iam_policy.trail.arn
}

output "trail_role" {
  value = aws_iam_role.trail
}


resource "aviatrix_account" "aws_demo" {
  account_name       = "aws-demo"
  cloud_type         = 1
  aws_iam            = false
  aws_account_number = var.aws_account_number
  aws_access_key     = var.aws_access_key
  aws_secret_key     = var.aws_secret_key
}

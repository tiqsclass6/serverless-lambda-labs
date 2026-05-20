data "aws_caller_identity" "current" {}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "cognito_user_pool_name" {
  description = "Cognito User Pool Name"
  default     = "chewbacca-user-pool"
}
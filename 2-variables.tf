data "aws_caller_identity" "current" {}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}
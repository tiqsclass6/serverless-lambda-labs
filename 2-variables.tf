data "aws_caller_identity" "current" {}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

# variable "auth0_domain" {
#   description = "Auth0 Domain"
#   default     = "api.theinternationalquietstorm.com"
#   type        = string
# }

# variable "auth0_audience" {
#   description = "Auth0 Audience (API Identifier)"
#   default     = "https://api.theinternationalquietstorm.com"
#   type        = string
# }
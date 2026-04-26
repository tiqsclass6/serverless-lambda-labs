terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket  = "class-7-state-files"
    key     = "lambda-labs/lessonb.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
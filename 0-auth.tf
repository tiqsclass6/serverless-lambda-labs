terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.44.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.8.1"
    }
  }

  backend "s3" {
    bucket  = "class-7-state-files"
    key     = "lambda-labs/lessonb.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
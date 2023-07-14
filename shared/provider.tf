terraform {
  required_version = "v1.4.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
}

provider "aws" {
  region = var.target_region
}

provider "aws" {
  alias  = "north_virginia"
  region = "us-east-1"
}

# dynamically get account_id.
# data "aws_caller_identity" "current" {}

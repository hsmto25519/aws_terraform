terraform {
  required_version = "v1.5.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.66.0"
    }
  }
}

provider "aws" {
  region = var.target_region
  default_tags {
    tags = var.tags
  }
}

provider "aws" {
  alias  = "north_virginia"
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}

# dynamically get account_id.
# data "aws_caller_identity" "current" {}

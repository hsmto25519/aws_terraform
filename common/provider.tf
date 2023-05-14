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

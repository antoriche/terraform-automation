provider "aws" {
  region = var.region
}
provider "null" {}

terraform {
  backend "remote" {
    workspaces {
      prefix = "serverless-api_"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.34.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

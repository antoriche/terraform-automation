provider "aws" {
  region = var.region
}

terraform {
  backend "remote" {
    workspaces {
        prefix = "react-app_"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.34.0"
    }
  }
}
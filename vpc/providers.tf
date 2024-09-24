terraform {
  backend "s3" {
    bucket  = "wlopezob-devops"
    key     = "terraform-vpc.tfstate"
    region  = "us-west-2"
    encrypt = true

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.59.0"
    }
  }
}

provider "aws" {
  region = var.region
}
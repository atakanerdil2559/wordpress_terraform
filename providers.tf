terraform {
  required_version = "~> 0.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.25.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "/Users/nazgulkhalilova/.aws/credentials"
  profile                 = "default"
}
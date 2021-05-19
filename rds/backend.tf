terraform {
  backend "s3" {
    bucket = "nazy-tf-bucket"
    key    = "dev/rds.tfstate"
    region = "us-east-1"
  }
}
terraform {
  backend "s3" {
    bucket = "nazy-tf-bucket"
    key    = "dev/vpc.tfstate"
    region = "us-east-1"
  }
}
terraform {
  backend "s3" {
    bucket = "nazy-tf-bucket"
    key    = "dev/wordpress.tfstate"
    region = "us-east-1"
  }
}
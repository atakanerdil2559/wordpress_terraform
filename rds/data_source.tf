data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "nazy-tf-bucket"
    key    = "dev/vpc.tfstate"
    region = "us-east-1"
  }
}
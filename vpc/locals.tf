locals {
  common_tags = {
    Environment = var.env
    Project     = "${var.env}-wordpress"
    Team        = "development"
    Owner       = "nazy@gmail.com"
  }
}
variable "aws_region" {
  type        = string
  description = " aws region to deploys your infra"
  default     = "us-east-1"
}

variable "instance_class" {
  type        = string
  description = "cidr block for the vpc"
  default     = "db.t2.micro"
}

variable "env" {
  type        = string
  description = "name of the environment"
  default     = "dev"
}

variable "skip_snapshot" {
  type        = bool
  description = "skip snapshot if env is dev"
  default     = true
}
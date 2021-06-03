# Providers variables
variable "aws_region" {
  type        = string
  description = " aws region to deploys your infra"
}

# VPC variables
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for the vpc"
}

variable "instance_tenancy" {
  type        = string
  description = "the tenancy of existing VPCs from dedicated to default instantly"
}

variable "is_enabled_dns_support" {
  type        = bool
  description = "enabling dns support"
}

variable "is_enabled_dns_hostnames" {
  type        = bool
  description = "enabling dns hostnames"
}

variable "rt_cidr_block" {
  type        = string
  description = "route table cidr block"
}

# Subnet variables
variable "subnet_azs" {
  type        = list(string)
  description = "The availabitily zones where terraform deploys your infra"
}

variable "pub_cidr_subnet" {
  type        = list(string)
  description = "cird blocks for the public subnets"
}

variable "priv_cidr_subnet" {
  type        = list(string)
  description = "cidr blocks for the private subnets"
}

# Bastion variables
variable "instance_type" {
  type        = string
  description = "cidr block for the vpc"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "associate public ip address"
}

variable "key_name" {
  type    = string
  default = "new-key"
}

# Tags variables
variable "env" {
  type        = string
  description = "name of the environment"
}
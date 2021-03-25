variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "pub_cidr1_subnet" {
  description = "CIDR block for the  1st public subnet"
  default     = "10.0.1.0/24"
}
variable "pub_cidr2_subnet" {
  description = "CIDR block for the 2nd public subnet"
  default     = "10.0.2.0/24"
}
variable "priv_cidr1_subnet" {
  description = "CIDR block for the 1st private subnet"
  default     = "10.0.11.0/24"
}
variable "priv_cidr2_subnet" {
  description = "CIDR block for the 2nd private subnet"
  default     = "10.0.12.0/24"
}
variable "region_1a" {
  description = "The region Terraform deploys your instance"
  default = "us-east-1a"
}
variable "region_1b" {
  description = "The region Terraform deploys your instance"
  default = "us-east-1b"
}
variable "env" {
    description = "name of the environment"
    default = "dev"
    type = string
}
variable "instance_type" {
    description = "instance type"
    default = "t2.micro"
    type = string
}
variable "instance_class" {
    description = "instance type"
    default = "db.t2.micro"
    type = string
}
variable "storage_type" {
    description = "storage type"
    default = "g2"
    type = string
}
variable "engine" {
    description = "engine"
    default = "mariadb"
    type = string
}
variable "engine_version" {
    description = "engine version"
    default = "10.1.14"
    type = string
}
variable "allocated_storage" {
    description = "allocated storage"
    default = "20"
    type = string
}
variable "username" {
    description = "username"
    default = "admin"
    type = string
}
variable "database_name" {
    description = "datase name"
    default = "wordpessdb"
    type = string
}
variable "ssh_key_name" {
    description = "ssh_key_name"
    default = "Nazy'sMacKey"
    type = string
}
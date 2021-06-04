Work In Progress
# Wordpress with bastion using Terraform

 ## Prerequisites:
   - AWS account
   - Terraform installed version 0.14
   - SSL Certificate
   - Existing SSH key
   - Domain Name

## Resources

- VPC
  - 3 Public Subnets
  - 3 Private Subnets
  - Public Route Table
  - Private Route Table
  - Elastic IP
  - Internet Gateway
  - Nat Gateway
  - Public/Private Route Table Association

- Security Groups
  - Bastion Secirity Group
  - Webserver Security Group 
  - RDS Security Group
  - Application Load Balancer Security Group

- Bastion Host

- Application Load Balacer
  - Target Group
  - HTTP Listener
  - HTTPS Listener

- Auto scaling Group
  - Launch Template

- RDS database
  - Database Subnet Group

- DNS
  - Route 53
  - ACM Certificate

## Usage

## Description

## Useful Links

[The count meta-argument](https://www.terraform.io/docs/language/meta-arguments/count.html)

[terraform modules](https://registry.terraform.io/modules/erkinsinc/wordpress/aws/latest?tab=resources)
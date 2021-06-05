Work In Progress
# Wordpress with bastion using Terraform

## Prerequisites:

   - AWS account
   - Terraform installed version 0.14
   - SSL Certificate
   - Existing SSH key
   - Domain Name

## Usage

```
git clone https://github.com/nazy67/wordpress_with_terraform.git

# run the next command on vpc directory, webserver and rds directories without dev.tf

terraform init
terraform plan  -var-file=tfvars/dev.tf
terraform apply -var-file=tfvars/dev.tf
```

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

- Application

  - Frontend:
    - Auto scaling Group
      - Launch Template
  
  - Backend:
    - RDS database
      - Database Subnet Group

- DNS
  - Route 53
  - ACM Certificate

## Description

This template is reusable it will provision `VPC` with CIDR 10.0.0.0/16, with  `3 Public` with CIDR 10.0.1.0/24, 10.0.2.0/24 & 10.0.3.0/24 and `3 private subnets` with CIDR 10.0.10.0/24, 10.0.11.0/24 & 10.0.12.0/24.

The VPC is configured with count meta-argument with index, element, lenght functions and for tags locals with merge function is used. When we have similar (repeating) resources such as public/private subnets and public/private route table associations we can use count.index to avoid it. With one public/private subnet resource block we are able to provision three public/private subnets same with route table association. Values for variables defined in variables.tf were passed as a list of strings in tfvars/dev.tf.

To have an access to the Internet (o.o.o.o/o) `Internet Gateway (IGW)` comes along and which gets attached to created VPC.

For Private subnets Internet comes with `NAT Gateway` which will be sitting on Public subnet, Elastic IP (EIP) also will be created and attached to it. Your application will be sitting on private subnet and it has to have static IP, it's  good security practice. 

The next resource is Route tables (public and private) 2 public subnets will be associated with  Public-RT attached with Internet Gateway and 2 private subnets will be associated with  Private-RT which is attached to Nat Gateway. 

The next step is security groups:

  - Load balancer security group  with HTTPS 443 and HTTP 80 ports open to 0.0.0.0/0.
  - RDS security group with MySQL port 3306 open to WordPress host's Security Group. 
  - WordPress host's Security group with port MySQL 3306 open to RDS's Security Group, and HTTP port 80 open to ELB Security Group.

## WordPress host

For this Demo, Amazon LINUX 2 machine (AMI) and t2.micro instance type were used and bash script was added in the user data section. This bash script will download php, httpd, mysql-agent and Wordpress package and unzips it.  

### UserData
```
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo hostnamectl set-hostname wordpress-web
sudo amazon-linux-extras install -y php8.0
sudo yum install -y httpd 
sudo systemctl start httpd
sudo systemctl enable httpd
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo yum install php-gd -y
sudo yum install mariadb -y
sudo systemctl restart httpd
sudo cp -r wordpress/* /var/www/html
sudo chown -R apache:apache /var/www/html
sudo systemctl restart httpd  
```

## RDS database    
<p>
RDS db will be created with an engine MariaDB and version 10.4.8, database instance class, storage type , allocated storage will be chosen from the RDS database parameters. 

Enter RDS db master _```username```_ and _```password```_.

RDS Security group public access will be false for security reason. For learning purposes no backing up ,storage isn't encrypted because db.t2.micro is too small.  

## Target Group and Application Load Balancer. 

Target group created with health check enabled, since our target type is "instance" in our case it will be WordPress host, also two Listener rules HTTP and HTTPS both of them forwarded to target group. Application Load Balancer's scheme is internet facing (because we want our customers to see our website), VPC with public subnets  will be chosen otherwise it won’t work. Because only public subnets have internet, if you choose private subnet it will keep hitting your NAT gateway and eventually it will drop it. Enter your ACM certificate to make your website secure if you have one, if not you need to create it. 

## Route 53

The last resource is Route 53, Hosted Zone Name will be available from your hosted zone. Alias target will be copied from  Hosted ZoneID and DNS name. Keep in mind that Hosted Zone Id and Alias Hosted Zone Id is different in every region. The following link has all Regions, Route 53 Hosted Zone IDs (Application Load Balancers, Classic Load Balancers) and Route 53 Hosted Zone IDs (Network Load Balancers).  
[AWS Documentation - Hosted Zone IDs](https://docs.aws.amazon.com/general/latest/gr/elb.html)
Another important thing to remember to keep in mind that, always put . after your domain name, it’s in AWS  documentation. As it's shown on lines 558 and 561.

## Notes 
<p>
The following  plugins are required to be installed and activated in the WordPress: 
- JSM force ssl
  - JSM's Force HTTP to HTTPS (SSL) – Simple, Safe, Reliable, and Fast!
- Simple 301 redirect 
  - Redirection

These plugins helps you to make your application secure , without redirecting  your HTTP/80 listener to HTTPS/443.
</p>
## Useful Links

[The count meta-argument](https://www.terraform.io/docs/language/meta-arguments/count.html)

[terraform modules](https://registry.terraform.io/modules/erkinsinc/wordpress/aws/latest?tab=resources)

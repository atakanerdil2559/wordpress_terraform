# Work In Progress

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

# run the next command on vpc directory, webserver and rds directories without `-var-file=tfvars/dev.tf`

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

#### VPC
The content of this Repository is reusable and it will provision `VPC` with CIDR 10.0.0.0/16, with  `3 Public subnets` and `3 Private subnets` all the values for subnets are given in tfvars/dev.tf:

```
# Subnet

subnet_azs         = ["us-east-1a", "us-east-1b","us-east-1c"  ]
pub_cidr_subnet  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
priv_cidr_subnet = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
```

Our VPC is configured with `count` meta-argument with `index`, `element`, `lenght` functions and for tags `locals` with `merge` function. When we have similar (repeating) resources such as public/private subnets and public/private route table associations we can use count.index to avoid it duplicating. With one public/private subnet resource block we are able to provision three public/private subnets, same with Route table association (where 3 Public subnets associated with `Public-RT` attached to Internet Gateway, and 3 Private subnets associated with `Private-RT` which is attached to Nat Gateway).

`Internet Gateway (IGW)` comes along to bring the Internet (o.o.o.o/o) which is created and attached to to VPC. For Private subnets Internet comes with `NAT Gateway` which will be sitting on Public subnet, an Elastic IP (EIP) also  created and attached to it. My `frontend` and `backend` will be sitting on Private subnets for security reasons, only access to to webserver will be form Bastion Host, which is sitting on a Public subnet. I manually created ssh-key of Bastion host and imported it to AWS console and on launch template key_name's value `bastion-key` is given, that is why I have separated vpc, webserver and rds directories.  

#### Security groups:

  - Bastion host security group, with open ports 22(SSH) to local machine and Webserver security group.
  - Application Load balancer security group with ports 443(HTTPS) and 80(HTTP) open to 0.0.0.0/0.
  - RDS security group with ports 3306(MySQL) open to Webserver security group and local machine. 
  - Webserver Security group with ports 3306(MySQL) open to RDS's Security Group, and HTTP port 80 open to ALB Security Group and 22(SSH) open to Bastion security group.

#### Application Load Balancer.

Target group gets created first with health check enabled, since our target type is an `instance`, in our case it will be `"${var.env}_wordpress"` instance, also `HTTP` and `HTTPS` Listener rules will be created both of them forwarded to target group. Application Load Balancer's scheme is internet facing (because we want our customers to see our website), for subnets values list of `Public subnets` are given otherwise it won’t work. Because only public subnets are connected to `IGW` (they have access to the Internet), if you choose `Private subnets` it will keep hitting your `NAT gateway` and eventually it will drop the connection. For Certificate arn I passed the data source `aws_acm_certificate` where Terraform will go and get the existing resource in our case is Certificate, `ACM Certificate` makes your website secure if you don't have one you can always create it.

#### Auto Scaling group. Launch template.

Before we create ASG we need to create Launch Template or Launch Confiration (older version), for an image_id I passed a data_source since it's an existing resource and will filter out from a given criteria’s and chooses the correct AMI. 

```
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter { # dictionary or map
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}
```

For this, Amazon LINUX 2 machine (AMI) and t2.micro instance type were used and bash script was added in the user data section. This bash script will download php, httpd, mysql-agent and Wordpress package and unzips it.  

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

RDS db will be created with an engine MariaDB and version 10.4.8, database instance class, storage type , allocated storage will be chosen from the RDS database parameters. 

Enter RDS db master _```username```_ and _```password```_.

RDS Security group public access will be false for security reason. For learning purposes no backing up ,storage isn't encrypted because db.t2.micro is too small.  


## Route 53

The last resource is Route 53, Hosted Zone Name will be available from your hosted zone. Alias target will be copied from  Hosted ZoneID and DNS name. Keep in mind that Hosted Zone Id and Alias Hosted Zone Id is different in every region. The following link has all Regions, Route 53 Hosted Zone IDs (Application Load Balancers, Classic Load Balancers) and Route 53 Hosted Zone IDs (Network Load Balancers).  
[AWS Documentation - Hosted Zone IDs](https://docs.aws.amazon.com/general/latest/gr/elb.html)
Another important thing to remember to keep in mind that, always put . after your domain name, it’s in AWS  documentation. As it's shown on lines 558 and 561.

## Notes 

The following  plugins are required to be installed and activated in the WordPress:
```
- JSM force ssl. (JSM's Force HTTP to HTTPS (SSL) – Simple, Safe, Reliable, and Fast!)

- Simple 301 redirect. (Redirection)
```
These plugins helps you to make your application secure , without redirecting  your HTTP/80 listener to HTTPS/443.

## Useful Links

[The count meta-argument](https://www.terraform.io/docs/language/meta-arguments/count.html)

[terraform modules](https://registry.terraform.io/modules/erkinsinc/wordpress/aws/latest?tab=resources)
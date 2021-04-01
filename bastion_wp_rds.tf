###  bastion host ###
resource "aws_instance" "bastion_host" {  
  ami           = data.aws_ami.amazon_linux2.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  key_name = var.ssh_key_name
  tags = {
    Name = "${var.env}-bastion_host"
   }
}

### wordpress web host ###
resource "aws_instance" "wordpress_host" {
  depends_on = [ aws_key_pair.generated_key.name ]
  ami                    =  data.aws_ami.amazon_linux2.image_id 
  instance_type          =  var.instance_type      
  vpc_security_group_ids = [ aws_security_group.wordpress_web_sg.id ]
  user_data = data.template_file.user_data.rendered
  key_name = bastion_key
  
  tags = {
    Name        = "webserver_2-${var.env}"
    Environment = var.env
  }
}

### rds database instance ###
resource "aws_db_instance" "rds-db" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = "${var.env}-my-db"
  name                 = var.database_name
  username             = var.username
  password             = random_password.password.result
  skip_final_snapshot = var.skip_snapshot
  final_snapshot_identifier = var.skip_snapshot == true ? null : "${var.env}-rds-snapshot"
  vpc_security_group_ids    = [ aws_security_group.rds-sg.id ]
}

resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "rds-subnet-grp"
  description = "rds subnet group"
  subnet_ids  = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  tags {
      Name = "${var.env}-rds-subnet grp"
  }
}

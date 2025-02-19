# Create a DB subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

# Create a security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow MySQL access from the Tomcat servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.tomcat_sg.id] # Ensure this SG exists
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create the primary RDS instance
resource "aws_db_instance" "primary_db" {
  identifier             = "primary-db"
  allocated_storage      = 20 # Free Tier allows up to 20 GB of storage
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro" # Free Tier eligible instance class
  username               = "admin"
  password               = "SuperStrongPassword" # Change this to a secure password
  parameter_group_name   = "default.mysql8.0"
  publicly_accessible    = false
  skip_final_snapshot    = true # Avoid costs associated with final snapshots
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "primary-db"
  }
}

# Create a read replica (optional, but not Free Tier eligible)
# Uncomment this block if you need a read replica (note: it may incur costs)
/*
resource "aws_db_instance" "read_replica" {
  identifier             = "read-replica-db"
  replicate_source_db    = aws_db_instance.primary_db.identifier
  instance_class         = "db.t3.micro"
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "read-replica-db"
  }
}
*/
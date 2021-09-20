# Create Mysql RDS Instance
resource "aws_db_instance" "rds-mysqldb" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "mysqldb"
  name                 = "mydb"
  username             = "root"
  password             = "change1intPws"
  db_subnet_group_name = "${aws_db_subnet_group.rds-mysqldb.name}"
  parameter_group_name = "default.mysql5.7"
  multi_az             = "false"
  vpc_security_group_ids = ["${aws_security_group.rds-mysqldbsg.id}"]
  storage_type         = "gp2"
  backup_retention_period = 30
  publicly_accessible =  false
  deletion_protection = false
  skip_final_snapshot = true
  tags = {
      Name = "rds-appprod"
      Type = "course_exam"
  }
}
# security groups
resource "aws_security_group" "rds-mysqldbsg" {
  vpc_id = "${aws_vpc.main.id}"
  name = "rds-mysqldb-sg"
  description = "Allow inbound mysql traffic"
  tags = {
    Name = "rds-mysqldb"
    Type = "course_exam"

  }
}
resource "aws_security_group_rule" "allow-mysql" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_group_id = "${aws_security_group.rds-mysqldbsg.id}"
    source_security_group_id = "${aws_security_group.app-prod.id}"
}
resource "aws_security_group_rule" "allow-outgoing" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.rds-mysqldbsg.id}"
    cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_db_subnet_group" "rds-mysqldb" {
    name = "rds-mysqldb"
    description = "RDS subnet group"
    subnet_ids = ["${aws_subnet.subnet-private-1.id}", "${aws_subnet.subnet-private-2.id}"]
}
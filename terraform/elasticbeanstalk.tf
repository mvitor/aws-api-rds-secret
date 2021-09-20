# key pair
resource "aws_key_pair" "app" {
  key_name = "app-prod" 
  public_key = "${file("${var.SSH_PUBLIC_KEY}")}"
}

# sec group
resource "aws_security_group" "app-prod" {
  vpc_id = "${aws_vpc.main.id}"
  name = "app-prod-sg"
  description = "Application prod security group"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "app-prod-sg"
    Type = "course_exam"

  }
}

resource "aws_elastic_beanstalk_application" "app" {
  name        = "${var.service_name}"
  description = "${var.service_description}"
}

resource "aws_elastic_beanstalk_application_version" "app-prod" {
  name        = "${var.namespace}-${var.env}-${uuid()}"
  application = "My application"
  description = "application version created by terraform"
  bucket      = "${aws_s3_bucket.dist_bucket.id}"
  key         = "${aws_s3_bucket_object.dist_item.id}"
  provisioner "local-exec" {
    command = "aws --region ${var.AWS_REGION} elasticbeanstalk update-environment --environment-name app-prod --version-label ${aws_elastic_beanstalk_application_version.app-prod.name}"
  }
}


resource "aws_elastic_beanstalk_environment" "app-prod" {
  name = "app-prod"
  application = "${aws_elastic_beanstalk_application.app.name}"
  solution_stack_name = "64bit Amazon Linux 2 v5.4.5 running Node.js 14"

  # VPC Subnets
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${aws_vpc.main.id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = "${aws_subnet.subnet-private-1.id},${aws_subnet.subnet-private-2.id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "app-ec2-rolepf"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.app-prod.id}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "EC2KeyName"
    value = "${aws_key_pair.app.id}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "public"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = "${aws_subnet.subnet-public-1.id},${aws_subnet.subnet-public-2.id}"
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "30"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Percentage"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any 2"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }
  # LB healthcheck
  setting {
    namespace = "${var.environmentType == "UseLoadBalancer" ? "aws:elb:healthcheck" : "aws:elasticbeanstalk:environment"}"
    name      = "${var.environmentType == "UseLoadBalancer" ? "HealthyThreshold" : "EnvironmentType"}"
    value     = "${var.environmentType == "UseLoadBalancer" ? var.healthcheck_healthy_threshold : var.environmentType}"
  }
  setting {
    namespace = "${var.environmentType == "UseLoadBalancer" ? "aws:elb:healthcheck" : "aws:elasticbeanstalk:environment"}"
    name      = "${var.environmentType == "UseLoadBalancer" ? "UnhealthyThreshold" : "EnvironmentType"}"
    value     = "${var.environmentType == "UseLoadBalancer" ? var.healthcheck_unhealthy_threshold : var.environmentType}"
  }
  setting {
    namespace = "${var.environmentType == "UseLoadBalancer" ? "aws:elb:healthcheck" : "aws:elasticbeanstalk:environment"}"
    name      = "${var.environmentType == "UseLoadBalancer" ? "Interval" : "EnvironmentType"}"
    value     = "${var.environmentType == "UseLoadBalancer" ? var.healthcheck_interval : var.environmentType}"
  }
  setting {
    namespace = "${var.environmentType == "UseLoadBalancer" ? "aws:elb:healthcheck" : "aws:elasticbeanstalk:environment"}"
    name      = "${var.environmentType == "UseLoadBalancer" ? "Timeout" : "EnvironmentType"}"
    value     = "${var.environmentType == "UseLoadBalancer" ? var.healthcheck_timeout : var.environmentType}"
  }
  # Autoscaling group triggers.
  setting {
    namespace = "${var.environmentType == "UseLoadBalancer" ? "aws:autoscaling:trigger" : "aws:elasticbeanstalk:environment"}"
    name      = "${var.environmentType == "UseLoadBalancer" ? "BreachDuration" : "EnvironmentType"}"
    value     = "${var.environmentType == "UseLoadBalancer" ? var.as_breach_duration : var.environmentType}"
  }
  setting {
    namespace = "${var.environmentType == "UseLoadBalancer" ? "aws:autoscaling:trigger" : "aws:elasticbeanstalk:environment"}"
    name      = "${var.environmentType == "UseLoadBalancer" ? "LowerBreachScaleIncrement" : "EnvironmentType"}"
    value     = "${var.environmentType == "UseLoadBalancer" ? var.as_lower_breach_scale_increment : var.environmentType}"
  }
  setting {
    namespace = "${var.environmentType == "UseLoadBalancer" ? "aws:autoscaling:trigger" : "aws:elasticbeanstalk:environment"}"
    name      = "${var.environmentType == "UseLoadBalancer" ? "LowerThreshold" : "EnvironmentType"}"
    value     = "${var.environmentType == "UseLoadBalancer" ? var.as_lower_threshold : var.environmentType}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_USERNAME"
    value = "${aws_db_instance.rds-mysqldb.username}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_PASSWORD"
    value = "${aws_db_instance.rds-mysqldb.password}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_DATABASE"
    value = "${aws_db_instance.rds-mysqldb.name}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_HOSTNAME"
    value = "${aws_db_instance.rds-mysqldb.address}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "AWS_REGION"
    value = "${var.AWS_REGION}"
  }
}

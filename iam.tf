# iam roles
resource "aws_iam_role" "app-ec2-role" {
    name = "app-ec2-role"
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_instance_profile" "app-ec2-rolepf" {
    name = "app-ec2-rolepf"
    role = "${aws_iam_role.app-ec2-role.name}"
}
resource "aws_iam_instance_profile" "beanstalk_ec2" {
    name = "app-beanstalkec2-role"
    role = "${aws_iam_role.elasticbeanstalk-service-role.name}"
}
# service
resource "aws_iam_role" "elasticbeanstalk-service-role" {
    name = "elasticbeanstalk-service-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# policies
resource "aws_iam_policy_attachment" "app-attach1" {
    name = "app-attach1"
    roles = ["${aws_iam_role.app-ec2-role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}
resource "aws_iam_policy_attachment" "app-attach2" {
    name = "app-attach2"
    roles = ["${aws_iam_role.app-ec2-role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}
resource "aws_iam_policy_attachment" "app-attach3" {
    name = "app-attach3"
    roles = ["${aws_iam_role.app-ec2-role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}
resource "aws_iam_policy_attachment" "app-attach4" {
    name = "app-attach4"
    roles = ["${aws_iam_role.elasticbeanstalk-service-role.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}
# ecr
# uncomment for ecr
#resource "aws_iam_role_policy" "app-ec2-role-policy" {
#    name = "app-ec2-role-policy"
#    role = "${aws_iam_role.app-ec2-role.id}"
#    policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Action": [
#                "ecr:GetAuthorizationToken"
#            ],
#            "Resource": "*"
#        }
#    ]
#}
#EOF
#}
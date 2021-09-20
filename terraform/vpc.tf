# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags =  {
        Name = "main"
        Type = "course_exam"
    }
}

# Internet GW
resource "aws_internet_gateway" "subnet-gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "main"
        Type = "course_exam"
    }
}

# route tables
resource "aws_route_table" "subnet-public" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.subnet-gw.id}"
    }

    tags = {
        Name = "subnet-public-1"
        Type = "course_exam"
    }
}

# Subnets
resource "aws_subnet" "subnet-public-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet-public-1"
        Type = "course_exam"
    }
}
resource "aws_subnet" "subnet-public-2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags = {
        Name = "subnet-public-2"
        Type = "course_exam"
    }
}
resource "aws_subnet" "subnet-public-3" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"

    tags = {
        Name = "subnet-public-3"
        Type = "course_exam"
    }
}
resource "aws_subnet" "subnet-private-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags = {
        Name = "subnet-private-1"
        Type = "course_exam"
    }
}
resource "aws_subnet" "subnet-private-2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags = {
        Name = "subnet-private-2"
        Type = "course_exam"
    }
}
resource "aws_subnet" "subnet-private-3" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags = {
        Name = "subnet-private-3"
        Type = "course_exam"
    }
}
# route associations public
resource "aws_route_table_association" "subnet-public-1-a" {
    subnet_id = "${aws_subnet.subnet-public-1.id}"
    route_table_id = "${aws_route_table.subnet-public.id}"
}
resource "aws_route_table_association" "subnet-public-2-a" {
    subnet_id = "${aws_subnet.subnet-public-2.id}"
    route_table_id = "${aws_route_table.subnet-public.id}"
}
resource "aws_route_table_association" "subnet-public-3-a" {
    subnet_id = "${aws_subnet.subnet-public-3.id}"
    route_table_id = "${aws_route_table.subnet-public.id}"
}
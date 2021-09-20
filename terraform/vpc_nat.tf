resource "aws_route_table" "subnet-private" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
    }

    tags = {
        Name = "subnet-private-1"
        Type = "course_exam"
    }
}
# route associations private
resource "aws_route_table_association" "subnet-private-1-a" {
    subnet_id = "${aws_subnet.subnet-private-1.id}"
    route_table_id = "${aws_route_table.subnet-private.id}"
}
resource "aws_route_table_association" "subnet-private-2-a" {
    subnet_id = "${aws_subnet.subnet-private-2.id}"
    route_table_id = "${aws_route_table.subnet-private.id}"
}
resource "aws_route_table_association" "subnet-private-3-a" {
    subnet_id = "${aws_subnet.subnet-private-3.id}"
    route_table_id = "${aws_route_table.subnet-private.id}"
}

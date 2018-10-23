provider "aws" {
	region = "${var.region}"
        profile = "${var.profile}"
}

#resource "aws_instance" "web" {
#  instance_type = "t2.micro"
#  ami = "ami-0ebc281c20e89ba4b"
#}

resource "aws_vpc" "vpc" {
	tags {
		name = "${var.vpc_name}"
	}
	cidr_block="10.1.0.0/16"
}

resource "aws_internet_gateway" "internet-gw" {
	vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "route-table" {
	vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "route-internet" {
  route_table_id = "${aws_route_table.route-table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.internet-gw.id}"
}

resource "aws_subnet" "subnet-bastion" {
	vpc_id = "${aws_vpc.vpc.id}"
	availability_zone = "${var.az1}"
	cidr_block = "10.1.1.0/24"
}

resource "aws_route_table_association" "route-table-association" {
	subnet_id      = "${aws_subnet.subnet-bastion.id}"
	route_table_id = "${aws_route_table.route-table.id}"
}

resource "aws_security_group" "sg-bastion" {
	name = "sg_bastion"
	description = "Allow all inbound traffic from internet on ssh"
	vpc_id = "${aws_vpc.vpc.id}"
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["XX.XX.XX.XX/32"]
	}

}

resource "aws_key_pair" "ssh_pub_key" {
  key_name   = "ssh_pub_key"
  public_key = "${file(var.ssh_pub_key_path)}"
}

resource "aws_instance" "instance-bastion" {
	subnet_id = "${aws_subnet.subnet-bastion.id}"
	ami = "ami-0ebc281c20e89ba4b"
	instance_type = "t2.micro"
	associate_public_ip_address = true
	security_groups = ["${aws_security_group.sg-bastion.id}"]
	key_name = "${aws_key_pair.ssh_pub_key.id}"

	tags {
		Name = "bastion"
	}
}

output "public_ip" {
  value = "${aws_instance.instance-bastion.public_ip}"
}

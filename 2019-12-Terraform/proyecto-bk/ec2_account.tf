#insignias y secret key
provider "aws" {
    #region = "us-east-2"
    region = "${var.region}"
    access_key = "AKIAXFL47X6BLJ6EYUFE"
    secret_key = "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"
}

#resource "aws_instance" "test" {
#  ami = "ami-00068cd7555f543d5"
#  instance_type = "t2.micro"
#}

# Creacion VPC
resource "aws_vpc" "nahuel_tf" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "Nahuel Test Terraform"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = "${aws_vpc.nahuel_tf.id}"
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = true #hacerla publica - IP publica
  availability_zone = "us-east-2a"

  tags = {
    Name = "Nahuel subnet1"  
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id = "${aws_vpc.nahuel_tf.id}"
  cidr_block = "10.0.20.0/24"
  map_public_ip_on_launch = true #hacerla publica
  availability_zone = "us-east-2b"

  tags = {
    Name = "Nahuel subnet2"  
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id = "${aws_vpc.nahuel_tf.id}"
  cidr_block = "10.0.30.0/24"
  map_public_ip_on_launch = true #hacerla publica
  availability_zone = "us-east-2c"

  tags = {
    Name = "Nahuel subnet3"  
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.nahuel_tf.id}"

  tags = {
    Name = "Nahuel Gateway"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.nahuel_tf.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Nahuel Route"
  }
}

#Asociar route table con subnet
resource "aws_route_table_association" "table_subnet1" {
  subnet_id = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table_association" "table_subnet2" {
  subnet_id = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table_association" "table_subnet3" {
  subnet_id = "${aws_subnet.subnet3.id}"
  route_table_id = "${aws_route_table.r.id}"
}


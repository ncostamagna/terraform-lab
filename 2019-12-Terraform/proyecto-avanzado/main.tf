provider "aws" {
    region = "${var.region}"
}

resource "aws_vpc" "main1" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"

    tags = {
        Name = "Nahuel 1 TF"
        Location = "US"
    }
}

resource "aws_subnet" "subnets" {
    #count = "${length(var.azs)}"
    count = "${length(data.aws_availability_zones.azs.names)}"
    #availability_zone = "${element(var.azs, count.index)}"
    availability_zone = "${element(data.aws_availability_zones.azs.names, count.index)}"
    vpc_id = "${aws_vpc.main1.id}"
    cidr_block = "${element(var.subnet_cidr, count.index)}"

    tags = {
        Name = "Nahuel TF subnet-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main1.id}"

    tags = {
        Name = "VPC Main"
    }
}

resource "aws_route_table" "web-public-rt" {
    vpc_id = "${aws_vpc.main1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags = {
        Name = "Public Subnet RT"
    }
}

resource "aws_route_table_association" "public-subnet" {
    count = "${length(var.subnet_cidr)}"
    subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.web-public-rt.id}"
}


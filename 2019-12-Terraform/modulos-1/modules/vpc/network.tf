resource "aws_vpc" "main-module" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "${var.tenancy}"

    tags = {
        Name = "nahuel-module"
    }
}
resource "aws_subnet" "main-subnet-1" {
    vpc_id = "${var.vpc_id}"
    cidr_block = "${var.subnet_cidr}"

    tags = {
        Name = "Nahuel"
    }
}


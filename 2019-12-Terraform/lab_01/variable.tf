variable "region" {
    default = "us-east-2"
}
variable "amis" {
    default = {
        us-east-2 = "ami-0dacb0c129b49f529"
        us-west-2 = "ami-087c2c50437d0b80d"
    }
}

variable "cidr_block" {
    default = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
    default = "10.0.30.0/24"
}
variable "private_subnet_cidr" {
    default = "10.0.40.0/24"
}
variable "aws_key_name" {}
variable "aws_key_path" {}

variable "region" {
    default = "us-east-2"
}
variable "ec2_ami" {
    type = "map"
    default = {
        us-east-2 = "ami-0dacb0c129b49f529"
        us-west-2 = "ami-087c2c50437d0b80d"
        }
}



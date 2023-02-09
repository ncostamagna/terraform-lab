variable "ami_id" {
    #type = string
    description = "AMI id para Amazon Linux 2"
#    default = "ami-0dacb0c129b49f529"
}
variable "region" {
    description = "Region a Utilizar"
}
variable "vpc_cidr" {
    description = "VPC cidr"
}
variable "subnet1_private_ip"{
    description = "IP privada de la instancia"
    type = "list"
    default = ["10.0.10.11", "10.0.10.12", "10.0.10.13"]
}
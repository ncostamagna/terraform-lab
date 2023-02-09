provider "aws" {
    region = "us-east-2"
}

#podemos llamarlo como queramos
module "vpc" {
  source = "../modules/vpc"
  #sobreescribir las variables
  vpc_cidr = "192.168.0.0/16"
  tenancy = "default"
  vpc_id = "${module.vpc.vpc_id}" #Lo saco del output
  subnet_cidr = "192.168.1.0/24"
}
module "ec2" {
    source = "../modules/ec2"
    #sobreescribir las variables
    ec2_count = 1
    ami_id = "ami-0dacb0c129b49f529"
    #instance_type = ""
    subnet_id = "${module.vpc.subnet_id}" #Lo saco del output
}

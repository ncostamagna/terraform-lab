# Commands

```sh
terraform apply # aplicar cambios
terraform apply -auto-approve # aplicar cambios y setear yes

terraform destroy # eliminar todo

```

# Modules

Create logical abstraction, the modules can be reutilizable, we can use specific modules in terraform registry, for example vpc

```sh

# in modules/ec2/instance.tf
resource "aws_instance" "nahuel-modules" {
    count = "${var.ec2_count}"
    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    subnet_id= "${var.subnet_id}"

    tags = {
        Name = "nahuel-modulos"
        Owner = "Nahuel TF"
        Env = "dev"
    }
}

# in modules/ec2/vars.tf
variable "ec2_count" {
    default = "1"
}
variable "ami_id" {}
variable "instance_type" {
    default = "t2.micro"
}
variable "subnet_id" {}
```

We can create the resource from modules, in this case, we create an ec2 instance with the values of the variables

```sh
# in dev/main.tf
provider "aws" {
    region = "us-east-2"
}

module "ec2" {
    # define module, in this case the ec2 module
    source = "../modules/ec2"
    #sobreescribir las variables
    ec2_count = 1
    ami_id = "ami-0dacb0c129b49f529"
    #instance_type = ""
    subnet_id = "${module.vpc.subnet_id}" #Lo saco del output
}


```

Run

```sh
cd dev
terraform init
# the modules has been initialized

```

We can use different environment, for example, we can use stage, qa, prod and in each env create our modules,
each module will import the resource from resoruces (in this case in modules folder)

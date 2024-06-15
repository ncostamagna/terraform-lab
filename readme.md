# Repositories

- hashiCorp-certified: go to terraform/Hands-On Labs

# What is Infrastructure as Code?

## What is Infrastructure as Code
Infrastructure as Code is essentially a hub that can be used for collaboration across the IT organization to improve infrastructure deployments, increase our ability to scale quickly, and improve the
application development process. Infrastructure as Code allows us to do all this consistently and
proficiently. By using Infrastructure as Code for both our on-premises infrastructure and the public
cloud, our organization can provide dynamic infrastructure to both our internal team members and
ensure our customers have an excellent experience.

## Benefits of IaC
While there are many benefits of Infrastructure as Code, a few key benefits include simplifying cloud
adoption, allowing us to adopt cloud-based services and offerings to improve our capabilities quickly.<br />
Infrastructure as Code allows us to remove many of the manual steps required today for infrastructure
requests, giving us the ability to automate approved requests without worrying about tickets sitting
in a queue. We can also use Infrastructure as Code to provide capacity-on-demand by offering a
library of services for our developers. We can publish a self-service capability where developers and
application owners can be empowered to request and provision infrastructure that better matches their
requirements. Again, all of this is possible while driving standardization and consistency throughout the
organization, which can drive efficiencies and reduce errors or deviations from established norms.

## Example of IaC

### IaC Tools
The list below represents some of the most popular Infrastructure as Code tools used by many organizations worldwide. These tools focus on deploying infrastructure on a private or public cloud platform.<br />
The list does NOT include tools such as Puppet, Chef, Saltstack, or Ansible since those are commonly
placed in the configuration management category and don’t really deploy infrastructure resources.<br />
There are likely other tools available, but they are not as popular as the ones listed below.<br />

- HashiCorp Terraform - terraform.io
- AWS CloudFormation - aws.amazon.com/cloudformation
- Azure Resource Manager (ARM) - azure.microsoft.com

# Commands

```sh
terraform init # initialize our project
terraform validate [file] # validation in the file, syntax
terraform fmt # rewrite the files with the right format
terraform plan # we can see the changes
terraform apply # appling our changes on AWS or wherever
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

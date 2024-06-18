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

# Terraform Goals

## Goals

- Unify the view of resources using infrastructure as code
- Support the modern data center (IaaS, PaaS, SaaS)
- Expose a way for individuals and teams to safely and predictably change infrastructure
- Provide a workflow that is technology agnostic
- Manage anything with an API

## Benefits

- Provides a high-level abstraction of infrastructure (IaC)
- Allows for composition and combination
- Supports parallel management of resources (graph, fast)
- Separates planning from execution (dry-run)

# Terraform State
In order to properly and correctly manage your infrastructure resources, Terraform stores the state of your managed infrastructure. Terraform uses this state on each execution to plan and make changes to your infrastructure. This state must be stored and maintained on each execution so future operations can perform correctly.

## Benefits of State
During execution, Terraform will examine the state of the currently running infrastructure, determine what differences exist between the current state and the revised desired state, and indicate the necessary changes that must be applied. When approved to proceed, only the necessary changes will be applied, leaving existing, valid infrastructure untouched.

- Task 1: Show Current State
- Task 2: Update your Configuration
- Task 3: Plan and Execute Changes
- Task 4: Show New State

# Commands

```sh
terraform init # initialize our project
terraform validate [file] # validation in the file, syntax
terraform fmt # rewrite the files with the right format
terraform plan # we can see the changes
terraform apply # appling our changes on AWS or wherever
terraform apply -auto-approve # aplicar cambios y setear yes

terraform show # all resources
terraform destroy # eliminar todo

```

# HashiCorp

## HashiCorp Configuration Language
Terraform is written in HCL (HashiCorp Configuration Language) and is designed to be both human and machine readable. HCL is built using code configuration blocks which typically follow the following syntax:


```r
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
 # Block body
<IDENTIFIER> = <EXPRESSION> # Argument
}

# AWS EC2 Example
resource "aws_instance" "web_server" { # BLOCK
  ami = "ami-04d29b6f966df1537" # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced 11 }
```

Terraform Code Configuration block types include:

- Terraform Settings Block
- Terraform Provider Block
- Terraform Resource Block
- Terraform Data Block
- Terraform Input Variables Block
- Terraform Local Variables Block
- Terraform Output Values Block
- Terraform Modules Block

# Terraform Providers
Terraform relies on plugins called "providers" to interact with remote systems and expand functionality. Terraform configurations must declare which providers they require so that Terraform can install and use them. This is performed within a Terraform configuration block.

- Task 1: View available Terraform Providers
- Task 2: Install the Terraform AWS Provider
- Task 3: View installed and required providers

## Task 1: View available Terraform Providers
Terraform Providers are plugins that implement resource types for particular clouds, platforms and generally speaking any remote system with an API. Terraform configurations must declare which providers they require, so that Terraform can install and use them. Popular Terraform Providers include: AWS, Azure, Google Cloud, VMware, Kubernetes and Oracle.

## Task 2: Install the Terraform AWS Provider
To install the Terraform AWS provider, and set the provider version in a way that is very similar to how you did for Terraform. To begin you need to let Terraform know to use the provider through a required_providers block in the terraform.tf file as seen below.

```r
# terraform.tf
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}
```
Run a terraform init to install the providers specified in the configuration


## Task 3: View installed and required providers

If you ever would like to know which providers are installed in your working directory and those required by the configuration, you can issue a terraform version and terraform providers command.
```sh
terraform version

Terraform v1.0.10
on darwin_amd64
+ provider registry.terraform.io/hashicorp/aws v3.64.2
+ provider registry.terraform.io/hashicorp/random v3.1.0
```

```sh
terraform providers

Providers required by configuration:
.
|-- provider[registry.terraform.io/hashicorp/aws] ~> 3.0
|-- provider[registry.terraform.io/hashicorp/random]

Providers required by state:

    provider[registry.terraform.io/hashicorp/aws]

    provider[registry.terraform.io/hashicorp/random]

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

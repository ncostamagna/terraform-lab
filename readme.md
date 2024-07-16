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
terraform plan -destroy # see resources before it will be destroyed

terraform output # we can see the output values

## taint is deprecated
terraform taint # manually mark a resource for recretion
terraform taint aws_instance.web_server # we need to run apply after it
terraform untaint # reverte taint

## instead of taint, we can use -replace
terraform apply -replace
terraform apply -replace="aws_instance.web_server"


terraform graph # creating a graph
# https://github.com/btkrausen/hashicorp/blob/7562e7e572c7ea33e977477002dc02430414f008/terraform/Hands-On%20Labs/Section%2009%20-%20Read%20Generate%20and%20Modify%20Configuration/10%20-%20Terraform_Graph.md
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

# Data Source

A data source is accessed via a special kind of resource known as a data resource, declared using a data block:
```r
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}
```
A data block requests that Terraform read from a given data source ("aws_ami") and export the result under the given local name ("example"). The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside of the scope of a module.
<br />
The data source and name together serve as an identifier for a given resource and so must be unique within a module.
<br />
https://developer.hashicorp.com/terraform/language/data-sources

# Import
we can import resources into AWS, that were not created with Terraform.<br />
For example, if we have some EC2 on AWS (not by terraform)<br />
```r
# we need to define the region
provider "aws" {
  region = "us-west-2"
}

# we need to define the block
resource "aws_instance" "aws_linux" {}
```
we run the follow command
```r
terraform import <resource.name> <unique_identifier>
terraform import aws_instance.aws_linux i-0bfff5070c5fb87b6
```

if we don't have some requirment argument such as ami or arn, we can run *state show*

```r
terraform state show
```

# Workspaces
We can define workspaces with terraform, 'default' space by default
```sh
terraform workspace show #workspaces



terraform workspace -help

Usage: terraform [global options] workspace

  new, list, show, select and delete Terraform workspaces.

Subcommands:
    delete    Delete a workspace
    list      List Workspaces
    new       Create a new workspace
    select    Select a workspace
    show      Show the name of the current workspace
```
To move between terraform workspaces you can use the `terraform workspace` command.

```sh
terraform workspace select default

terraform workspace select development
```


Now that we see the benefit of isolating our resource state information using terraform workspaces, we may wish to reflect the workspace name information into our code base.<br /><br />

Within your Terraform configuration, you may include the name of the current workspace using the ${terraform.workspace} interpolation sequence.<br /><br />

Modify the environment default tag for `main.tf` inside the AWS provider to reflect the terraform workspace name

```r
provider "aws" {
  region = "us-west-2"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Owner       = "TF Hands On Lab"
      Project     = "Infrastructure as Code"
      Terraform   = "true"
    }
  }
}
```

```r
# aws_vpc.vpc will be updated in-place
~ resource "aws_vpc" "vpc" {
      id                               = "vpc-00d26110d48784808"
    ~ tags                             = {
        ~ "Environment" = "demo_environment" -> "development"
          # (2 unchanged elements hidden)
      }
    ~ tags_all                         = {
        ~ "Environment" = "demo_environment" -> "development"
          # (2 unchanged elements hidden)
      }
      # (14 unchanged attributes hidden)
  }
```

# Lab: Debugging Terraform

- Task 1: Enable Logging
- Task 2: Set Logging Path
- Task 3: Disable Logging

## Task 1: Enable Logging

Terraform has detailed logs which can be enabled by setting the TF_LOG environment variable to any value. This will cause detailed logs to appear on stderr.

You can set TF_LOG to one of the log levels TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs, with TRACE being the most verbose.

Linux

```bash
export TF_LOG=TRACE
```

PowerShell

```shell
$env:TF_LOG="TRACE"
```

Run Terraform Apply.

```shell
terraform apply
```

Example Output

```shell
2020/03/20 13:14:41 [INFO] backend/local: apply calling Apply
2020/03/20 13:14:41 [INFO] terraform: building graph: GraphTypeApply
2020/03/20 13:14:41 [TRACE] Executing graph transform *terraform.ConfigTransformer
2020/03/20 13:14:41 [TRACE] ConfigTransformer: Starting for path:
2020/03/20 13:14:41 [TRACE] Completed graph transform *terraform.ConfigTransformer with new graph:
  data.vsphere_compute_cluster.cluster (prepare state) - *terraform.NodeApplyableResource
  data.vsphere_datacenter.dc (prepare state) - *terraform.NodeApplyableResource
  data.vsphere_datastore.datastore (prepare state) - *terraform.NodeApplyableResource
  data.vsphere_network.network (prepare state) - *terraform.NodeApplyableResource
  data.vsphere_virtual_machine.windows_template (prepare state) - *terraform.NodeApplyableResource
  vsphere_tag.tag_release (prepare state) - *terraform.NodeApplyableResource
  vsphere_tag.tag_tier (prepare state) - *terraform.NodeApplyableResource
  vsphere_tag_category.category (prepare state) - *terraform.NodeApplyableResource
  vsphere_virtual_machine.windows_vm (prepare state) - *terraform.NodeApplyableResource
  ------
2020/03/20 13:14:41 [TRACE] Executing graph transform *terraform.DiffTransformer
```

## Task 2: Enable Logging Path

To persist logged output you can set TF_LOG_PATH in order to force the log to always be appended to a specific file when logging is enabled. Note that even when TF_LOG_PATH is set, TF_LOG must be set in order for any logging to be enabled.

```bash
export TF_LOG_PATH="terraform_log.txt"
```

PowerShell

```shell
$env:TF_LOG_PATH="terraform_log.txt"
```

Run terraform init to see the initialization debugging information.

```shell
terraform init -upgrade
```

Open the `terraform_log.txt` to see the contents of the debug trace for your terraform init. Experiment with removing the provider stanza within your Terraform configuration and run a `terraform plan` to debug how Terraform searches for where a provider is located.

## Task 3: Disable Logging

Terraform logging can be disabled by clearing the appropriate environment variable.

Linux

```bash
export TF_LOG=""
```

PowerShell

```shell
$env:TF_LOG=""
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

We can use different environment, for example, we can use stage, qa, prod and in each env, we create our modules.
Each module will import the resource from resoruces (in this case, from the modules folder)
<br />
For more information, you can see in `/hashiCorp-certified/terraform/Hands-On Labs/Section 06 - Interact with Terraform Modules`

# State
Terraform stores and operates on the state of your managed infrastructure. By default Terraform uses a local backend, where state information is stored and acted upon locally within the working directory in a local file named terraform.tfstate

## Backend with S3 and Dynamo
https://github.com/btkrausen/hashicorp/blob/7562e7e572c7ea33e977477002dc02430414f008/terraform/Hands-On%20Labs/Section%2008%20-%20Implement%20and%20Maintain%20State/04%20-%20Terraform_State_Backend_Storage.md

## Backend with Terraform Enterprise-Cloud
https://github.com/btkrausen/hashicorp/blob/7562e7e572c7ea33e977477002dc02430414f008/terraform/Hands-On%20Labs/Section%2008%20-%20Implement%20and%20Maintain%20State/05%20-%20Terraform_Remote_State_Enhanced_Backend.md

## State Migration
https://github.com/btkrausen/hashicorp/blob/7562e7e572c7ea33e977477002dc02430414f008/terraform/Hands-On%20Labs/Section%2008%20-%20Implement%20and%20Maintain%20State/06%20-%20Terraform_State_Migration.md

# BackEnd

## Dynamic values in BackEnd confi
https://github.com/btkrausen/hashicorp/blob/7562e7e572c7ea33e977477002dc02430414f008/terraform/Hands-On%20Labs/Section%2008%20-%20Implement%20and%20Maintain%20State/08%20-%20Terraform_Backend_Configuration.md

# Sensitive data

https://github.com/btkrausen/hashicorp/blob/7562e7e572c7ea33e977477002dc02430414f008/terraform/Hands-On%20Labs/Section%2009%20-%20Read%20Generate%20and%20Modify%20Configuration/05%20-%20Secure_Secrets_in_Terraform_Code.md


# Lab: Terraform Collections and Structure Types

As you continue to work with Terraform, you're going to need a way to organize and structure data. This data could be input variables that you are giving to Terraform, or it could be the result of resource creation, like having Terraform create a fleet of web servers or other resources. Either way, you'll find that data needs to be organized yet accessible so it is referenceable throughout your configuration. The Terraform language uses the following types for values:

* **string:** a sequence of Unicode characters representing some text, like "hello".
* **number:** a numeric value. The number type can represent both whole numbers like 15 and fractional values like 6.283185.
* **bool:** a boolean value, either true or false. bool values can be used in conditional logic.
* **list (or tuple):** a sequence of values, like ["us-west-1a", "us-west-1c"]. Elements in a list or tuple are identified by consecutive whole numbers, starting with zero.
* **map (or object):** a group of values identified by named labels, like {name = "Mabel", age = 52}. Maps are used to store key/value pairs.

Strings, numbers, and bools are sometimes called primitive types. Lists/tuples and maps/objects are sometimes called complex types, structural types, or collection types. Up until this point, we've primarily worked with string, number, or bool, although there have been some instances where we've provided a collection by way of input variables. In this lab, we will learn how to use the different collections and structure types available to us.

- Task 1: Create a new list and reference its values using the index
- Task 2: Add a new map variable to replace static values in a resource
- Task 3: Iterate over a map to create multiple resources
- Task 4: Use a more complex map variable to group information to simplify readability

## Task 1: Create a new list and reference its values

In Terraform, a _list_ is a sequence of like values that are identified by an index number starting with zero. Let's create one in our configuration to learn more about it. Create a new variable that includes a list of different availability zones in AWS. In your `variables.tf` file, add the following variable:

```hcl
variable "us-east-1-azs" {
    type = list(string)
    default = [
        "us-east-1a",
        "us-east-1b",
        "us-east-1c",
        "us-east-1d",
        "us-east-1e"
    ]
}
```

In your `main.tf` file, add the following code that will reference the new list that we just created:

```hcl
resource "aws_subnet" "list_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.200.0/24"
  availability_zone = var.us-east-1-azs
}
```

Go and and run a `terraform plan`. You should receive an error, and that's because the new variable `us-east-1-azs` we just created is a list of strings, and the argument `availability_zones` is expecting a single string. Therefore, we need to use an identifier to select which element to use in the list of strings.

Let's fix it. Update the `list_subnet` configuration to specify a specific element referenced by its indexed value from the list we provided - remember that indexes start at `0`.

```hcl
resource "aws_subnet" "list_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.200.0/24"
  availability_zone = var.us-east-1-azs[0]
}
```

Run a `terraform plan` again. Check out the output and notice that the new subnet will be created in `us-east-1a`, because that is the first string in our list of strings. If we used `var.us-east-1-azs[1]` in the configuration, Terraform would have built the subnet in `us-east-1b` since that's the second string in our list.

Go ahead and run `terraform apply` to apply the new configuration and build the subnet.

## Task 2 - Add a new map variable to replace static values in a resource

Let's continue to improve our `list_subnet` so we're not using any static values. First, we'll work on getting rid of the static value used for the subnet CIDR block and use a map instead. Add the following code to `variables.tf`:

```hcl
variable "ip" {
  type = map(string)
  default = {
    prod = "10.0.150.0/24"
    dev  = "10.0.250.0/24"
  }
}
```

Now, let's reference the new variable we just created. Modify the `list_subnet` in `main.tf`:

```hcl
resource "aws_subnet" "list_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.ip["prod"]
  availability_zone = var.us-east-1-azs[0]
}
```

Run `terraform plan` to see the proposed changes. In this case, you should see that the subnet will be replaced. The new subnet will have an IP subnet of 10.0.150.0/24, because we are now referencing the value of the `prod` key in our map.

Go ahead and run `terraform apply -auto-approve` to apply the new changes.

Before we move on, let's fix one more thing here. We still have a static value that is "hardcoded" in our `list_subnet` that we should use a variable for instead. We already have a `var.environment` that dictates the environment we're working in, so we can simply use that in our `list_subnet`.

Modify the `list_subnet` in `main.tf` and update the cidr_block argument to the following:

```hcl
resource "aws_subnet" "list_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.ip[var.environment]
  availability_zone = var.us-east-1-azs[0]
}
```

Run `terraform plan` to see the proposed changes. In this case, you should see that the subnet will again be replaced. The new subnet will have an IP subnet of `10.0.250.0/24`, because we are now using the value of `var.environment` to select the key in our map for the variable `var.ip` and the default is `dev`.

Go ahead and run `terraform apply -auto-approve` to apply the new changes.

### Task 3: Iterate over a map to create multiple resources

While we're in much better shape for our `list_subnet`, we can still improve it. Oftentimes, you'll want to deploy multiple resources of the same type but each resource should be slightly different for different use cases. In our example, if we wanted to deploy BOTH a `dev` and `prod` subnet, we would have to copy the resource block and create a second one so we could refer to the other subnet in our map. However, there's a fairly simple way that we can iterate over our map in a single resource block to create and manage both subnets.

To accomplish this, use a `for_each` to iterate over the map to create multiple subnets in the same AZ. Modify your `list_subnet` to the following:

```hcl
resource "aws_subnet" "list_subnet" {
  for_each          = var.ip
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = var.us-east-1-azs[0]
}
```

Run a `terraform plan` to see the proposed changes. Notice that our original subnet will be destroyed and Terraform will create two two subnets, one for `prod` with its respective CIDR block and one for `dev` with its respective CIDR block. That's because the `for_each` iterated over the map and will create a subnet for each key. The other major difference is the resource ID for each subnet. Notice how it's creating `aws_subnet.list_subnet["dev"]` and `aws_subnet.list_subnet["prod"]`, where the names are the keys listed in the map. This gives us a way to clearly understand what each subnet is. We could even use these values in a tag to name the subnet as well.

Go ahead and apply the new configuration using a `terraform apply -auto-approve`.

Using `terraform state list`, check out the new resources:

```bash
$ terraform state list
...
aws_subnet.list_subnet["dev"]
aws_subnet.list_subnet["prod"]
```

You can also use `terraform console` to view the resources and more detailed information about each one (use CTLR-C to get out when you're done):

```bash
$ terraform console
> aws_subnet.list_subnet
{
  "dev" = {
    "arn" = "arn:aws:ec2:us-east-1:1234567890:subnet/subnet-052d26040d4b91a51"
    "assign_ipv6_address_on_creation" = false
...
```
### Task 4: Use a more complex map variable to group information to simplify readability

While the previous configuration works great, we're still limited to using only a single availability zone for both of our subnets. What if we wanted to use a single resource block but have unique settings for each subnet? Well, we can use a map of maps to group information together to make it easier to iterate over and, more importantly, make it easier to read for you and others using the code. 

Create a "map of maps" to group information per environment. In `variables.tf`, add the following variable:

```hcl
variable "env" {
  type = map(any)
  default = {
    prod = {
      ip = "10.0.150.0/24"
      az = "us-east-1a"
    }
    dev  = {
      ip = "10.0.250.0/24"
      az = "us-east-1e"
    }
  }
}
```

In `main.tf`, modify the `list_subnet` to the following:

```hcl
resource "aws_subnet" "list_subnet" {
  for_each          = var.env
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.ip
  availability_zone = each.value.az
}
```

Run a `terraform plan` to view the proposed changes. Notice that only the `dev` subnet will be replaced since we're now placing it in a different availability zone, yet the `prod` subnet remains unchanged.

Go ahead and apply the configuration using `terraform apply -auto-approve`. Feel free to log into the AWS console to check out the new resources.

Once you're done, feel free to delete the variables and `list_subnet` that was created in this lab, although it's not required.

# Lab: Terraform Built-in Functions

As you continue to work with data inside of Terraform, there might be times where you want to modify or manipulate data based on your needs. For example, you may have multiple lists or strings that you want to combine. In contrast, you might have a list where you want to extract data, such as returning the first two values.

The Terraform language has many built-in functions that can be used in expressions to transform and combine values. Functions are available for actions on numeric values, string values, collections, date and time, filesystem, and many others.

- Task 1: Use basic numerical functions to select data
- Task 2: Manipulate strings using Terraform functions
- Task 3: View the use of cidrsubnet function to create subnets

## Task 1: Use basic numerical functions to select data

Terraform includes many different functions that work directly with numbers. To learn how they work, let's add some code and check it out. In your `variables.tf` file, let's add some variables. Feel free to use any number as the default value.

```hcl
variable "num_1" {
  type = number
  description = "Numbers for function labs"
  default = 88
}

variable "num_2" {
  type = number
  description = "Numbers for function labs"
  default = 73
}

variable "num_3" {
  type = number
  description = "Numbers for function labs"
  default = 52
}
```

In the `main.tf`, let's add a new local variable that uses a numercial function:

```hcl
locals {
  maximum = max(var.num_1, var.num_2, var.num_3)
  minimum = min(var.num_1, var.num_2, var.num_3, 44, 20)
}

output "max_value" {
  value = local.maximum
}

output "min_value" {
  value = local.minimum
}
```

Go ahead and run a `terraform apply -auto-approve` so we can see the result of our numerical functions by way of outputs.

## Task 2: Manipulate strings using Terraform functions

Now that we know how to use functions with numbers, let's play around with strings. Many of the resources we deploy with Terraform and the related aruments require a string for input, such as a subnet ID, security group, or instance size.

Let's modify our VPC to make use of a string function. Update your VPC resource in the `main.tf` file to look something like this:

```hcl
#Define the VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = upper(var.vpc_name)
    Environment = upper(var.environment)
    Terraform   = upper("true")
  }

  enable_dns_hostnames = true
}
```

Go ahead and run a `terraform apply -auto-approve` so we can see the result of our string functions by way of the changes that are applied to our tags.

### Task 2.1

Now, let's assume that we have set standards for our tags across AWS, and one of the requirements is that all tags are lower case. Rather than bothering our users with variable validations, we can simply take care of it for them with a simply function.

In your `main.tf` file, update the locals block to the following:

```hcl
locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name      = lower(local.server_name)
    Owner     = lower(local.team)
    App       = lower(local.application)
    Service   = lower(local.service_name)
    AppTeam   = lower(local.app_team)
    CreatedBy = lower(local.createdby)
  }
}
```

Before we test it out, let's set the value of a variable using a `.tfvars` file. Create a new file called `terraform.auto.tfvars` in the same working directory and add the following:

```hcl
environment = "PROD_Environment"
```

Let's test it out. Run `terraform plan` and let's take a look at the proposed changes. Notice that our string manipulations are causing some of the resource tags to be updated.

Go and apply the changes using `terraform apply -auto-approve`.

### Task 2.2

When deploying workloads in Terraform, it's common practice to use functions or expressions to dynamically generate name and tag values based on input variables. This makes your modules reuseable without worrying about providing values for more and more tags.

In your `main.tf` file, let's update our locals block again, but this time we'll use a `join` to dynamically generate the value for Name based upon data we're already providing or getting from data blocks.

```hcl
locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Name = join("-",
      [local.application,
        data.aws_region.current.name,
    local.createdby])
    Owner     = lower(local.team)
    App       = lower(local.application)
    Service   = lower(local.service_name)
    AppTeam   = lower(local.app_team)
    CreatedBy = lower(local.createdby)
  }
}
```

Let's test it out. Run `terraform plan` and let's take a look at the proposed changes. Notice that our string function is dynamically creating a Name for our resource based on other data we've provided or obtained.

Go and apply the changes using `terraform apply -auto-approve`.

## Task 3: View the use of cidrsubnet function to create subnets

There are many different specialized functions that come in handy when deploying resources in a public or private cloud. One of these special functions can help us automatically generate subnets based on a CIDR block that we provided it. Since the very first time you ran `terraform apply` in this course, you've been using the `cidrsubnet` function to create the subnets.

In your `main.tf` file, view the resource blocks that are creating our initial subnets:

```hcl
#Deploy the private subnets
resource "aws_subnet" "private_subnets" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, each.value)
  availability_zone = tolist(data.aws_availability_zones.available.names)[each.value]

  tags = {
    Name      = each.key
    Terraform = "true"
  }
}
```

Note how this block (and the one to create the public subnets) is creating multiple subnets. The resulting subnets were created based on the initial CIDR block, which was our VPC CIDR block. The second value is the number of bits added to the original prefix, so in our case, it was `/16`, so resulting subnets will be `/24` since we're adding `8` in our function. The last value needed is derived from the value obtained from the `value` of each key in `private_subnets` since we're using a for_each in this resource block.

Free free to create other subnets using the cidrsubnet function and play around with the values to see how it could best fit your requirements and scenarios.


# Lab: Dynamic Blocks

A dynamic block acts much like a for expression, but produces nested blocks instead of a complex typed value. It iterates over a given complex value, and generates a nested block for each element of that complex value. You can dynamically construct repeatable nested blocks using a special dynamic block type, which is supported inside resource, data, provider, and provisioner blocks.

- Task 1: Create a Security Group Resource with Terraform
- Task 2: Look at the state without a dynamic block
- Task 3: Convert Security Group to use dynamic block
- Task 4: Look at the state with a dynamic block
- Task 5: Use a dynamic block with Terraform map
- Task 6: Look at the state with a dynamic block using Terraform map

## Task 1: Create a Security Group Resource with Terraform

Add an AWS security group resource to our `main.tf`

```hcl
resource "aws_security_group" "main" {
  name   = "core-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

## Task 2: Look at the state without a dynamic block

Run a `terraform apply` followed by a `terraform state list` to view how the security groups are accounted for in Terraform's State.

```bash
terraform state list

aws_security_group.main
```

```bash
terraform state show aws_security_group.main
```

```bash
# aws_security_group.main:
resource "aws_security_group" "main" {
    arn                    = "arn:aws:ec2:us-east-1:508140242758:security-group/sg-00157499a6de61832"
    description            = "Managed by Terraform"
    egress                 = []
    id                     = "sg-00157499a6de61832"
    ingress                = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Port 443"
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Port 80"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name                   = "core-sg"
    owner_id               = "508140242758"
    revoke_rules_on_delete = false
    tags_all               = {}
    vpc_id                 = "vpc-0e3a3d76e5feb63c9"
}
```

## Task 3: Convert Security Group to use dynamic block

Refactor the `aws_security_group` resource block created above to utilize a dynamic block to built out the repeatable `ingress` nested block that is a part of this resource. We will supply the content for these repeatable blocks via local values to make it easier to read and update moving forward.

```hcl
locals {
  ingress_rules = [{
      port        = 443
      description = "Port 443"
    },
    {
      port        = 80
      description = "Port 80"
    }
  ]
}

resource "aws_security_group" "main" {
  name   = "core-sg"
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

## Task 4: Look at the state with a dynamic block

Run a `terraform apply` followed by a `terraform state list` to view how the servers are accounted for in Terraform's State.

```bash
terraform apply
terraform state list
```

```bash
aws_security_group.main
```

```bash
terraform state show aws_security_group.main
```

```bash
# aws_security_group.main:
resource "aws_security_group" "main" {
    arn                    = "arn:aws:ec2:us-east-1:508140242758:security-group/sg-00157499a6de61832"
    description            = "Managed by Terraform"
    egress                 = []
    id                     = "sg-00157499a6de61832"
    ingress                = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Port 443"
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Port 80"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name                   = "core-sg"
    owner_id               = "508140242758"
    revoke_rules_on_delete = false
    tags                   = {}
    tags_all               = {}
    vpc_id                 = "vpc-0e3a3d76e5feb63c9"
}
```

## Task 5: Use a dynamic block with Terraform map

Rather then using the local values, we can refactor our dynamic block to utilize a variable named `web_ingress` which is of map.  Let's first create the variable of type map, specifying some default values for our ingress rules inside our `variables.tf` file.

```hcl
variable "web_ingress" {
  type = map(object(
    {
      description = string
      port        = number
      protocol    = string
      cidr_blocks = list(string)
    }
  ))
  default = {
    "80" = {
      description = "Port 80"
      port        = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "443" = {
      description = "Port 443"
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

Then we will refactor our security group to use this variable rather then using local values.

```hcl
resource "aws_security_group" "main" {
  name = "core-sg"

  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.web_ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
```

## Task 6: Look at the state with a dynamic block using Terraform map

Run a `terraform apply` followed by a `terraform state list` to view how the servers are accounted for in Terraform's State.

```bash
terraform state list
```

```bash
terraform state show aws_security_group.main
```

```bash
# aws_security_group.main:
resource "aws_security_group" "main" {
    arn                    = "arn:aws:ec2:us-east-1:508140242758:security-group/sg-00157499a6de61832"
    description            = "Managed by Terraform"
    egress                 = []
    id                     = "sg-00157499a6de61832"
    ingress                = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Port 443"
            from_port        = 443
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 443
        },
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = "Port 80"
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name                   = "core-sg"
    owner_id               = "508140242758"
    revoke_rules_on_delete = false
    tags                   = {}
    tags_all               = {}
    vpc_id                 = "vpc-0e3a3d76e5feb63c9"
}
```

## Best Practices

Overuse of dynamic blocks can make configuration hard to read and maintain, so it is recommend to use them only when you need to hide details in order to build a clean user interface for a re-usable module. Always write nested blocks out literally where possible.
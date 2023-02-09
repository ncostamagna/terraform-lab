resource "aws_instance" "web1" {
    #ami = "${var.ec2_ami}"
    ami = "${lookup(var.ec2_ami, var.region)}"
    instance_type = "t2.micro"

    tags = {
        Name = "web1"
        Owner = "Nahuel TF"
        Env = "dev"
    }
}
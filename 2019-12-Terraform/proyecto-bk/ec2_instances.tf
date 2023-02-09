resource "aws_instance" "nahuel-server1" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"
    count = 1
    #elegimos la VPC en base a la subnet
    subnet_id = "${aws_subnet.subnet1.id}"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.sg-1.id}", "${aws_security_group.sg-2.id}"]
    private_ip = "${var.subnet1_private_ip}"
    key_name = "${aws_key_pair.key-class-1.id}"
    #Pasamos el script sh para las instalaciones
    user_data = "${file("userdata.sh")}"
    tags = {
        Name = "nahuel_1"
        Owner = "terraform"
        Env = "dev"
    }
}

#resource "aws_instance" "nahuel-server2" {
#    ami = "ami-0dacb0c129b49f529"
#    instance_type = "t2.micro"
#    count = 1
#    #elegimos la VPC en base a la subnet
#    subnet_id = "${aws_subnet.subnet1.id}"
#    associate_public_ip_address = true
#    vpc_security_group_ids = ["${aws_security_group.sg-1.id}", "${aws_security_group.sg-2.id}"]
#    private_ip = "10.0.10.11"
#    key_name = "${aws_key_pair.key-class-2.id}"
#
##muy importante que se eliminen los espacios
#    user_data = <<EOF
##!/bin/bash
#export PATH=$PATH:/usr/local/bin
#sudo -i
#echo > >(tee /var/log/user-data.log|logger -t user.data -s 2>/dev/console) 2>&1
#yum install -y httpd
#echo "<html><h1>Hola Terraform Nahuel</h1></html>" > /var/www/html/index.html
#systemctl start httpd
#systemctl enable httpd
#echo "Hola Mundo" > hola.ttx
#EOF
#
#    tags = {
#        Name = "nahuel_server2"
#        Owner = "terraform"
#        Env = "dev"
#    }
#}
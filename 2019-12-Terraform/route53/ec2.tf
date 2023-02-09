resource "aws_instance" "nahuel-server1" {
    ami = "ami-0dacb0c129b49f529"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.route_allow_http_ssh.id}"]
    subnet_id = "${aws_subnet.subnet1.id}"
    private_ip = "198.168.10.11"
    key_name = "${aws_key_pair.key-class-1.id}"

    #este recurso depende de aws_internet_gateway.gw
    depends_on = ["aws_internet_gateway.gw"]
    user_data = "${file("userdata.sh")}"
    tags = {
        Name = "nahuel"
        Owner = "terraform"
        Env = "dev"
    }
}

resource "aws_instance" "nahuel-server2" {
    ami = "ami-0dacb0c129b49f529"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.route_allow_http_ssh.id}"]
    subnet_id = "${aws_subnet.subnet1.id}"
    private_ip = "198.168.10.12"
    key_name = "${aws_key_pair.key-class-1.id}"

    #este recurso depende de aws_internet_gateway.gw
    depends_on = ["aws_internet_gateway.gw"]
    user_data = "${file("userdata2.sh")}"
    tags = {
        Name = "nahuel 2"
        Owner = "terraform"
        Env = "dev"
    }
}
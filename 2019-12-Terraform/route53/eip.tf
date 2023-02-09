#resource "aws_eip" "default" {
#    instance = "${aws_instance.nahuel-server1.id}"
#    vpc = true
#
#    tags = {
#        Name = "Elastic IP Nahuel s1"
#    }
#}

resource "aws_eip" "one" {
    vpc = true
    tags = {
        Name = "Elastic IP Nahuel s1"
    }
}

resource "aws_eip" "two" {
    vpc = true
    tags = {
        Name = "Elastic IP Nahuel s2"
    }
}

resource "aws_eip_association" "eip_server1" {
    instance_id = "${aws_instance.nahuel-server1.id}"
    allocation_id = "${aws_eip.one.id}"
}

resource "aws_eip_association" "eip_server2" {
    instance_id = "${aws_instance.nahuel-server2.id}"
    allocation_id = "${aws_eip.two.id}"
}

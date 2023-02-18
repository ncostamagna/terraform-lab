
#Elastic Load Balancing
#Requiere de un grupo de seguridad
resource "aws_elb" "my_elb" {
    name = "my-elb"
    #Especificamos la zona o las subnet, no ambas
    #availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
    subnets = [ "${aws_subnet.subnet1.id}",  "${aws_subnet.subnet2.id}",  "${aws_subnet.subnet3.id}"]
    security_groups = ["${aws_security_group.elb_http.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 10
    }

    instances = ["${aws_instance.nahuel-server1.id}", "${aws_instance.nahuel-server2.id}"]
    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags = {
        Name = "Nahuel ELB TF"
    }
}

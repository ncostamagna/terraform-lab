resource "aws_route53_zone" "dev" {
    name = "nahuel.terraform-test.com"
    force_destroy = false

    vpc {
        vpc_id = "${aws_vpc.main1.id}"
    }
}

resource "aws_route53_record" "server1" {
    zone_id = "${aws_route53_zone.dev.zone_id}"
    name    = "server1.nahuel.terraform-test.com"
    type    = "A"
    ttl     = "300"
    records = ["${aws_instance.nahuel-server1.private_ip}"]
}

resource "aws_route53_record" "server2" {
    zone_id = "${aws_route53_zone.dev.zone_id}"
    name    = "server2.nahuel.terraform-test.com"
    type    = "A"
    ttl     = "300"
    records = ["${aws_instance.nahuel-server2.private_ip}"]
}

resource "aws_route53_record" "my_elb_name" {
    zone_id = "${aws_route53_zone.dev.zone_id}"
    name    = "mylb.nahuel.terraform-test.com"
    type    = "CNAME"
    ttl     = "300"
    records = ["${aws_elb.my_elb.dns_name}"]
}

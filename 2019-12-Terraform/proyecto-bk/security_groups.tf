resource "aws_security_group" "sg-1" {
  name        = "sg_ping_ssh"
  description = "Nahuel - Permitir ping y ssh"
  vpc_id      = "${aws_vpc.nahuel_tf.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"] #Desde cualquier lugar
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] #Desde cualquier lugar
  }

  egress {
    from_port       = 0 #A cualquier lugar
    to_port         = 0 #A cualquier lugar
    protocol        = "-1" #Cualquier protocolo
    cidr_blocks     = ["0.0.0.0/0"]
  }

    tags = {
        Name = "Nahuel - ping y ssh"
    }
}

resource "aws_security_group" "sg-2" {
  name        = "sg_http"
  description = "Nahuel - Permitir http"
  vpc_id      = "${aws_vpc.nahuel_tf.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Desde cualquier lugar
  }

  ingress {
    from_port   = 433
    to_port     = 433
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Desde cualquier lugar
  }

    tags = {
        Name = "Nahuel - HTTP"
    }
}
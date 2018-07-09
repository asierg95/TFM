# Security groups

resource "aws_security_group" "full-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags {
    Name    = "data-platform-full-access"
  }
}


resource "aws_security_group" "internal-access-full" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks      = ["${aws_vpc.data-platform.cidr_block}"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks      = ["${aws_vpc.data-platform.cidr_block}"]
  }

  tags {
    Name    = "data-platform-internal-access-full"
  }
}

resource "aws_security_group" "internal-bastion-http-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = "${var.bastion_port}"
    to_port   = "${var.bastion_port}"
    protocol  = "tcp"

    cidr_blocks      = ["${aws_vpc.data-platform.cidr_block}"]
  }

  tags {
    Name    = "dcos-internal-bastion-http-access"
  }
}

resource "aws_security_group" "public-http-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags {
    Name    = "dcos-public-http-access"
  }
}

resource "aws_security_group" "admin-http-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["${var.admin_cidr}"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["${var.admin_cidr}"]
  }

  tags {
    Name    = "dcos-admin-http-access"
  }
}

resource "aws_security_group" "admin-ssh-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["${var.admin_cidr}"]
  }

  tags {
    Name    = "dcos-admin-ssh-access"
  }
}

resource "aws_security_group" "admin-vpn-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = 943
    to_port   = 943
    protocol  = "tcp"

    cidr_blocks = ["${var.admin_cidr}"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["${var.admin_cidr}"]
  }

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"

    cidr_blocks = ["${var.admin_cidr}"]
  }

}

resource "aws_security_group" "admin-full-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["${var.admin_cidr}"]
  }

  tags {
    Name    = "kubernetes-admin-full-access"
  }
}

resource "aws_security_group" "internet-access" {
  vpc_id = "${aws_vpc.data-platform.id}"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags {
    Name    = "dcos-internet-access"
  }
}


#resource "aws_security_group" "bastion" {
#	name = "bastion"
#	description = "Allow all traffic"

#	ingress {
#		from_port = 0
#		to_port = 0
#		protocol = "-1"
#		cidr_blocks =  ["0.0.0.0/0"]
#	}

#	egress {
#     		from_port = 0
#     		to_port = 0
#      		protocol = "-1"
#      		cidr_blocks = ["0.0.0.0/0"]
# 	}
#	vpc_id = "${aws_vpc.default.id}"
#}

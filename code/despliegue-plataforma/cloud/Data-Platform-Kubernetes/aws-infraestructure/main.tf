terraform {
  backend "s3" {}
}

provider "aws" {
  region = "${var.region}"
}


#################### AWS Instances ####################################

resource "aws_instance" "masters" {
  count = "${var.master_number_of_instances}"
  ami = "${var.aws_centos_ami}"
  instance_type = "${var.master_instance_type}"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = true
  source_dest_check = false
  subnet_id = "${element(aws_subnet.master-subnet.*.id, count.index)}"

  vpc_security_group_ids = [
    "${aws_security_group.full-access.id}"
  ]

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  root_block_device {
    volume_size = "${var.master_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }

  tags {
    Name = "master-${count.index}"
  }
}

resource "aws_instance" "workers" {
  count = "${var.worker_number_of_instances}"
  ami = "${var.aws_centos_ami}"
  instance_type = "${var.worker_instance_type}"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = true
  source_dest_check = false
  subnet_id = "${aws_subnet.eu-west-1b-public.id}"

  vpc_security_group_ids = [
    "${aws_security_group.full-access.id}"
  ]
	
  availability_zone = "eu-west-1b"

  root_block_device {
    volume_size = "${var.worker_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }

  tags {
    Name = "worker-${count.index}"
  }
}

resource "aws_instance" "bastion" {
  count = 1
  ami = "${var.aws_centos_ami}"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = true
  source_dest_check = false
  subnet_id = "${aws_subnet.eu-west-1b-public.id}"

  vpc_security_group_ids = [
    "${aws_security_group.full-access.id}"
  ]
	
  availability_zone = "eu-west-1b"

  root_block_device {
    volume_size = "${var.bastion_volume_size}"
    delete_on_termination = "${var.volume_delete_on_termination}"
  }

  tags {
    Name = "bastion-${count.index}"
  }
}


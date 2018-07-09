#Networking
resource "aws_vpc" "data-platform" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "Data-Platform-vpc"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.data-platform.id}"
}


#Public subnets

#Masters subnet
resource "aws_subnet" "master-subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  vpc_id = "${aws_vpc.data-platform.id}"

  cidr_block = "${cidrsubnet(cidrsubnet(aws_vpc.data-platform.cidr_block, 1, 1), ceil(log(length(data.aws_availability_zones.available.names) * 2, 2)), count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  tags {
    Name    = "dcos-master-subnet-${data.aws_availability_zones.available.names[count.index]}"
  }
}


#General subnet
resource "aws_subnet" "eu-west-1b-public" {
  vpc_id = "${aws_vpc.data-platform.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-1b"
}

# Routing tables for public subnets

#Masters subnets
resource "aws_route_table" "master-subnet" {
  vpc_id = "${aws_vpc.data-platform.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}
resource "aws_route_table_association" "master-subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id = "${element(aws_subnet.master-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.master-subnet.id}"
}

#General subnet
resource "aws_route_table" "eu-west-1-public" {
  vpc_id = "${aws_vpc.data-platform.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}
resource "aws_route_table_association" "eu-west-1b-public" {
  subnet_id = "${aws_subnet.eu-west-1b-public.id}"
  route_table_id = "${aws_route_table.eu-west-1-public.id}"
}



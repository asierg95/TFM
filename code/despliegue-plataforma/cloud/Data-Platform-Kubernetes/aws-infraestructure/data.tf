#Data availability zones for the masters
data "aws_availability_zones" "available" {
  state = "available"
}


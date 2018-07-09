variable "region" {
  type        = "string"
  description = "The AWS region to use for this master-region."

  default = "eu-west-1"
}

variable "aws_centos_ami" { 
  type        = "string"
  description = "The operating system to use in the instances."

  default = "ami-7abd0209"
}

#Kubernetes Instances
variable "master_instance_type" {
  type        = "string"
  description = "The AWS instance type to use for masters."

}
variable "master_number_of_instances" {
  type        = "string"
  description = "The number of masters to run."

}
variable "master_volume_size" { 
  type        = "string"
  description = "The volume size in GB used for masters instances."

}

variable "worker_instance_type" {
  type        = "string"
  description = "The AWS instance type to use for private slaves."

}
variable "worker_number_of_instances" {
  type        = "string"
  description = "The number of private slaves to run."

}
variable "worker_volume_size" {
  type        = "string"
  description = "The volume size in GB used for private slaves instances."

}

variable "bastion_instance_type" {
  type        = "string"
  description = "The AWS instance type to use for bastion."

}
variable "bastion_volume_size" {
  type        = "string"
  description = "The volume size in GB used for bastion instance."

}
variable "bastion_port" {
  type        = "string"
  description = "The bastion port to use for downloading the dcos-installation.sh script."

}
################

#Delete volumes when Instances terminate
variable "volume_delete_on_termination" {
  type        = "string"
  description = "Volumes will be removed when the instances are removed if true"

}


#AWS Access keys
variable "aws_access_key" {
  type        = "string"
  description = "The AWS access key."

}
variable "aws_secret_key" {
  type        = "string"
  description = "The AWS secret key."

}
variable "aws_key_path" {
  type        = "string"
  description = "The AWS path to the key."

}
variable "aws_key_name" {
  type        = "string"
  description = "The AWS key name."

}


variable "admin_cidr" {
  type        = "string"
  description = "The CIDRs where admins will access from."

}

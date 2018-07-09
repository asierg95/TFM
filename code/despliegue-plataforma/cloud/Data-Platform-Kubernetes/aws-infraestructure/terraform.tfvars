aws_access_key = "$AWS_ACCESS_KEY_ID"
aws_secret_key = "$AWS_SECRET_ACCESS_KEY"
aws_key_name = "asier_gomez"
aws_key_path = "/home/asier/.ssh/asier_gomez.pem"

terragrunt = {
  remote_state {
    backend = "s3"
    config {
      bucket  = "terraform-testing-state"
      key     = "terraform.tfstate"
      region  = "eu-west-1"
      encrypt = true
    }
  }
}

region = "eu-west-1"
volume_delete_on_termination = true

master_instance_type       = "t2.medium"
master_number_of_instances = "3"
master_volume_size         = "8"

worker_instance_type       = "t2.medium"
worker_number_of_instances = "1"
worker_volume_size         = "8"

bastion_instance_type       = "t2.small"
bastion_volume_size         = "8"
bastion_port                = "7171"

admin_cidr = "193.145.247.253/32"



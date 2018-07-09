.PHONY: all plan apply destroy terragrunt_all terragrunt_plan terragrunt_apply terragrunt_destroy

all: plan apply

plan:
	terraform plan -var-file terraform.tfvars

apply:
	terraform apply -var-file terraform.tfvars -auto-approve

destroy:
	terraform destroy -force


terragrunt_all: terragrunt_plan terragrunt_apply

terragrunt_plan:
	terragrunt plan -var-file terraform.tfvars

terragrunt_apply:
	terragrunt apply -var-file terraform.tfvars -auto-approve

terragrunt_destroy:
	terragrunt destroy -force

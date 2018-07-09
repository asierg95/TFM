#!/bin/bash

##Create infrastructure and inventory file
echo "Creating infrastructure"
cd aws-infraestructure && 
make terragrunt_all &&

##Aprovision with Ansible playbooks
echo "Ansible provisioning" &&
cd ../ansible-provision &&
/bin/bash wait.sh &&
make wait-ssh &&
make change-hostnames &&
make ssh-keys &&
make kubernetes-ha 
make hdfs3 &&
make spark &&
make vpn


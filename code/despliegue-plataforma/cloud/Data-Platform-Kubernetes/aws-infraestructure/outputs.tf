#################### ANSIBLE Inventory (IPs) ####################################
######### General config ###############
resource "null_resource" "ansible-provision" {
 
depends_on = ["aws_instance.masters", "aws_instance.bastion", "aws_instance.workers"]

triggers = {
  filename = "test-${uuid()}"
}

##clean file
provisioner "local-exec" {
  command =  "truncate -s 0 ../ansible-provision/inventory/hosts.ini"
}


######### MASTERS ###############
#Private IP#
provisioner "local-exec" {
  command =  "echo \"\n[masters]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"${join("\n", aws_instance.masters.*.private_ip)}\" >> ../ansible-provision/inventory/hosts.ini"
}

#Public IP#
provisioner "local-exec" {
  command =  "echo \"\n[masters_public]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"${join("\n", aws_instance.masters.*.public_ip)}\" >> ../ansible-provision/inventory/hosts.ini"
}
###################################

######### WORKERS ###############

#Private IP#
provisioner "local-exec" {
  command =  "echo \"\n[workers]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"${join("\n", aws_instance.workers.*.private_ip)}\" >> ../ansible-provision/inventory/hosts.ini"
}

#Public IP#
provisioner "local-exec" {
  command =  "echo \"\n[workers_public]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"${join("\n", aws_instance.workers.*.public_ip)}\" >> ../ansible-provision/inventory/hosts.ini"
}
###################################


######### BASTION ###############
#Private IP
provisioner "local-exec" {
  command =  "echo \"\n[bastion]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"${join("\n", aws_instance.bastion.*.private_ip)}\" >> ../ansible-provision/inventory/hosts.ini"
}

#Public IP
provisioner "local-exec" {
  command =  "echo \"\n[bastion_public]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"${join("\n", aws_instance.bastion.*.public_ip)}\" >> ../ansible-provision/inventory/hosts.ini"
}
###################################

######### ALL NODES PARENT ###############

##Agents
provisioner "local-exec" {
  command =  "echo \"\n[agents:children]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"workers_public\" >> ../ansible-provision/inventory/hosts.ini"
}

##Nodes
provisioner "local-exec" {
  command =  "echo \"\n[nodes:children]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"agents\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"masters_public\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"bastion_public\" >> ../ansible-provision/inventory/hosts.ini"
}
###############################

######### SSH-KEYS ###############
#Public IP
provisioner "local-exec" {
  command =  "echo \"\n[ssh_control]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"${aws_instance.masters.0.public_ip}\" >> ../ansible-provision/inventory/hosts.ini"
}

provisioner "local-exec" {
  command =  "echo \"\n[nodes:vars]\" >> ../ansible-provision/inventory/hosts.ini"
}
provisioner "local-exec" {
  command =  "echo \"ssh_control=${aws_instance.masters.0.public_ip}\" >> ../ansible-provision/inventory/hosts.ini"
}
###################################

################################################################


####WAIT SCRIPT####
##Make executable file
provisioner "local-exec" {
  command =  "sed -i '4s/.*/List=\"${join(" ", aws_instance.masters.*.public_ip)} ${join(" ", aws_instance.workers.*.public_ip)} ${join(" ", aws_instance.bastion.*.public_ip)}\"/g' ../ansible-provision/wait.sh"
}

}

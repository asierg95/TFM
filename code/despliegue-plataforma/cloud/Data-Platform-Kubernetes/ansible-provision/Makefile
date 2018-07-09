.PHONY: hdfs3 dcos change-hostnames vpn ssh-keys wait-ssh kubernetes spark kubernetes-ha

hdfs3: 	
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini hdfs3/main.yml

dcos:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini dcos/main.yml

change-hostnames:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini change-hostnames/main.yml

vpn:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini vpn/main.yml

ssh-keys:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini ssh-keys/main.yml

wait-ssh:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini wait-ssh/main.yml

kubernetes:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini kubernetes/main.yml

spark:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini spark/main.yml

kubernetes-ha:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini kubernetes-ha/main.yml

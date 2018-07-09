.PHONY: change-hostnames traefik ntp ssh-keys spark prometheus grafana hdfs3 kubernetes-ha

change-hostnames: 	
	cd change-hostnames && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass
	
traefik:
	cd traefik && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass

ntp:
	cd ntp && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass

ssh-keys:
	cd ssh-keys && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass

spark:
	cd spark && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass

prometheus:
	cd prometheus && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass

grafana:
	cd grafana && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass

hdfs3: 	
	cd hdfs3 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass
	
kubernetes-ha:
	cd kubernetes-ha && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory/hosts.ini main.yml --ask-become-pass



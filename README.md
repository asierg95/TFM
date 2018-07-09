# TFM
DevOps Applied to Big Data platforms and monitorization code and documentation


## Quick Start

Deploy Big Data Plataform locally:
```
1. Install Ansible (check docs)
2. Deploy the Ansible playbooks inside "code\despliegue-plataforma\local" directory using the Makefile
```

Deploy Big Data Plataform AWS:

```
1. Install Terraform (check docs)
2. Deploy the "cluster-setup.sh" script inside "code\despliegue-plataforma\cloud" directory.
```

Deploy Kafka in Kubernetes:
```
1. Access Kubernetes
2. Deploy the YAMLs inside "code\despliegue-kafka"
```

Deploy Spark apps:
```
1. Generate the JARs with the projects inside "code\spark-apps"
2. Deploy the JARs on Spark" check the docs for getting the metrics.
```
Grafana add Dashboards:

```
1. Copy the JSONs dashboard to Grafana
```

#!/bin/bash

##Remove infrastructure
echo "Removing infrastructure"
cd aws-infraestructure &&
make terragrunt_destroy




#!/bin/bash

for dir in 01-vpc 02-sg 03-bastion 04-db 05-vpn 06-app-alb; do
  echo "Processing $dir"
  cd $dir
  terraform init
  terraform apply -auto-approve
  cd ..
done

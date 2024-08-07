#!/bin/bash

for dir in 09-frontend 08-web-alb 07-backend 06-app-alb 05-vpn 04-db 03-bastion 02-sg 01-vpc; do
  echo "Processing $dir"
  cd $dir
  terraform destroy -auto-approve
  cd ..
done



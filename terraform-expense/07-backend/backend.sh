#!/bin/bash

dnf install ansible -y
pip3.9 install botocore boto3
ansible-pull -i localhost, -U https://github.com/Praveen6417/Ansible.git main.yml -e component=$component -e env=$environment
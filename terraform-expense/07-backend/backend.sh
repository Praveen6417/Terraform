dnf install ansible -y
pip3.9 install botocore boto3
ansible-pull -i localhost, -U https://github.com/Praveen6417/Ansible.git main.yaml -d Ansible-roles-Practice -e component=$component -e env=$environment
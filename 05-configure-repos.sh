#!/bin/bash
ansible -i inventory all -u root -m shell -a 'rm -rf /etc/yum.repos.d/*'
ansible -i inventory all -u root -m yum_repository -a "name=BaseOS description=BaseOS baseurl=ftp://controller.example.com/BaseOS enabled=True gpgcheck=False"
ansible -i inventory all -u root -m yum_repository -a "name=AppStream description=AppStream baseurl=ftp://controller.example.com/AppStream enabled=True gpgcheck=False"
cat > ./hosts << EOF
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.122.100 controller.example.com controller
192.168.122.101 node1.example.com node1
192.168.122.102 node2.example.com node2
192.168.122.103 node3.example.com node3
192.168.122.104 node4.example.com node4
EOF
ansible -i inventory all -u root -m copy -a "src=./hosts dest=/etc/hosts"

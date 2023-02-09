#!/bin/bash
export PATH=$PATH:/usr/local/bin
sudo -i
echo > >(tee /var/log/user-data.log|logger -t user.data -s 2>/dev/console) 2>&1
yum install -y httpd curl bind-utils
echo "<html><h1>Hola Terraform Nahuel</h1><h3>server 1</h3></html>" > /var/www/html/index.html
hostname -f >> /var/www/html/index.html
systemctl start httpd
sleep 60

for ((i = 1; i<=5; i++)); do curl -v "http://mylb.nahuel.terraform-test.com" >> /var/www/html/index.html ; done

systemctl enable httpd
echo "Hola Mundo" > hola.ttx
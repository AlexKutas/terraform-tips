#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
myip=$(curl curl https://ifconfig.me/)

cat <<EOF >  /var/www/html/index.html
<html>
<h2>Build by Power of Terraform</h2></br>

IP: ${myip}</br>
Version: 3.0
</html>
EOF


systemctl restart httpd
chkconfig httpd on
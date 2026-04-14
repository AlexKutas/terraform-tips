#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
myip=$(curl curl https://ifconfig.me/)

cat <<EOF >  /var/www/html/index.html
<html>
<h2>Build by Power of Terraform</h2>
Owner: ${f_name} ${l_name}</br>

%{ for name in names ~}
Hello to ${name} from ${f_name}</br>
%{ endfor ~}
</html>
EOF


systemctl restart httpd
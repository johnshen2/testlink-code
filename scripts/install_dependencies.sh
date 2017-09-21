#!/bin/bash
set -e
sudo yum update -y
sudo yum install -y httpd24 php70 mysql56-server php70-mysqlnd
yum install -y php-mysql
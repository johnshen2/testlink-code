#!/bin/bash
# Setup Ruby on Rails, MySql, Apache + Passenger
# on Amazon Ubuntu instance (ubuntu 12)
# 21/08/2012
# Source: http://designbye.wordpress.com/2009/10/10/how-to-setup-rorpassengermysqlubuntu-server-on-ec2/

echo Updating system...
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install build-essential
sudo apt-get install curl libcurl4-openssl-dev
sudo apt-get install zlib1g-dev libssl-dev libexpat1-dev

echo Installing tools...
sudo apt-get install apache2 apache2-threaded-dev
sudo apt-get install ruby ri rdoc ruby1.8-dev irb libreadline-ruby1.8
sudo apt-get install libruby1.8 libopenssl-ruby libopenssl-ruby1.8
sudo apt-get install mysql-server libmysqlclient15off mysql-client-5.0
sudo apt-get install mysql-common mysql-server-5.0 libmysqlclient-dev
sudo apt-get install libmysql-ruby libmysql-ruby1.8 psmisc

sudo apt-get install subversion
sudo apt-get install git-core gitweb

echo Installing ruby gems...
cd /usr/local/src
sudo wget http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz
sudo tar -zvxf rubygems-1.3.5.tgz
cd rubygems-1.3.5/
sudo ruby setup.rb
sudo gem update --system

echo Symlinking...
sudo ln -s /usr/bin/gem1.8 /usr/local/bin/gem
sudo ln -s /usr/bin/ruby1.8 /usr/local/bin/ruby
sudo ln -s /usr/bin/rdoc1.8 /usr/local/bin/rdoc
sudo ln -s /usr/bin/ri1.8 /usr/local/bin/ri
sudo ln -s /usr/bin/irb1.8 /usr/local/bin/irb

echo Installing Gems...
sudo gem install sys-proctable --no-rdoc --no-ri
sudo gem install rails --no-rdoc
sudo gem install mysql --no-rdoc --no-ri
sudo gem install capistrano rspec rdoc --no-rdoc --no-ri
sudo gem install passenger --no-rdoc --no-ri
sudo gem install haml --no-rdoc --no-ri
sudo gem install hpricot --no-rdoc --no-ri
sudo gem install json --no-rdoc --no-ri
sudo gem install newrelic_rpm --no-rdoc --no-ri
sudo gem install sqlite3 --no-rdoc --no-ri
sudo gem install will_paginate --no-rdoc --no-ri
sudo gem install authlogic --no-rdoc --no-ri
sudo gem install cached_model --no-rdoc --no-ri

echo Installing Phusion Passenger
sudo passenger-install-apache2-module

echo Enabling Phusion Passenger
sudo cp passenger.load /etc/apache2/modules-available/.
sudo ln -s /etc/apache2/modules-available/passenger.load /etc/apache2/modules-enabled/passenger.load

echo Set up virtual host. Add the following to /etc/apache2/sites-available/default
cat virtual.txt

echo Add "Listen 8080" and "NameVirtualHost *:8080" to /etc/apache2/ports.conf

echo Restart apache.

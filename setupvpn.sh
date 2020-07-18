#!/bin/bash
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.4.list
echo "deb http://repo.pritunl.com/stable/apt xenial main" > /etc/apt/sources.list.d/pritunl.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 0C49F3730359A14518585931BC711F9BA15703C6
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-get --assume-yes update
apt-get --assume-yes upgrade
apt-get --assume-yes install pritunl mongodb-org iptables
systemctl start pritunl mongod
systemctl enable pritunl mongod
ext_ip=$(curl ifconfig.me)
ssl_domain="$(echo $ext_ip | sed 's/\./-/g').sslio.ip"
echo ""
echo "Managamrnt inerface:"
echo "https://$ssl_domain"
echo ""
echo "Let's encrypt domain for FINE SSL !!!"
echo $ssl_domain

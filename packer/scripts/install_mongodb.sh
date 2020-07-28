#!/usr/bin/env bash
echo "Preinstal step"
 apt update
 apt-get install apt-transport-https ca-certificates git -y

gpg_key_is=$(apt-key list | grep 058F8B6B -c)
if [ "$gpg_key_is" -eq 0 ]
then
 wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc |  apt-key add -
 echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" |  tee /etc/apt/sources.list.d/mongodb-org-4.2.list
else
 echo "Mongokey is installed"
fi

mongo_is=$(dpkg --list | grep -i mongodb-org  -c)
if [ "$mongo_is" -eq 0 ]
then
  apt update
  apt install -y mongodb-org
fi

dbSvc_status=$( systemctl status mongod | grep "Active: active (running)" -c)
if [ "$dbSvc_status" -eq 0 ]
then
  systemctl start mongod
  systemctl enable mongod
fi

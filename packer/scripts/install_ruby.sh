#!/usr/bin/env bash
echo "Preinstall pkg"
apt update
apt install -y  make gcc-5

ruby_inst=""
rubyFull_is=$(dpkg --list | grep -i ruby-full -c)
rubyBundl_is=$(dpkg --list | grep -i ruby-bundler -c)
buildEss_is=$(dpkg --list | grep -i build-essential -c)
if [ "$buildEss_is" -eq 0 ]
then
 echo "Installing build-essential..."
  apt update
  apt-get install -y build-essential
fi

if [ "$rubyFull_is" -eq 0 ] && [ "$rubyBundl_is" -eq 0 ]
then
 echo "Installing ruby-full ruby-bundler..."
  apt update
  apt-get install -y ruby-full ruby-bundler
else
 if [ "$rubyFull_is" -eq 1 ] && [ "$rubyBundl_is" -eq 0 ]
  then
   echo "Installing ruby-bundler..."
    apt update
    apt-get install -y ruby-bundler
 fi
fi

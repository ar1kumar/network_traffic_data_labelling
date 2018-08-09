#!/bin/bash

#Installs additional utilities required for the build

#CICFlowMeter

#Arachni web scanner


#Install java sdk8
sudo su -
cat >/etc/apt/sources.list.d/webupd8team-java.list<< EOF
deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
EOF
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java8-installer
java -version


#Required - Gatling load testing tool

#Required scala - sbt - Linux installation
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt


#Run two or more process simultaneously
# command_followed_by &
malicious_module.sh &
benign_module.sh &

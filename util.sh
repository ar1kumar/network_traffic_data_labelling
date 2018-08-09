#!/bin/bash

#Installs additional utilities required for the build

#CICFlowMeter

#Arachni web scanner

#1. TAURUS - setup and installation
sudo apt-get update
sudo apt-get install python default-jre-headless python-tk python-pip python-dev libxml2-dev libxslt-dev zlib1g-dev net-tools
sudo pip install bzt
#Upgrading to latest is as simple as this:
sudo pip install --upgrade bzt
#to install Taurus
pip install bzt
# Upgrade is only:
pip install --upgrade bzt

#If there is no JMeter installed at the configured path,
#Taurus will attempt to install latest JMeter and Plugins into this location,
#by default ~/.bzt/jmeter-taurus/{version}/bin/jmeter.

#2.JAVA jdk8 - setup and installation
sudo su -
cat >/etc/apt/sources.list.d/webupd8team-java.list<< EOF
deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
EOF
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java8-installer
java -version


#3. GATLING LOAD TESTING/SIMULATION TOOL - Required

#4. SCALA cli- sbt - Linux installation - optional
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get update
sudo apt-get install sbt



#Run two or more process simultaneously
#command_followed_by &
#malicious_module.sh &
#benign_module.sh &

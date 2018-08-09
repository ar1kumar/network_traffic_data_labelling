#!/bin/bash

#reusuable time functions and variables
timestamp(){
 date +"%Y-%m-%d %T"
}


C_DATE=$(date +"%d-%m-%Y")

#Variable definitions



#Select the appropriate simulation type
if [ $# -eq 0 ]; then
  #no command line arguments
  #Select the default simulation file
  SIM_PROFILE="Default"
else
  #command line argument for type of benign simulation to run
  SIM_PROFILE=$1
fi

#Launch Benign activity
#1. Gatling load testing/simulation
# printf '{simulation_number}\n{simulation_id}\n{Run description}'
# \n represents a new line
echo "$(timestamp) - Started benign traffic activity"
printf '0\n0\n0' | /root/Documents/gatling_user_testing/bin/gatling.sh

#2. Taurus load testing - uses JMeter
#Install dependencies - mentioned in utils.#!/bin/sh
#site, ip, activity, scenario and other configurations are done in {config}.yml
# to run -
#bzt config_file.yml
bzt http_traffic.yml

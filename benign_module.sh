#!/bin/bash

#reusuable time functions and variables
timestamp(){
 date +"%Y-%m-%d %T"
}


C_DATE=$(date +"%d-%m-%Y")

#command for logging outputs to a different file
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log-benign-$C_DATE.out 2>&1

#Variable definitions



#Start TCPdump
tcpdump -i eth0 -w $FILE_NAME.pcap &
pid=$!


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
# printf '{simulation_number}\n{simulation_id}\n{Run description}'
# \n represents a new line
printf '0\n0\n0' | /root/Documents/gatling_user_testing/bin/gatling.sh

#Stop tcpdump
kill $pid

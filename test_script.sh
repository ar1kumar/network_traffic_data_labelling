#!/bin/bash

#reusuable function to log timestamp
timestamp(){
 date +"%Y-%m-%d %T"
}


C_DATE=$(date +"%d-%m-%Y")

#logging outputs to a file
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log-test-$C_DATE.out 2>&1

#Variable definitions
WP_APP_URL="http://10.0.2.6/"
WP_ADMIN_URL="http://10.0.2.6/admin/"

#Command line argument for naming the files
echo "command line arguments -"
echo $1
echo "----------------------"
if [ $# -eq 0 ]; then
  echo "value of 1 & 2 is null"
  FILE_NAME="$C_DATE.experiment"
  TRAFFIC_LABEL="Malicious"
else
  FILE_NAME=$1
  TRAFFIC_LABEL=$2
fi
# Everything below will go to the file 'log.out':

#Start postgresql for Metasploit to save vulns in db
echo "$(timestamp) - Start postgresql service"
service postgresql start

#Start tcpdump
echo "$(timestamp) - Start tcp dump"
tcpdump -i eth0 -w $FILE_NAME.pcap &
pid=$!

#Start probing
#NMAP commands


#Start attacks

#Run set of pre configured attacks from Docker
#docker run --rm -it -p 443:443 -v ~/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data -e TARGET_HOST=10.0.2.6 -e MS_COMMAND="load wmap; wmap_sites -a 10.0.2.6; wmap_targets -t http://10.0.2.6; wmap_run -e;" automated-msattack-cmdasarg-03

#List of attacks
#1 Get directory listing
echo "$(timestamp) - Start Attack #1{custom attack label}"
# msfconsole -q -x "use auxiliary/scanner/http/dir_scanner; set RHOSTS 10.0.2.6; run; exit;"

#Start malicious & benign traffic simultaneously
./malicious_module.sh &
./benign_module.sh

#2 Arachni web testing
# /root/Documents/arachni-security-test/bin/arachni "$WP_APP_URL"

#Stop the tcpdump process
echo "$(timestamp) - Stop TCPdump process"
kill $pid

#Convert captured traffic data(pcap) into bitflow information(csv)
#Create alias for the CICFlowmeter binary file
#alias cflowmeter=/root/Documents/cicflowmeter-4/CICFlowMeter-4.0/bin/cfm

#Switch to bitflow binary directory
cd bitflow_converter/bin

#Convert pcap to csv -> save it in bitflow_data folder
echo "$(timestamp) - Convert pcap to csv"
#./cfm input_pcap_file output_csv_flow
./cfm ../../$FILE_NAME.pcap ../../bitflow_data

#Exit folder
cd ../../


#Adding custom label to the csv file
# awk -v label="$TRAFFIC_LABEL" '$84=label' FS=, OFS=, bitflow_data/$FILE_NAME.pcap_Flow.csv > bitflow_data/$FILE_NAME.labelled.pcap_Flow.csv

#!/bin/bash

#Target machine flow
#1. listen for custom ping request
#2. if custom ping request found then start tcpdump - capture network traffic
#3. listen to another custom ping request notifying the end of packet capturing
#4. if received - stop TCPdump
#5. convert pcap tp csv



#reusuable function to log timestamp
timestamp(){
 date +"%Y-%m-%d %T"
}


C_DATE=$(date +"%d-%m-%Y")

#logging outputs to a file
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log-target-machine-WP-$C_DATE.out 2>&1

#Variable definitions
FILE_NAME="$C_DATE.experiment"

#Start tcpdump
echo "$(timestamp) - Start tcp dump"
tcpdump -i enp0s3 -w $FILE_NAME.pcap &
pid=$!


#Stop tcpdump process
kill $pid

#Convert the captured network traffic(pcap) data to bitflow information(csv)

#Switch to bitflow convertor binary directory
cd bitflow_converter/bin

#Convert pcap to csv -> save it in bitflow_data folder
echo "$(timestamp) - Convert pcap to csv"
#./cfm input_pcap_file output_csv_flow
./cfm ../../$FILE_NAME.pcap ../../bitflow_data

#Exit folder
cd ../../

#Adding custom label to the csv file
awk -v label_B="Benign" -v label_M="Malicious" -v malicious_ip="10.0.2.4" -v benign_ip="10.0.2.7" '{ if ($2 == benign_ip && $3 == benign_ip) {$84=label_B}; else{$84=label_M}; print}' FS=, OFS=, bitflow_data/$FILE_NAME.pcap_Flow.csv > bitflow_data/$FILE_NAME.labelled.pcap_Flow.csv

#!/bin/bash
#Reusuable timestamp function
timestamp(){
  date +"%Y-%m-%d %T"
}

echo "$(timestamp) - Malicious script launched"

#Start attacks
echo "$(timestamp) - Start Attack #1{attack_name_placeholder}"

#Variable definition
WP_IP=$1

echo "wp variable -- $WP_IP -- $1"
#Directory listing
msfconsole -q -x "use auxiliary/scanner/http/dir_scanner; set RHOSTS $WP_IP; run; exit;"

#2 Arachni web testing
# /root/Documents/arachni-security-test/bin/arachni "$WP_APP_URL"

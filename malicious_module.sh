#!/bin/bash
echo "test"
echo "can you log me?"

#Start attacks
echo "$(timestamp) - Start Attack #1{attack_name_placeholder}"
msfconsole -q -x "use auxiliary/scanner/http/dir_scanner; set RHOSTS 10.0.2.6; run; exit;"

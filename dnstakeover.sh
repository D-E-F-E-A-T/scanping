#!/bin/bash
echo 'fase 1'
for palavra in $(cat lista.txt);do host -t cname $palavra.$1;done | egrep "is an alias" |cut -d ' ' -f 1 > dom.tmp
echo 'fase 2'
for dom in $(cat dom.tmp);do host $dom | grep 'NXDOMAIN' | cut -d ' ' -f 2 ;done 

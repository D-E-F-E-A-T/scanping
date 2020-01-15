#!/bin/bash
for palavra in $(cat lista.txt);do host $palavra.$1;done | egrep -v "not found"

#!/bin/bash
for nameserver in $(host -t ns $1 | cut -d " " -f4 | sed s/.$//);do host -l -a $1 $nameserver;done

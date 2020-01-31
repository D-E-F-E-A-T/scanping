#!/bin/bash
#lynx -dump "http://google.com/search?num=100&q=site:"$1"+ext:"$2"" | grep ".$2" | cut -d "=" -f2 | egrep -v "site|google" | sed 's/...$//g'
#lynx -dump "http://google.com/search?num=100&q=site:"$1"+ext:"$2"" | grep ".$2"

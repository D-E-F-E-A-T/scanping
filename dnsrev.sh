for ip in $(seq 224 239);do host -t ptr 37.59.174.$ip;done | grep -v "37-59-174" | cut -d " " -f 5

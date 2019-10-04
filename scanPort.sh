#!/bin/bash
if [ "$1" == "" ]
then
	echo  "Agrege un argumento"
else
for ip in {1..254};
do
hping3 -S -p 80 -c 1 $1.$ip 2> /dev/null | grep "flags=SA" | awk -F " " '{print $2}' | cut -d '=' -f2;
done
fi

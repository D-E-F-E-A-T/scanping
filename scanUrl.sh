#!/bin/bash
if [ "$1" == "" ]
then
	echo "Falta argumento"
else
	wget $1 -o scanUrl.txt
fi

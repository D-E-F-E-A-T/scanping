#!/bin/bash
if [ "$1" == "" ]
then
	echo "Por favor coloque um parametro."
	echo "$0 192.168.0.0/24"
else
	## Cada variable es para una red
	redeA=$(echo "$1"| awk -F '.' '{print $1"."}')
	redeB=$(echo "$1"| awk -F '.' '{print $1"."$2"."}')
	redeC=$(echo "$1"| awk -F '.' '{print $1"."$2"."$3"."}')
	## Variavel da mascara
	mask=$(echo "$1"| awk -F '/' '{print $2}')

	case $mask in
		8)
		echo -e "Escaneo de la red \e[44m$redeA\e[0m0.0.0 con la mascara $mask" 
		for host0 in {0..255};do for host1 in {0..255};do for host3 in {1..254};do ping -a -i 0.2 -c 1 "192.168.$host0.$host1" | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//' ;done;done;done
		;;
		16)
		echo -e "Escaneo de la red \e[44m$redeB\e[0m0.0 con la mascara $mask"
		for host0 in {0..255};do for host1 in {1..254};do ping -a -i 0.2 -c 1 "192.168.$host0.$host1" | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//' ;done;done
		;;
		"")
		echo -e "Asiginacion \e[44mautomatica\e[0m de la red /24"
		for host in {1..254};do ping -a -i 0.2 -c 1  $redeC$host | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//' ;done
		;;
		24)
		echo -e "Escaneo de la red \e[44m$redeC\e[0m0 con la mascara $mask" 
		for host in {1..254};do ping -a -i 0.2 -c 1  $redeC$host | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//' ;done
		;;
		*)
		echo "Nao e uma rede valida"
		echo "As redes validas sao /8, /16 y /24"
		;;
	esac

fi

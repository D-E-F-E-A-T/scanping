#!/bin/bash
if [ "$1" == "" ]
then
	echo "Por favor coloque um parametro."
	echo "$0 192.168.0.0/24"
else
cat << "EOF"
          _ _,---._
       ,-','       `-.___
      /-;'               `._
     /\/          ._   _,'o \
    ( /\       _,--'\,','"`. )
     |\      ,'o     \'    //\
     |      \        /   ,--'""`-.
     :       \_    _/ ,-'         `-._
      \        `--'  /                )
       `.  \`._    ,'     ________,','
         .--`     ,'  ,--` __\___,;'
          \`.,-- ,' ,`_)--'  /`.,'
           \( ;  | | )      (`-/
             `--'| |)       |-/
               | | |        | |
               | | |,.,-.   | |_
               | `./ /   )---`  )
              _|  /    ,',   ,-'
             ,'|_(    /-<._,' |--,
             |    `--'---.     \/ \
             |          / \    /\  \
           ,-^---._     |  \  /  \  \
        ,-'        \----'   \/    \--`.
       /            \              \   \

   _____                                  _                 
  / ____|                                (_)                
 | (___     ___    __ _   _ __    _ __    _   _ __     __ _ 
  \___ \   / __|  / _` | | '_ \  | '_ \  | | | '_ \   / _` |
  ____) | | (__  | (_| | | | | | | |_) | | | | | | | | (_| |
 |_____/   \___|  \__,_| |_| |_| | .__/  |_| |_| |_|  \__, |
                                 | |                   __/ |
                                 |_|                  |___/ 
					by Domenico Delvalle
EOF
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
		for host in {1..254};do ping -a -i 0.2 -c 1  $redeC$host | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//' && > dome.txt;done 
		;;
		24)
		echo -e "Escaneo de la red \e[44m$redeC\e[0m0 con la mascara $mask" 
		for host in {1..254};do ping -a -i 0.2 -c 1  $redeC$host | sed -n 2p | awk -F' ' '{if($1=="64") print "'$redeC$host' \033[0;32mActivo\033[0m";else print "'$redeC$host' \033[0;31mInativo\033[0m"}';done
		;;
		*)
		echo "Nao e uma rede valida"
		echo "As redes validas sao /8, /16 y /24"
		;;
	esac

fi

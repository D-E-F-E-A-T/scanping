#!/bin/bash
for palavra in $(cat lista2.txt)
do
resposta1=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" -o /dev/null -w "%{http_code}" $1/$palavra/)
resposta2=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" -o /dev/null -w "%{http_code}" $1/$palavra)
resposta3=$(curl -s -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:72.0) Gecko/20100101 Firefox/72.0" -o /dev/null -w "%{http_code}" $1/$palavra.$2)
if [ $resposta1 == "200" ]
then
echo "Diretorio encontrado: http://$1/$palavra/"
fi
if [ $resposta2 == "200" ]
then
echo "Arquivo encontrado: http://$1/$palavra"
fi
if [ $resposta3 == "200" ]
then
echo "extencao $2 encontrado: http://$1/$palavra.$2"
fi
done


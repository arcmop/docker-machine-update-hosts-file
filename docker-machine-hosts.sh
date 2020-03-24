#! /bin/bash
set -e

FILEHOST=$1
DOCKERVM=$2
OLDIFS=$IFS; IFS=$'\n'; 
for p in $(cat $FILEHOST);
do 
  server=$(printf '%s\n' "$p")
  echo "Agregar: $server"
  result=$(docker-machine ssh $DOCKERVM "echo $server | sudo tee -a /etc/hosts > /dev/null" > /dev/null)
  echo "Agregado: $server"
done; 
IFS=$OLDIFS

printf "\nListado de entradas en archivo /etc/hosts dentro de VM=$DOCKERVM \n\n"

docker-machine ssh docker-machine-client 'cat /etc/hosts'

#!/bin/bash

if [ $# -ne 1 ]
then
  echo "EL script espera recibir 1 parámetro"
  
	else if [ -e "$1" ] #para detectar los espacios en blanco al comprobar el nombre del archivo/directorio
		then
		  echo "EL archivo o directorio $1 Existe"
		else
		  echo "El archivo o directorio $1 no existe"
		fi
fi




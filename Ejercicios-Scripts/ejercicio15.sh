#!/bin/bash


if [ $# -ne 1 ]
then
	echo "El script espera recibir un parámetro"
	

	elif [ -f "$1" ]   #parámetro entrecomillado para detectar los espacios en blanco
		then
			echo "$1 Es un archivo existente"
			
	elif [ -d "$1" ]
		then
			 echo " $1 Es un directorio existente"
		else
			 echo "El elemento $1 no es un archivo o directorio existente"
	
fi

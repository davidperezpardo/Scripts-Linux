#!/bin/bash



if [ $# -eq 0 ]
	then 
		echo "No has introducido ningún parámetro"
		echo "Debe introducir al menos 1 parámetro:ruta/nombre directorio"
		exit 1
		
	else
		mkdir $1
		echo "directorio creado!"
		exit 0
fi



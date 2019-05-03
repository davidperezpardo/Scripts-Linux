#!/bin/bash



if [ $# -ne 2 ]
	then
		echo "Debe introducir al menos 2 parámetros"
		echo "primero: ruta/nombre directorio a crear"
		echo "segundo: ruta/nombre archivo a copiar"
		exit 1
	else
		mkdir $1
		cp $2 $1
		echo "directorio creado en la ruta:$1"
		echo "archivo $2 copiado en el directorio $1"
		exit 0
fi

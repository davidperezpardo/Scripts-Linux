#!/bin/bash


mkdir $1 #con esto bastaría, $1 espera un parámetro,que sería nombre y ruta


# con el if para evaluar el exit code
# exit code = 0 ejecucion correcta
# exit code != 0 error en la ejecucion
# $? obtiene el exit code del comando anterior ejecutado

if [ $? -eq 0 ]
then
   echo "Carpeta creada con éxito"
 else
   echo "hubo un error,inténtelo de nuevo"

fi

#!/bin/bash

#con el primer parametro crea la carpeta copiaa
#con el segundo copia el archivo pasado como parámetro,y lo pega en el parámetro 1,qeu es la carpeta creada

mkdir $1 
cp  $2 $1

echo "creado"

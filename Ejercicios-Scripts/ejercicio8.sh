#!/bin/bash


cat $2

echo "EL exit code es:$?"

if [ $? -eq 0 ]
then
  echo "Archivo abierto"
else
  echo "Error al abrir archivo: $2"
fi

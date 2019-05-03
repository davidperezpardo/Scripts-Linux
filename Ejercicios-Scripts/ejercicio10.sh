#!bin/bash

if [ $# -eq 0 ]
then
  echo "No has introducido ningún parámetro"
else
  params=$#
  echo "ha introducido $params parámetros"
  echo "Estos son los parámetros introducidos:$@"
 fi

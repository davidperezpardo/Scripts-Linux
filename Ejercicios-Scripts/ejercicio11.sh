#!/bin/bash

if [ $# -eq 0 ]
then
	
  echo "No has introducido ningún parámetro"
  exit 1
else
  echo "Ha introducido $# parámetros"
  echo "Los parámetros introducidos son los siguientes:$@"
  exit 0 
  
fi

#!/bin/bash

#PRACTICA2 SCRIPT
#AUTHOR: DAVID PÉREZ PARDO


#comprobación de si existe el directorio "arespaldar"

dirArespaldar="arespaldar"
dirBackups="misbackups"
backup="backup_"$(date +"%Y%m%d") # año,mes y día de la ejecución del script

#cabecera del archivo.log
echo -e "====== LÍNEAS PERTENECIENTES A  $backup ====== "$(date)"\n" >> backup.log


if	[ ! -d "$dirArespaldar" ]
	then
		echo -e "El directorio a respaldar no existe,no se creó ninguna copia de seguridad!\n">> backup.log	
		exit 1
fi


#si existe el directorio a respaldar..
if	[ -d "$dirArespaldar" ]
	then	
			#Si no tiene el usuario permisos de ejecución sobre el directorio...
			if	[ ! -x "$dirArespaldar" ]
					then
				
						echo -e "No se creó ninguna copia de seguridad,no tienes permiso de ejecución sobre el directorio $dirArespaldar \n">>backup.log
						exit 3
				fi
				
				#Si no tiene el usuario permisos de lectura sobre el directorio...
			if	[ ! -r "$dirArespaldar" ]
					then
				
						echo -e "No se creó ninguna copia de seguridad,no tienes permiso de lectura sobre el directorio $dirArespaldar \n">>backup.log
						exit 4
				fi
				
		#si el directorio donde se almacenarán las copias no existe,se intenta crear...
		if  [ ! -d "$dirBackups" ]
			then
				
				mkdir misbackups 2>>backup.log #si hay error al crear directorio,lo mando al backup.log

				#si no se pudo crear...
				if	[	$? -ne 0 ]
					then
					
						echo -e"\nError al crear el directorio para backups,no pudo crearse!">> backup.log					
						exit 2
						
					else
						echo "Directorio para guardar los backups creado con éxito!">> backup.log	
				fi
		fi	
		
		#si existe el directorio donde se almacenarán las copias...
		if	[	-d "$dirBackups" ]
			then
					
				#Hago backups,silenciando mensajes por consola del comando y guardando en el log algún error si lo hubiese.
				tar cvfz "$dirBackups"/"$backup".tar.gz  arespaldar 2>>backup.log > /dev/null
						
						
				#ELimino backups de más de 30 días...		
				find misbackups/ -mtime +30 -type f -exec rm {} \; 2>>backup.log
		
				echo -e "La copia de seguridad se ha realizado con éxito!\n">> backup.log
				exit 0
						
		fi	
			
fi	


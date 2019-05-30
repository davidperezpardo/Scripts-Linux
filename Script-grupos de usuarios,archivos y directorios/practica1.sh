#!/bin/bash



#Función para mostrar la ayuda al usuario
function ayuda {

cat << TEXTO

				¡Uso incorrecto del comando $0!
				==========================================
					
Se esperaba la siguiente sintaxis:
	
	$0 [-u NombreDeUSuario] [-g] [-d] [-f]
		
			
		-g --> Muestra los grupos a los que pertenece el usuario
			
		-d --> Muestra el número de directorios del directorio de usuario
			
		-f --> Muestra el número de archivos del directorio de usuario
			
Debiéndose especificar al menos uno de los 3 parámetros.
		
 "De no especificar el nombre de usuario,se obtendrá la información de
		todos los usuarios del sistema".
		 
 							Author:David Pérez Pardo
 														
TEXTO
}



#Funcion para obtener los datos de todos los usuarios a partir de los parámetros
function usuarios {

	if [ $# -eq 0 ]
		then
			local users=$(cat /etc/passwd|cut -d ":" -f1)
		else
			users="$1"
	fi		
	
	
	
	#Obtiene el nombre de cada usuario del sistema

	
	for i in $users
	do
	
		#obtenemos el directorio de cada usuario del fichero /etc/passwd
		dirUsuario=$( cat /etc/passwd|grep "$i"|cut -d ":" -f6 )
		
		#si se especifica -g (grupos)
		if	[ ${parametros[g]} -eq 1 ] 
	
			then
				echo	"Grupos del usuario $(groups $i)"
				
		fi
	
	
		#si se especifica -d (directorios)
		if	[ ${parametros[d]} -eq 1 ]
			then
		
				#se cuentan directorios del directorio del usuario (no se muestran los ocultos)
				echo	"Nº de directorios- del directorio de usuario $i: $( ls -l $dirUsuario 2>/dev/null|grep "^d"|wc -l)"
		fi
		
		#si se especifica -f (ficheros)
		if	[ ${parametros[f]} -eq 1 ]
			then
			
			#se cuentan archivos del directorio del usuario (no se muestran los ocultos)
			echo "Nº de -archivos- del directorio de usuario $i: $( ls -l $dirUsuario 2>/dev/null|grep "^-"|wc -l)"
		
		fi
		
		echo	"======================================================================="


	done


} #fin funcion usuarios.



#Para controlar los parámetros introducidos en cada momento.
declare -A parametros=([g]=0 [d]=0 [f]=0) 
declare -i numParams=0	 #variable contador
declare -i existe=0


#Getops con bucle while para procesar los parámetros.

while getopts ":u:gdf" opcion; do
	case $opcion in
	
		u)
					   	 	
				 #Comprobamos si existe el usuario (silenciamos errores del sistema)
				 comprueba=$(cat /etc/passwd|grep -w "$OPTARG" 2>/dev/null|cut -d ":" -f1)
					
					if	[ -n "$comprueba" ]
						then
							usuario=$comprueba #si existe,guardamos el nombre de usuario 
						  existe=1 #true
						  
						#sino, si se introduce algun parámetro sin nombre de usuario,se procesan.	
						elif [ "$OPTARG" = "-g" ]		
							then	
								
							 parametros[g]=1 # si es = 1,se especificó como parámetro...
			  			((numParams++))  # para llevar la cuenta de los parámetros
							 existe=0 #no existe (false)
						
						elif [ "$OPTARG" = "-d" ]		
							then	
								
							 parametros[d]=1 #*
			  			((numParams++))
							 existe=0 #no existe (false)
							 
						elif [ "$OPTARG" = "-f" ]		
							then	
									
							 parametros[f]=1 #*
			  			((numParams++))
							 existe=0 #no existe (false)
						else
							
							echo  "Usuario $OPTARG no existe en el sistema"
							exit 1				 
					fi
						
				 			
			;;
			
		g)
				parametros[g]=1 # si es = 1,se especificó como parámetro...
			 ((numParams++))	#para llevar la cuenta de los parámetros
			 
				
			;;
			
		d)
				parametros[d]=1 #*
			 ((numParams++))
				
			;;
		
		f)
		  	parametros[f]=1 #*
			  ((numParams++))
				
			
			;;
			
		 \?)
		 
					#Llamada a la función ayuda,si se especifica un parámetro inexistente.
					ayuda
					exit 1
				;;
			
			 *)
					#si no se especificó ningún parámetro para (-u) se muestra ayuda.
					ayuda
					exit 1
				;;
			

			
	esac

done


#Si no se especificó ningúno de los 3 parámetros,salimos y mostramos la ayuda.
if  [ $numParams -eq 0 ]
	then
		ayuda #funciona que muestra la ayuda
		exit 1
	elif  [ "$existe" -eq 1 ] #si se pasa al menos un parámetro,y existe el usuario,llamamos a la funcion.
		then
			usuarios $usuario #se pasa el nombre de usuario obtenido a la funcion "usuarios"
	elif  [ "$existe" -eq 0 ]
		then
			usuarios

			
fi




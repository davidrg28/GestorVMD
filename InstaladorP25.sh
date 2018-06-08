#!/bin/bash

<<C1
Desde que se ha creado este fichero es obligatoria usarlo para instalar el script de la practica.
Cuando termine su instalacion se llamara al scrit con el comando "GestorVMD"
La función COMB se encarga de escribir en el ficheor ".bashrc" unas lineas explicando las variables que he escrito.
Si esto se borra el comando dejaria de aparecer para poder ejecutar el script.
C1

#Función que escribe en el .bashrc.
function COMB {

				echo -e '\n#Esta linea se añadira para el funcionamiento del script para la gestion de VirtualBox.' >> ".bashrc"
				echo -e '#Si esta linea es borrada dejara de funcionar el script siendo necesario su instalacion de nuevo.' >> ".bashrc"
				echo -e "DIRDS="$DIRDS"" >> ".bashrc"
				echo -e 'PATH=$PATH:$HOME/$DIRDS' >> ".bashrc"
				echo -e "" >> ".bashrc"
				echo -e "Se ha terminado la instalación"
				sleep 4
				echo -e "A partir de ahora deberas usar el comando 'GestorVMD' para gestionar las maquinas virtuales"
				sleep 8
				cd "$UBC"
				clear
				exec bash
}

#Este if comprueba que se ejecuta sin argumentos, luego mira si la carpeta donde se va a copiar el programa esta disponible o no.
#Una vez disponible la carpeta copiara todos los ficheros en ella y le dara permisos de lectura y ejecución.
if [ "$#" -eq "0" ]
	then
		clear
		DIRDS=".GestorVMD"
		UBC=$(pwd)
		cd "$HOME"
		BUCL="n"
		while [ "$BUCL" = "n" ]
		do
			if [ -e "$DIRDS" ]
				then
					clear
					echo -e "La carpeta donde se va a instalar ya existe en la ruta ($HOME)"
					echo -e "Por favor introduzca otro nombre para esta carpeta."
					read -e -p "=> " DIRUSR
					DIRDS=".$DIRUSR"
				else
					BUCL="s"
				fi
		done
		mkdir "$DIRDS"
		cd "$UBC/programa"
		cp -Rf * "$HOME/$DIRDS"
		cp -Rf "funciones/.ControlPRL" "$HOME/$DIRDS/funciones/ControlPR"
		mkdir "$HOME/$DIRDS/funciones/listado"
		cd "$HOME"
		chmod -R 700 "$DIRDS"
		COMB
	else
		clear
		echo -e "No se permite ejecutar este script con argumentos"
fi

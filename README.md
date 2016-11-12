# ffmpeg-install
Instalación de FFMPEG sobre Ubuntu Server

Script de instalacion de FFMPEG
 Versiones de software:
    Ubuntu server 14.04 LTS
 		Blackmagic_Desktop_Video_Linux_10.8.2 
		Blackmagic_DeckLink_SDK_10.8 
		FFMPEG 3.2 
 Fecha de actualizacion: 03 NOVIEMBRE 2016
 Actualizado por Juan Carlos Ramirez

Instalacion validada sobre Ubuntu 14.04 LTS

Copiar el fichero ffmpeg_src.tar.gz en el /home/<user> del servidor.

Ubicarse en la carpeta /home/<user>

Descomprimir: 
	sudo tar -xvpf ffmpeg_src.tar.gz

Dar permisos de ejecuion al script de instalacion:
	sudo chmod +x ffmpeg_install.sh

Ejecutar el archivo de instalacion de la siguiente manera en la carpeta home/user:

sudo ./ffmpeg_install.sh 

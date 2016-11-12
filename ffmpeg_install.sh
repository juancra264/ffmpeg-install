#!/bin/bash

# ***********************************************************************************************************************
# Script de instalacion de FFMPEG
# 		Ubuntu Server 14.04 LTS
#       Blackmagic_Desktop_Video_Linux_10.8.2 
#		Blackmagic_DeckLink_SDK_10.8 
#		FFMPEG 3.2 
# Fecha de actualizacion: 03 NOVIEMBRE 2016
# Actualizado por Juan Carlos Ramirez
# ***********************************************************************************************************************

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with admin privileges 'sudo'"
    echo "exiting...."
    exit 1
fi

echo "******************************************"
echo "*"
echo "* Installing ffmpeg on Ubuntu Server"
echo "*"
echo "*******************************************"

echo "*********************************"
echo "*"
echo "* 1/5 Update apt-get"
echo "*"
echo "*********************************"

apt-get -y upgrade
apt-get -y update

echo "*********************************"
echo "*"
echo "* 2/5 Install needed build tools"
echo "*"
echo "*********************************"
apt-get -y --force-yes install build-essential checkinstall git libfaac-dev libjack-jackd2-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libsdl1.2-dev libtheora-dev libva-dev libvdpau-dev libvorbis-dev libx11-dev libxfixes-dev texi2html zlib1g-dev libssl1.0.0 libssl-dev libxvidcore-dev libxvidcore4 libass-dev
apt-get -y --force-yes install autoconf automake build-essential libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo zlib1g-dev
apt-get -y install yasm
apt-get -y install libx264-dev
apt-get -y install dkms
apt-get -y install libmp3lame-dev
apt-get -y install libopus-dev

echo "*********************************"
echo "*"
echo "* 3/5 Install RMTP modules"
echo "*"
echo "*********************************"
cd ~/ && git clone git://git.ffmpeg.org/rtmpdump && cd rtmpdump && version="$(git log -1 --abbrev-commit | grep commit | cut -d' ' -f2)" && make VERSION="v2.4\ $version~git" && sudo checkinstall --pakdir "$HOME/Desktop" --pkgname rtmpdump --pkgversion "2.4-$version~git" --backup=no --default && sudo ldconfig
sudo ldconfig

echo "*********************************"
echo "*"
echo "* 4/5 Install BlacmAgic Drivers"
echo "*"
echo "*********************************"
cd ~/
cd src
cd Blackmagic_Desktop_Video_Linux_1082/
sudo dpkg -i deb/amd64/desktopvideo_10.8.2a4_amd64.deb
BlackmagicFirmwareUpdater status
cd ..

echo "*********************************"
echo "*"
echo "* 5/5 Install FFMPEG"
echo "*"
echo "*********************************"

sudo chmod 777 -R ffmpeg-3.2/
cd ffmpeg-3.2/

sudo PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --pkg-config-flags="--static" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="$HOME/bin" --enable-gpl --enable-libass --enable-libfreetype --enable-libtheora --enable-libopencore-amrnb --enable-libvorbis --enable-libx264  --enable-libmp3lame --enable-version3 --enable-nonfree  --enable-librtmp --enable-libopus  --enable-decklink --extra-cflags=-I$HOME/src/Blackmagic_DeckLink_SDK_108/Linux/include --extra-ldflags=-L$HOME/src/Blackmagic_DeckLink_SDK_108/Linux/include
sudo PATH="$HOME/bin:$PATH" make
sudo make install
sudo make distclean
# Ajuste el script para ejecucion en el sistema
sudo ln -s ~/bin/ffmpeg /usr/bin/ffmpeg

echo "*********************************"
echo "*"
echo "* Instalation Complete"
echo "*"
echo "*********************************"

echo "*********************************"
echo "*"
echo "* Revision de Drivers BlackMagic"
echo "*"
echo "*********************************"
BlackmagicFirmwareUpdater status
echo " Favor revisar si se debe actualizar los drivers y reiniciar la maquina"

# ***********************************************************************************************************************



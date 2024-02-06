#!/usr/bin/env bash

###############################################
# probando el system tray
###############################################
sleep 2

# necesita el paquete volumeicon-alsa
# debo buscar otro tray para pulse audio
# o pipe wire cuando lo use del todo
pgrep -x volumeicon > /dev/null || volumeicon &

# a veces dropbox no carga.  Así que le doy 1 seg de espera
sleep 1
dropbox start -i &


# tanto nm-applet como nm-tray son para la conexion de red
# creo que nm-applet viene con xfce
# en cambio nm-tray es independiente aunque está en Qt
# tal vez instale muchas dependencias
# se instala con sudo apt install nm-tray
# tambien tiene un paquete de idiomas nm-tray-l10n
pgrep -x nm-tray > /dev/null || nm-tray &
pgrep -x nm-applet > /dev/null || nm-applet &


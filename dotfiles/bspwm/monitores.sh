#!/bin/bash

#######################################
#  script que detecta si están conectados 1 ó 2 monitores
#  para asignar los espacios de trabajo a cada monitor
#  y también configurar las pantallas con arandr
#  que de hecho son otros 2 scripts
#######################################
#  en bspwm no funciona bien si lo hago en caliente
#  asigna mal los monitores del 5 al 0
########################################

# detectar el numero de monitores
SCREEN=$(xrandr | grep " connected " | wc -l)
# la variable SCREEN valdría 1, 2, 3, etc, dependiendo del
# numero de monitores que detecte el comando xrandr



########################################################
      # esto sería sin el monitor externo
      if [[ $SCREEN -eq 1 ]]; then
        # Resolución de la pantalla con script creado con arandr
        $HOME/.screenlayout/resolucion.sh
        MONITOR1=$(xrandr | grep " connected " | awk '{print $1}')
        # asignar los 10 workspaces a la pantalla interna
        bspc monitor $MONITOR1 -d 1 2 3 4 5 6 7 8 9 0
      fi

########################################################
      # y con 2 monitores
      if [[ $SCREEN -eq 2 ]]; then
        # Resolución de las pantallas con script creado con arandr
        $HOME/.screenlayout/resolucion-2p.sh
        # asignar los workspaces a cada pantalla
        MONITOR1=$(xrandr | grep " connected " | awk '{print $1}'| sed -n 1p)
        MONITOR2=$(xrandr | grep " connected " | awk '{print $1}'| sed -n 2p)
        bspc monitor $MONITOR1 -d 1 2 3 4 5
        bspc monitor $MONITOR2 -d 6 7 8 9 0
      fi

#########################################################


# el script solo está para 2 monitores que es lo que uso
# se agregaría otro if para un tercer monitor
#########################################################
# adicional, dependiendo del número de monitores
# se lanzan distintas barras de polybar
# ver archivos launch.sh y config en carpeta de polybar
#########################################################
#########################################################

#!/usr/bin/env bash


#######################################
#  script que para reasignar los espacios de trabajo
#  dependiendo del numero de monitores conectados
#  y también configurar las pantallas con arandr
#  que de hecho son otros 2 scripts
#######################################

##############################################################################
#  Este es mi antiguo script que ahora solo serviria para configurar la resolucion de las pantallas

# detectar el numero de monitores
SCREEN=$(xrandr | grep " connected " | wc -l)
# la variable SCREEN valdría 1, 2, 3, etc, dependiendo del
# numero de monitores que detecte el comando xrandr

########################################################
      # esto sería sin el monitor externo
      if [[ $SCREEN -eq 1 ]]; then
        # Resolución de la pantalla con script creado con arandr
        $HOME/.screenlayout/resolucion.sh
      fi

########################################################
      # y con 2 monitores
      if [[ $SCREEN -eq 2 ]]; then
        # Resolución de las pantallas con script creado con arandr
        $HOME/.screenlayout/resolucion-2p.sh
      fi


########################################################
########################################################
#  asignar o reasignar los Espacios de Trabajo - "desktops" - a cada monitor
sleep 1

INTERNAL_MONITOR=$(xrandr | grep " connected " | awk '{print $1}'| sed -n 1p)
EXTERNAL_MONITOR=$(xrandr | grep " connected " | awk '{print $1}'| sed -n 2p)

# Agregar un Desktop temporal al monitor Externo, se necesita al menos uno por monitor
bspc monitor "$EXTERNAL_MONITOR" -a Desktop

# reasigno todos los desktops al monitor interno 
for i in 6 7 8 9 0
do
bspc desktop "$i" --to-monitor "$INTERNAL_MONITOR"
done

# si el monitor externo está conectado, le asigno de nuevo los Desktops 6,7,8,9 y 0
if [[ $(xrandr -q | grep "${EXTERNAL_MONITOR} connected") ]]; then
	for desktop in $(bspc query -D --names -m "$INTERNAL_MONITOR" | sed -n '6,10p'); do
		bspc desktop "$desktop" --to-monitor "$EXTERNAL_MONITOR"
	done
fi

# Elimino el desktop temporal
bspc desktop Desktop --remove
bspc desktop Desktop --remove
# En ocasiones no se elimina - así que pongo el comando 2 veces 
# y en ocasiones no se cambian los monitores al primer reset :-)

#  visto en:  https://github.com/miikanissi/dotfiles/blob/master/.local/bin/bspwm_setup_monitors.sh
#  con algunos cambios sencillos


#########################################################
# el script solo está para 2 monitores que es lo que uso
# se agregaría otro if para un tercer monitor
#########################################################
# adicional, dependiendo del número de monitores
# se lanzan distintas barras de polybar
# ver archivos launch.sh y config en carpeta de polybar
#########################################################
#########################################################

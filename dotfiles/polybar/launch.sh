#!/usr/bin/env bash

# killall polybar

## Files and Directories
DIR="$HOME/.config/polybar"
SFILE="$DIR/system"
RFILE="$DIR/.system"
MFILE="$DIR/.module"

## Get system variable values for various modules
get_values() {
	CARD=$(basename "$(find /sys/class/backlight/* | head -n 1)")
	BATTERY=$(basename "$(find /sys/class/power_supply/*BAT* | head -n 1)")
	ADAPTER=$( "$(find /sys/class/power_supply/*AC* | head -n 1)")
	INTERFACE=$(ip link | awk '/state UP/ {print $2}' | tr -d :)
}

## Write values to `system` file
set_values() {
	if [[ "$ADAPTER" ]]; then
		sed -i -e "s/adapter = .*/adapter = $ADAPTER/g" "$SFILE"
	fi
	if [[ "$BATTERY" ]]; then
		sed -i -e "s/battery = .*/battery = $BATTERY/g" "$SFILE"
	fi
	if [[ "$CARD" ]]; then
		sed -i -e "s/graphics_card = .*/graphics_card = $CARD/g" "$SFILE"
	fi
	if [[ "$INTERFACE" ]]; then
		sed -i -e "s/network_interface = .*/network_interface = $INTERFACE/g" "$SFILE"
	fi
}

## Launch Polybar with selected style
launch_bar() {
	CARD=$(basename "$(find /sys/class/backlight/* | head -n 1)")
	if [[ "$CARD" != *"intel_"* ]]; then
		if [[ ! -f "$MFILE" ]]; then
			sed -i -e 's/backlight/brightness/g' "$DIR"/config
			touch "$MFILE"
		fi
	fi

###########################################################
# hasta aquí el archivo es el original de axyl linux bspwm
# se agregan unas lineas para detectar el número de monitores
# conectados y lanzar diferentes barras de polybar
###########################################################

	if [[ ! $(pidof polybar) ]]; then
           # averiguar el numero de monitores conectados
           SCREEN=$(xrandr | grep " connected " | wc -l)
           # La variable SCREEN valdrá 1, 2, 3, etc dependiendo lo que detecte xrandr

           if [[ $SCREEN -eq 1 ]]; then
		sleep 1
                polybar -q barra-unica -c "$DIR"/config &
                echo "Bars launched..."
           fi

           if [[ $SCREEN -eq 2 ]]; then
                # Lanzar las 2 barras
                sleep 1
		polybar -q barra-int -c "$DIR"/config &
                sleep 2
                pantalla2=$(xrandr | grep " connected " | awk '{print $1}' | sed -n 2p)
		MONITOR=$pantalla2 polybar -q barra-ext -c "$DIR"/config &
                echo "Bars launched..."
           fi

	else
		polybar-msg cmd restart
	fi
}

# Execute functions
if [[ ! -f "$RFILE" ]]; then
	get_values
	set_values
	touch "$RFILE"
fi

launch_bar

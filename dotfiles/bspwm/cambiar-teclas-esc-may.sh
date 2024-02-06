#!/bin/sh

# script para intercambiar las funciones de las teclas
# Escape y Bloqueo de Mayúsculas
# con el comando xev debo averiguar el keycode de cada tecla
# El keycode de Esc es 9   y la tecla de Bloq May tiene el 66
# primero cambio la funcion de la tecla mayuscula
xmodmap -e "clear Lock"
xmodmap -e "keycode 66 = Escape"


# luego la función de la tecla Escape
xmodmap -e "keycode 163 = Caps_Lock"


# también asigno la función de Tecla super a la tecla que 
# está al lado derecho entre Alt Gr y Ctrl derecho
xmodmap -e "keycode 135 = Super_L"





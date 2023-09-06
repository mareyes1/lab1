#!/bin/bash

if [ $# -ne 2 ]; then #verificar que se pasen 2 argumentos en línea de comandos
    echo "Uso: $0 <nuevo_usuario> <nuevo_grupo>"
    exit 1
fi

nuevo_usuario="$1"
nuevo_grupo="$2"

if id "$nuevo_usuario" &>/dev/null; then #verificar si usuario ya existe
    echo "El usuario '$nuevo_usuario' ya existe"
else
    useradd "$nuevo_usuario" #crea nuevo usuario si no existía
    echo "Se ha creado el nuevo usuario '$nuevo_usuario'."
fi

if getent group "$nuevo_grupo" &>/dev/null; then #verificar si grupo ya existe
    echo "El grupo '$nuevo_grupo' ya existe"
else
    groupadd "$nuevo_grupo" #crea el nuevo grupo si no existía
    echo "Se ha creado el grupo '$nuevo_grupo'."
fi

usermod -aG "$nuevo_grupo" "$USER" #agrega el usuario default al nuevo grupo
usermod -aG "$nuevo_grupo" "$nuevo_usuario" #agrega el nuevo usuario al nuevo grupo
chown :"$nuevo_grupo" script1.sh #asigna permisos de ejecución para el grupo al script1.sh del punto 1
chmod 750 script1.sh

echo "### Se asignaron permisos de ejecución al grupo '$nuevo_grupo' para el script1.sh del punto #1 ###"

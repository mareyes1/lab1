#!/bin/bash

# Verificar que se ha proporcionado un archivo como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 <archivo>"
    exit 1
fi

archivo="$1"

# Verificar si el archivo existe
if [ ! -e "$archivo" ]; then
    echo "El archivo '$archivo' no existe."
    exit 2
fi

# Obtener los permisos del archivo
permisos=$(stat -c "%A" "$archivo")

# Función para obtener permisos verbales
get_permissions_verbose() {
    local permisos="$1"
    usuario="${permisos:1:3}"
    grupo="${permisos:4:3}"
    otros="${permisos:7:3}"

    echo "Permisos del usuario: "
    [ "${usuario:0:1}" = "r" ] && echo "Leer" || echo "No leer"
    [ "${usuario:1:1}" = "w" ] && echo "Escribir" || echo "No escribir"
    [ "${usuario:2:1}" = "x" ] && echo "Ejecutar" || echo "No ejecutar"

    echo "Permisos del grupo: "
    [ "${grupo:0:1}" = "r" ] && echo "Leer" || echo "No leer"
    [ "${grupo:1:1}" = "w" ] && echo "Escribir" || echo "No escribir"
    [ "${grupo:2:1}" = "x" ] && echo "Ejecutar" || echo "No ejecutar"

    echo "Permisos de otros: "
    [ "${otros:0:1}" = "r" ] && echo "Leer" || echo "No leer"
    [ "${otros:1:1}" = "w" ] && echo "Escribir" || echo "No escribir"
    [ "${otros:2:1}" = "x" ] && echo "Ejecutar" || echo "No ejecutar"
}

# Llamar a la función para obtener permisos verbales
get_permissions_verbose "$permisos"

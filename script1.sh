#!/bin/bash

if [ $# -ne 1 ]; then #se verifica que se pase un solo argumento
    echo "Uso: $0 <nombre_del_archivo>"
    exit 1
fi

archivo="$1" #se asigna archivo pasado como argumento a una variable

if [ ! -e "$archivo" ]; then #si archivo no existe imprime mensaje y devuelve codigo de error
    echo "Error: El archivo '$archivo' pasado como parámetro no existe"
    exit 2 #codigo de error para archivo inexistente
fi

permisos=$(stat -c "%A" "$archivo") #si archivo existe se almacenan permsisos en variable

get_permissions_verbose() {
    local string_permisos="$1"
    usuario="${string_permisos:1:3}"
    grupo="${string_permisos:4:3}"
    otros="${string_permisos:7:3}"

    echo "Permisos del usuario: "
    [ "$usuario:0:1" = "r" ] && echo "Lectura" || "No lectura"
    [ "$usuario:1:1" = "w" ] && echo "Escritura" || "No escritura"
    [ "$usuario:2:1" = "x" ] && echo "Ejecución" || "No ejecución"

    echo "Permisos del grupo: "
    [ "$grupo:0:1" = "r" ] && echo "Lectura" || "No lectura"
    [ "$grupo:1:1" = "w" ] && echo "Escritura" || "No escritura"
    [ "$grupo:2:1" = "x" ] && echo "Ejecución" || "No ejecución"

    echo "Permisos de otros: "
    [ "$otros:0:1" = "r" ] && echo "Lectura" || "No lectura"
    [ "$otros:1:1" = "w" ] && echo "Escritura" || "No escritura"
    [ "$otros:2:1" = "x" ] && echo "Ejecución" || "No ejecución"
}

get_permissions_verbose "$permisos"

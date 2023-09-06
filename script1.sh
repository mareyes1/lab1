#!/bin/bash

if [ $# -ne 1 ]; then #verificar que se pase solo un argumento
    echo "Uso: $0 <nombre_del_archivo>"
    exit 1 #sale con código de error
fi

archivo="$1"

if [ ! -e "$archivo" ]; then #verifica si el archivo existe o da codigo y mensaje de error
    echo "El archivo '$archivo' no existe"
    exit 2 #código de error de archivo inexistente
fi

permisos=$(stat -c "%A" "$archivo") #obtiene string de permisos del archivo

get_permissions_verbose() {  #función para permisos versión extendida (verboso)
    local permisos="$1" #obtiene el string de permisos
    usuario="${permisos:1:3}" #permisos del usuario están desde la posición 1 y 3 espacios
    grupo="${permisos:4:3}" #permisos del grupo tres espacios desde la posición 4 del string
    otros="${permisos:7:3}" #permisos de otros siguientes tres posiciones

    echo "Permisos del usuario: "
    [ "${usuario:0:1}" = "r" ] && echo "Lectura" || echo "No lectura"
    [ "${usuario:1:1}" = "w" ] && echo "Escritura" || echo "No escritura"
    [ "${usuario:2:1}" = "x" ] && echo "Ejecución" || echo "No ejecución"

    echo "Permisos del grupo: "
    [ "${grupo:0:1}" = "r" ] && echo "Lectura" || echo "No lectura"
    [ "${grupo:1:1}" = "w" ] && echo "Escritura" || echo "No escritura"
    [ "${grupo:2:1}" = "x" ] && echo "Ejecución" || echo "No ejecución"

    echo "Permisos de otros: "
    [ "${otros:0:1}" = "r" ] && echo "Lectura" || echo "No lectura"
    [ "${otros:1:1}" = "w" ] && echo "Escritura" || echo "No escritura"
    [ "${otros:2:1}" = "x" ] && echo "Ejecución" || echo "No ejecución"
}
get_permissions_verbose "$permisos" #Llamar a la función de permisos verbose pasandole el string de permisos

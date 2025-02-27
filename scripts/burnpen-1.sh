#!/usr/bin/bash 

if [ $# -ne 2 ]; then
  echo "Syntax: $0 <ficheiro ISO> <dispositivo>"
  exit 1
fi

iso="$1"
dev="$2"

if [ ! -f "$iso" ]; then
  echo "Erro: O primeiro argumento deve ser um ficheiro ISO"
  exit 2
fi

if [ ! -b "$dev" ]; then
  echo "Erro: O segundo argumento deve ser um dispositivo"
  exit 3
fi


sudo dd bs=4M if="$iso" of="$dev" conv=fsync oflag=direct status=progress

echo
echo "Imagem Gravada no Dispositivo USB"

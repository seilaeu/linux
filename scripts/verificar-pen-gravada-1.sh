#!/usr/bin/bash 

if [ $# -ne 2 ]; then
  echo "Syntax: $0 <dispositivo> <ficheiro_ISO>"
  exit 1
fi

dev="$1"
iso="$2"

if [ ! -b "$dev" ]; then
  echo "Erro: O primeiro argumento deve ser um dispositivo"
  exit 2
fi

if [ ! -f "$iso" ]; then
  echo "Erro: O segundo argumento deve ser um ficheiro ISO"
  exit 3
fi

size="$(stat -c %s "$iso")"

echo "Verificando $size bytes..."
sudo cmp -n $size "$dev" "$iso"

if [ $? -eq 0 ]; then echo "A pen e o ficheiro ISO são idênticos"; fi

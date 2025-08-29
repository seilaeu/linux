#!/usr/bin/bash 

if [ $# -ne 2 ]; then
  echo "Syntax: $0 <ficheiro_ISO> <dispositivo>"
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

size="$(stat -c %s "$iso")"

echo "Verificando $size bytes..."
sudo cmp -n $size "$iso" "$dev"

if [ $? -eq 0 ]; then echo "O ficheiro ISO e a pen e o são idênticos"; fi

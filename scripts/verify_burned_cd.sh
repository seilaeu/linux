#!/usr/bin/bash 

if [ $# -ne 2 ]; then
  echo "Syntax: $0 medium_device iso_file"
  exit 1
fi

dev="$1"
iso="$2"

if [ ! -b "$dev" ]; then
  echo "Error: The first argument must be a block device."
  exit 2
fi

if [ ! -f "$iso" ]; then
  echo "Error: The second argument must be an ISO file."
  exit 3
fi

size="$(stat -c %s "$iso")"

echo "Verifying $size bytes..."
cmp -n $size "$dev" "$iso"

if [ $? -eq 0 ]; then echo "The media and the ISO file are identical."; fi

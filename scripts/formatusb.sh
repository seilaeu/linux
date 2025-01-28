#!/bin/bash

readarray -t devicevar < <(sudo lsblk --nodeps -no name | egrep -v 'sda|sr0')

# Prompt the user to select one of the lines.
echo "Please select a drive:"
select drive in "${devicevar[@]}"; do
  [[ -n $drive ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done

sudo mkfs.ext4 /dev/$drive
echo
echo Dispositivo Formatado!

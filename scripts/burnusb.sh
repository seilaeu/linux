#!/bin/bash

# Read command output line by line into array ${lines [@]}
# Bash 3.x: use the following instead:

readarray -t isovar < <(sudo ls -1 /home/$USER/Transferências/ |grep -F "iso" |grep -Fv "torrent")

# Prompt the user to select one of the lines.
echo "Please select a iso file:"
select iso in "${isovar[@]}"; do
  [[ -n $iso ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done



readarray -t devicevar < <(sudo lsblk --nodeps -no name | grep -Ev 'sda|sr0')

# Prompt the user to select one of the lines.
echo "Please select a drive:"
select drive in "${devicevar[@]}"; do
  [[ -n $drive ]] || { echo "Invalid choice. Please try again." >&2; continue; }
  break # valid choice was made; exit prompt.
done

# Split the chosen line into ID and serial number.
read -r id sn unused <<<"$drive"

sudo dd bs=4M if=/home/$USER/Transferências/$iso of=/dev/$drive conv=fsync oflag=direct status=progress  
echo
echo "Imagem Gravada no Dispositivo USB"


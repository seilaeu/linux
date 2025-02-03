#! /bin/bash

echo
echo
echo
echo "Instalador do Arch Linux" 
echo
echo
echo

# Teclado português

loadkeys pt-latin9


# Verificar modo de arranque

cat /sys/firmware/efi/fw_platform_size

echo
echo
echo

sleep 3


# Interface de rede

echo "Interface de rede" 

echo
echo
echo

ip link

echo
echo
echo

sleep 3


# Ligação à Internet

echo "Ligação à Internet" 

echo
echo
echo

ping -c 3 archlinux.org

echo
echo
echo

sleep 3


# Relógio

timedatectl set-ntp true

echo "Verificar data e hora" 

echo
echo
echo

date

echo
echo
echo 

sleep 3


# Partições


echo "Formatar e montar a partição raiz"
echo "(ext4 ou btrfs)"

echo
echo
echo

read formatar_raiz

case $formatar_raiz in
          ext4)
     echo
     echo
     echo
     mkfs.ext4 -L arch /dev/sdaX
     echo
     echo
     echo
     echo "A partição raiz foi formatada em ext4"
     mount /dev/sdaX /mnt
     echo
     echo
     echo
     lsblk
     echo
     echo
     echo
     sleep 3
     ;;
          btrfs) 
     echo
     echo
     echo
     mkfs.btrfs -f -L arch /dev/sdaX
     echo
     echo
     echo
     echo "A partição raiz foi formatada em btrfs"
     echo
     echo
     echo
     mount /dev/sdaX /mnt
     btrfs sub create /mnt/@
     umount -l /mnt
     mount -o noatime,space_cache=v2,compress=zstd,ssd,discard=async,subvol=@ /dev/sdaX /mnt
     echo
     echo
     echo
     lsblk
     echo
     echo
     echo
     sleep 3
     ;;
          *) 
     echo
     echo
     echo
     echo "Não foi feita nenhuma alteração" 
     echo
     echo
     echo
     ;;     
esac

echo 
echo
echo

echo "Formatar a partição efi?"
echo "(sim ou não)"

echo
echo
echo

read formatar_efi

case $formatar_efi in
          sim)
      mkfs.fat -F32 -n efi /dev/sdaY
      echo
      echo
      echo
      echo "A partição efi foi formatada"
      echo
      echo
      echo
      ;;
          não) 
     echo
     echo
     echo
     echo "A partição efi não foi formatada"
     echo
     echo
     echo
     ;;
          *)
     echo
     echo
     echo
     echo "Não foi feita nenhuma alteração" 
     echo
     echo
     echo
     ;;  
esac

echo 
echo
echo 


echo "Montar a partição efi?"
echo "(sim ou não)"

echo
echo
echo

read montar_efi

case $montar_efi in
          sim)
      mount --mkdir /dev/sdaY /mnt/boot/efi
      echo
      echo
      echo
      echo "A partição efi foi montada"
      echo
      echo
      echo
      lsblk
      echo
      echo
      echo
      ;;
          não) 
     echo
     echo
     echo
     echo "A partição efi não foi montada"
     echo
     echo
     echo
     ;;
          *)
     echo
     echo
     echo
     echo "Não foi feita nenhuma alteração" 
     echo
     echo
     echo
     ;;  
esac

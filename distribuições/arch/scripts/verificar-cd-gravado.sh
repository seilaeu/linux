#!/bin/bash
#shell script to verify a burned iso

# Sets the path to iso
if [ -e "$1" ] ; then 
	ISOFILE=$1
else
	echo "Introduza o caminho completo para o ficheiro ISO"
	read -e ISOFILE
	echo
	if [ ! -e "$ISOFILE" ] ; then
		echo -e "Caminho ou ficheiro não existem, por favor tente outra vez \n"  
                get_iso_path
	fi
fi 

echo "Isofile: " $ISOFILE
DVDDRIVE=/dev/sr0
BYTES=2048

#Get the number of extends
NROFEXTENDS=$(($(ls -l $ISOFILE | awk '{ print $5 }') / $BYTES ))
echo "Nr of extends: " $NROFEXTENDS

#Get MD5 sum of DVD
dd if=$DVDDRIVE bs=$BYTES count=$NROFEXTENDS | md5sum

#Get MD5 sum of iso file
md5sum $ISOFILE 

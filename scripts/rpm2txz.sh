for file in *.rpm 
do rpm2txz -nd $file 
done

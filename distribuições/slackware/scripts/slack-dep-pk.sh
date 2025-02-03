#!/bin/sh
#search for missing library dependencies
#there are false positives because programs set LD_LIBRARY_PATH to find libs
#pk 20230804 public domain
#don't care these are missing (speech-dispatcher modules):
BLACKLIST='libbaratinoo.so|libibmeci.so|libKali.so|libKGlobal.so|libKTrans.so|libKParle.so|libKAnalyse.so|libvoxin.so'
NOTFOUND=$(mktemp)
NEEDED=$(mktemp)
trap 'rm $NOTFOUND $NEEDED' EXIT
cd /var/adm/packages
for pkg in *; do
( cd /
  while read line; do
    [ "$line" = "FILE LIST:" ] && break
  done
  while read f; do
    if [ -x "$f" -a -f "$f" -a -r "$f" ]; then
      if LD_LIBRARY_PATH=$(dirname "$f") ldd "$f" 2>/dev/null|grep -q 'not found'; then
        LD_LIBRARY_PATH=$(dirname "$f") ldd "$f"|grep 'not found'>$NOTFOUND
        objdump -p "$f"|grep NEEDED|sed 's/ *NEEDED *\(l.*\)/\1/'>$NEEDED
        if grep -f $NEEDED $NOTFOUND|grep -qEv $BLACKLIST; then
          echo "$pkg"
          echo /"$f"
          grep -f $NEEDED $NOTFOUND|grep -Ev $BLACKLIST|sort|uniq
          echo
        fi
      fi
    fi
  done 
) < $pkg
done

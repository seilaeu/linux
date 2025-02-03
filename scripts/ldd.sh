#!/bin/bash

ECHO=/usr/bin/echo
SED=/usr/bin/sed
FILE=/usr/bin/file
CUT=/usr/bin/cut
LDD=/usr/bin/ldd
GREP=/usr/bin/grep
AWK=/usr/bin/awk

for p in `$ECHO $PATH | $SED 's/:/ /g'`
do
    for f in $p/*
    do
        if [ 'ELF' == `$FILE -b $f | $CUT -d' ' -f1` ]; then
            if $LDD $f | $GREP -q 'not found'; then
                $ECHO "$f"
                $LDD $f | $GREP 'not found' | $AWK '{print "Not found:", $1}'
            fi
        fi
    done
done

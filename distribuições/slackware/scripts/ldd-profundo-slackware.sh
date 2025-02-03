#!/bin/bash                                                             

# This is the concatenated MANIFEST file of slackpkg on Slackware64
MANIFEST=/var/lib/slackpkg/slackware64-filelist.gz

# Do not trust in any command in PATH, shell builtins, etc.
SYSPATH=$PATH
PATH=/bin:/usr/bin:/usr/sbin:/sbin:/usr/lib64
ECHO=/usr/bin/echo
PRINTF=/usr/bin/printf

# Check all directories in PATH and ld.so.conf
# If it is true ELF binary
find `$ECHO $SYSPATH | sed 's/:/ /g'` \
     `sed 's/\(\/.*\/.*\)\/.*/\1/' /etc/ld.so.conf | sort -u` \
     -perm -100 -a -type f \
     -exec sh -c 'filename="{}"; /usr/bin/echo -n "." >&2; \
                  [ "ELF" = `file -b $filename | cut -d" " -f1` ] && \
                  ldd $filename 2>/dev/null | grep -F "not found" \
                      | cut -d" " -f1' \; | while read missing_lib
do
    # Print the missing library and its package name
    $ECHO $missing_lib ": `zgrep $missing_lib $MANIFEST | cut -d" " -f1`"
done | sort -u

#!/bin/bash
# dependency checker

# Derived from Orphans version 1.07
# Author: selfprogrammed
# Contact: LinuxQuestions.org
# Created: July 2023

# Orphans header:
# Author: Sasha Alexandr (GrapefruiTgirl) March 2010
# DISCLAIMER/LICENSE: GNU GPL v3 or greater.
# This script is provided with ABSOLUTELY NO WARRANTY in the hope
# that you will find it useful and/or entertaining.
# While the script does not change your system in any way
# the author takes no responsibility for how you use it, or how you
# might use the results produced by it. Use at own risk.
# You may modify or redistribute this program as you like.
# End Orphans header

VERSION='Version 1.08'
RESULT="depchk.log"
MODE=
LONG_FORMAT=

# FUNC
check_permissions () {
  # Check permissions (are we root?)
  if [ "$(id -u)" != '0' ]; then
    echo "Recommend running as root due to file permissions."
  fi
}

# FUNC
#  $1 : name
#  $2 : filelist, must be in quotes
print_filelist () {
  if [ -n "$LONG_FORMAT" ]; then
    echo $1=
    for FN3 in $2; do
      echo $FN3
    done
  else
    echo $1= $2
  fi
}

# FUNC
setup_basic () {

  # Kinda irrelevant/overkill, but where is ldconfig:
  if [ "$( id -u )" == "0" ]; then
   # ROOT
    LDCONFIG=$(which ldconfig)
  fi
  if [ "$LDCONFIG" == "" ] ; then
    LDCONFIG="/sbin/ldconfig"
  fi

  # put the results in this file (in the CWD):
  if [ "$(pwd)" != '/' ]; then
    RESULT=$(pwd)/$RESULT
  fi

  # create fresh output file:
  echo
  echo "## depchk.sh $VERSION for Slackware." | tee "$RESULT"
  echo "## Executed: $(date)" | tee -a "$RESULT"
  echo "## Mode: $MODE" | tee -a "$RESULT"
  echo "## Output: $RESULT"
  echo "## ##########################################" >> "$RESULT"
  echo >> "$RESULT"
}

# FUNC
setup_mode () {
  printf "## Setup mode. \n"
  LIB32DIRS=""
  LIB64DIRS=""
  BINDIRS=""

  LIBSEARCH="/lib /usr/lib /usr/local/lib /opt"
  BINSEARCH="/bin /sbin /usr/bin /usr/sbin /usr/local/bin /usr/local/sbin /opt"
#DEBUG  
#  LIBSEARCH="/usr/lib/seamonkey /usr/local/lib /opt"
#  BINSEARCH="/usr/local/bin /sbin /usr/sbin /usr/local/sbin /opt"

  # add more paths to the search
  case $1 in
  basic)
    ;;
 
  full)
    printf "## finding full directories ... \n"
    LIBSEARCH+="/home /usr/share"
    BINSEARCH+="/home /lib /usr/lib /usr/local/lib"
    ;;

  all)
    LIBSEARCH=""
    BINSEARCH=""
    printf "## finding all directories ... \n"
    # NOTE: may produce a lot of results!!
    LIB64DIRS=$( find / -type d -name 'lib64' 2>/dev/null | sed \
  -e '/^\/boot\/initrd-tree\/.*$/d' \
  -e '/^\/mnt\|tmp\|media\/.*$/d' \
  -e '/^\/usr\/src\/.*$/d' \
  -e '/^\/usr\/source\/.*$/d' )
    printf ".\n"
    print_filelist "LIB64DIRS" "$LIB64DIRS"

    LIB32DIRS=$( find / -type d -name 'lib' 2>/dev/null | sed \
  -e '/^\/boot\/initrd-tree\/.*$/d' \
  -e '/^\/mnt\|tmp\|media\/.*$/d' \
  -e '/^\/usr\/src\/.*$/d' \
  -e '/^\/usr\/source\/.*$/d' \
  -e '/^\/usr\/libexec\/.*$/d' \
  -e '/^\/usr\/doc\/.*$/d' \
  -e '/^\/lib\/modules\/.*$/d' \
  -e '/^\/var\/cache\/.*$/d' \
  -e '/\/lib64\/.*$/d' )
    printf ".\n"
    print_filelist "LIB32DIRS" "$LIB32DIRS"

    LIBEXECDIRS=$( find / -type d -name 'libexec' 2>/dev/null )
    print_filelist "LIBEXECDIRS" "$LIBEXECDIRS"

    # check these bin paths and/or ld.so.conf known paths:
    printf "## finding bin directories ... \n"

    BINDIRS=$( find / -type d -name 'bin' -or -name 'sbin' 2>/dev/null | sed \
  -e '/^\/mnt\|tmp\|media\/.*$/d' \
  -e '/^\/usr\/src\/.*$/d' \
  -e '/^\/boot\/initrd-tree\/.*$/d' \
  -e '/^\/usr\/source\/.*$/d' )
    print_filelist "BINDIRS" "$BINDIRS"

  ;;
  esac

  if [ -n "$LIBSEARCH" ]; then
    printf "## finding lib directories ... \n"
    # NOTE: may produce a lot of results!!
    for LDIR in $LIBSEARCH; do
      LIB32DIRS+=" "$( find $LDIR -type d -name 'lib' 2>/dev/null )
      LIB64DIRS+=" "$( find $LDIR -type d -name 'lib64' 2>/dev/null )
    done
    print_filelist "LIB32DIRS" "$LIB32DIRS"
    print_filelist "LIB64DIRS" "$LIB64DIRS"
  fi

  if [ -n "$BINSEARCH" ]; then
    printf "## finding bin directories ... \n"
    for BDIR in $BINSEARCH; do
      BINDIRS+=" "$( find $BDIR -type d -name 'bin' 2>/dev/null )
    done
    print_filelist "BINDIRS" "$BINDIRS"
  fi

  echo "."

  echo "## Setup Done!"
}


# FUNC
count_packages () {
  # the number of packages that are installed:
  NUMPKGS=$( ls /var/log/packages | wc -l )
  echo "## Installed packages: $NUMPKGS" | tee -a "$RESULT"
}


# FUNC
broken_links () {
  # Are there are links pointing to non-existant libraries.
  # This only checks stuff that the linker knows about.
  echo >> "$RESULT"
  echo "## Check for broken symlinks that might indicate missing libs.." | tee -a "$RESULT"
 
  if [ "$( id -u )" == "0" ]; then
    # rebuild links only for ROOT
    $LDCONFIG 1>/dev/null 2>&1
  fi

  # This works for any user.
  for LIB in $($LDCONFIG -v 2>&1 >/dev/null | grep 'Cannot stat' | awk '{print $4}' | tr -d ':'); do
    # this part is fast: no visual progress display.
    echo "1: Broken link to: $LIB" >> "$RESULT"
    printf "1:> Possibly comes from package:" >> "$RESULT"
    PKG="$(grep "$LIB" /var/log/packages/*)"
    [ ! "$PKG" ] && echo " Unknown." >> "$RESULT" || \
    printf "\n$(echo "$PKG" | cut -d: -f1 | awk -F/ '{print $5}').t?z\n" >> "$RESULT"
  done

  echo "## Broken Links Done!" | tee -a "$RESULT"
}



# FUNC
#  DIRCOUNT: index of dir processed
#  NUMDIR:   num of dir overall
#  ITEMINCR: index of file processed
#  ITEMCOUNT: num of file in dir
visual_progress() {
  # visual progress display:
  ITEMPROGRESS="$((ITEMINCR*100/ITEMCOUNT))"
  printf %b "\r## Path: $DIRCOUNT/$NUMDIRS  Done: $ITEMPROGRESS%  $1  "
  VISUAL_PROGRESS_ACTIVE=1
}

# FUNC
visual_progress_clear() {
  printf %b "\r##                                                                     "
  VISUAL_PROGRESS_ACTIVE=1
}

# FUNC
visual_progress_off() {
  if [ -n "$VISUAL_PROGRESS_ACTIVE" ]; then
    VISUAL_PROGRESS_ACTIVE=
    echo ""   # get off of visual progress line
  fi
}


# FUNC
# Print only one header for the FILE
#  FILE: filename
#  RESULT:  output file
missing_header() {
  if [ -z "$MISSING_HEADER_FLAG" ]; then
    MISSING_HEADER_FLAG=1
    visual_progress_off
    echo " Dependencies for: $FILE" | tee -a "$RESULT"
  fi
}


# FUNC
# Check if FN can be found in non-standard locations.
# ldd already did not find it in standard directories.
#  LFF: libfile to be found
#  DIR: parent directory
#  ALLDIRS: search paths
#  RESULT:  output file
nonstandard_dir_search() {
  NONSTD_FOUND_FLAG=
  # Is it in the parent directory.
  IN_DIR=$(find $DIR -name $LFF)
  if [ -n "$IN_DIR" ]; then
    NONSTD_FOUND_FLAG=1
    if [ -n "$VERBOSE" ]; then
      missing_header
      echo "   FOUND $LFF: in non-standard parent directory $DIR" | tee -a "$RESULT"
    fi
  else
    visual_progress_off
    echo "  $FILE -> $LFF, searching non-standard dir .. "
    # check other directories.
    # This would be weird, and should not happen often, if at all.
    for DIR2 in $ALLDIRS; do
      IN_DIR=$(find $DIR2 -name $LFF)
      if [ -n "$IN_DIR" ]; then
        NONSTD_FOUND_FLAG=1
        missing_header
	echo "   FOUND $LFF: in strange directory $DIR2" | tee -a "$RESULT"
	return
      fi
    done
  fi
}


# FUNC
#  RESULT:  output file
dependency () {
  # Checks for missing dependencies of installed binaries and other libs on the system.
  # The --basic mode checks system bin dirs.
  # The --full mode checks every lib & bin dir it can find on the system.
  echo >> "$RESULT"
  echo "## Checking for missing dependencies of installed libs/binaries.." | tee -a "$RESULT"
  echo "## When there is a ":" at last line, it is LESS waiting for you to scroll the page !" >> "$RESULT"

  DIRCOUNT=$((1))
  ITEMINCR=$((0))
  BININCR=$((0))
  ALLDIRS="$BINDIRS
$LIB64DIRS
$LIB32DIRS
$LIBEXECDIRS"
#  ALLDIRS="/usr/lib/firefox /usr/lib/seamonkey"
  NUMDIRS=$(echo "$ALLDIRS" | wc -l)

  #echo "$ALLDIRS" | while read DIR; do
  for DIR in $ALLDIRS; do
    if [ "$DIR" ] && [ -d "$DIR" ]; then
      echo "# Checking files in: $DIR" >> $RESULT
      ITEMCOUNT=$(find "$DIR" -type f | sort | uniq | wc -l)   
      FILELIST=$(find "$DIR" -type f | sort | uniq)

      if [ $ITEMCOUNT -lt 1 ]; then
         # protect visual_progress division
         continue
      fi
      visual_progress_clear
      visual_progress "$DIR"

      for FILE in $FILELIST; do
      
        ITEMINCR=$((ITEMINCR+1))
        if [ $(($ITEMINCR & 0x1F == 0)) ]; then
          # Not every file, as output slows whole program.
          visual_progress "$DIR"
        fi

        MISSING_HEADER_FLAG=
        if [ -x "$FILE" ] && [ $(file "$FILE" | grep -c 'ELF') -ne 0 ]; then
          if [ $(ldd "$FILE" 2>/dev/null | grep -c 'not found') -ne 0 ]; then
	    # filelist of not found
	    notfound_list=$(ldd "$FILE" | grep 'not found' | awk '{print $1}' | sort | uniq )
	    for LFF in $notfound_list; do
	      # Check if it can be found in non-standard locations first
              nonstandard_dir_search
	      if [ -z "$NONSTD_FOUND_FLAG" ]; then
                # This missing dep was not found anywhere.
	        missing_header
	        echo " ** MISSING: $LFF"
	        echo " ** MISSING: $LFF" >> "$RESULT"
	      fi
	    done
          fi
        fi
      done

      visual_progress_clear
      DIRCOUNT=$((DIRCOUNT+1))
      ITEMINCR=$((0))
    fi
    visual_progress_clear
  done

  visual_progress_off
  echo "## Dependency Done!" >> "$RESULT"
}



# FUNC
help () {
  echo "## depchk.sh $VERSION for Slackware."
  cat << END
 # Dependency checker for Slackware.
 # Check that libraries are present, for bin and lib.
 #
 # USAGE EXAMPLES:
 $0 --basic
 $0 --full -l
 $0 -v -h
 # SWITCHES
  -h | --help    : shows this help
  -l | --long    : nicer, easier to read format
  -v | --verbose : verbose output
  -b | --basic   : basic scan
  -f | --full    : more exhaustive scan
  -a | --all     : all directories scan

 # End Help
END
}



# FUNC
#  $1 : command line switch
process_switch () {

  if [ "x$1" == "x" ]; then
     return
  fi

  case "$1" in

  verbose|-v|--v)
    VERBOSE=1
  ;;

  -l|--long)
    LONG_FORMAT=1
  ;;

  --basic|-basic|basic|-b|--b)
    MODE=basic
  ;;

  --full|-full|full|-f|--f)
    MODE=full
  ;;

  --all|-all|all|-a|--a)
    MODE=all
  ;;

  help|usage|-h|--h|-usage|--usage|'?')
    MODE=
  ;;
 
  *)
    help && exit 1
  ;;

  esac
}




# script entry point:
# use --help for usage instructions.
MODE=  # required
process_switch $1
process_switch $2
process_switch $3
if [ "x$MODE" == "x" ]; then
  help
  exit 1
fi

#if [ -n "$VERBOSE" ]; then
#   echo " VERBOSE"
#fi

check_permissions
  
setup_basic
setup_mode $MODE
  
count_packages

broken_links
  
dependency


# Next lines automatically puts the results file to the screen via 'less':
echo
echo "shell# cat $RESULT | less"
sleep 2 && cat "$RESULT" | less
#EOF

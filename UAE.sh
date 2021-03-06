#!/bin/bash

LOCATOIN=$(which tar)
if [[ $? -ne 0 ]]; then
	echo "tar not installed on this system, please install tar before running this command"
	exit 1
fi

# decomressing a tar archive if option -d is selected
# input format: bash UAE.sh -d <file> for current working directory or bash UAE.sh -d <file> <new-location> for decompressing into another directory


PARSED_ARGUMENTS=$(getopt -a -n UAE -o dg:b:x: -l decompress,gzip:,bzip2:,xz: "$@")
if [[ $1 == "-d" ]]; then
   if [[ $3 ]]; then
      tar -xvf $2 -C $3
   else
      tar -xvf $2
   fi
   exit 0
fi

# compressing a tar archive if option -d was not selected
# imput format bash UAE.sh -gzip <name> <path-to-tar>
case $1 in
       -g|--gzip)
          tar -czvf "${2}.tar.gz" $3
          ;;
       -b|--bzip2)    
          tar -cjvf "${2}.tar.bz2" $3
          ;;
       -x|--xz)    
          tar -cJvf "${2}.tar.xz" $3
          ;; 
esac
exit 0

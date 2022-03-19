#!/bin/bash

original_dir=~/uio/pc/Dokumenter/PhD/Stat_Help/Tim/Cleaning/Output/S2_Theme

## define 2 directories to copy into
# define an associative array (like a map)
declare -A target_dirs

target_dirs[0]="./S2_Theme/B1_Block1/"
target_dirs[1]="./S2_Theme/B2_Block2/"

# recursively find all the files, and loop through them
find $original_dir -type f | while read -r file ; do
        # find a random number 0 - (size of target_dirs - 1)
#        RANDOM=1 # Seed for randomisation
        num=$(($RANDOM % ${#target_dirs[@]}))
        # get that index in the associative array
        target_dir=${target_dirs[$num]}
        # copy the file to that directory
#        echo "Copying $file to $target_dir"
        cp $file $target_dir
done

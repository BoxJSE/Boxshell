###################################
#
# setfavorite-fi.sh - Bulk favorite setting for file
#
#
###################################

# Initialize

#!/bin/bash

read INPUT_Token < Token

favoriteID_tmp=$1
favoritefilelist_tmp=$2
AsUserID=$3

read favoriteID < $favoriteID_tmp

while read line1
do
	
	setcollection-asuser -addfi $line1 $favoriteID $AsUserID
	
done < $favoritefilelist_tmp



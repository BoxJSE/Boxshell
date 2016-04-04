###################################
#
# setfavorite-bm.sh - Bulk favorite setting for Bookmark
#
#
###################################

# Initialize

#!/bin/bash

read INPUT_Token < Token

favoriteID_tmp=$1
favoritebookmarklist_tmp=$2
AsUserID=$3

read favoriteID < $favoriteID_tmp

while read line1
do
	
	setcollection-asuser -addbook $line1 $favoriteID $AsUserID
	
done < $favoritebookmarklist_tmp



###################################
#
# bulkuser - user bulkupload
#
#
###################################

# Initialize

#!/bin/bash

PRE_IFS=$IFS
IFS=$'\n'


read INPUT_Token < Token

if [ -z $1 ]; then

	echo "Source_file?:"
	read source_file

	for line in `cat $source_file |grep -v ^#`
	
	do
		user_login=`echo $line |cut -d ',' -f 1`
		user_name=`echo $line |cut -d ',' -f 2`
		user_role=`echo $line |cut -d ',' -f 3`

		buser -e $user_login $user_name $user_role

	done

else

	source_file=$1

#echo $source_file


   for line in `cat $source_file |grep -v ^#`
	do
		user_login=`echo $line |cut -d ',' -f 1`
		user_name=`echo $line |cut -d ',' -f 2`
		user_role=`echo $line |cut -d ',' -f 3`

#		echo $user_login
#		echo $user_name

		buser -e $user_login $user_name $user_role
#		buser -e $user_login $user_name

	done
	
fi

IFS=$PRE_IFS


	
		








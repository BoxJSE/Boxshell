###################################
#
# longpollmon - longpoll monitor
#
#
###################################

# Initialize

#!/bin/bash
declare -i i
read INPUT_Token < Token

#

if [ -z $1 ]; then

	echo "Script_file?:"
	read Script_file

	while read line
	do

		Key=${line%\:*}

		if [ $Key = "Script_name" ]; then
			Scriptname=${line#*\:}
		elif [ $Key = "Waiting_time" ]; then
			Waiting_time=${line#*\:}
		elif [ $Key = "Event_type" ]; then
			Event_type=${line#*\:}
		elif [ $Key = "Max_par_num" ]; then
			Max_par_num=${line#*\:}
		elif [ $Key = "Parameter[1]" ]; then
			Parameter[1]=${line#*\:}
		elif [ $Key = "Parameter[2]" ]; then
			Parameter[2]=${line#*\:}
		elif [ $Key = "Parameter[3]" ]; then
			Parameter[3]=${line#*\:}
		elif [ $Key = "Parameter[4]" ]; then
			Parameter[4]=${line#*\:}
		elif [ $Key = "Parameter[5]" ]; then
			Parameter[5]=${line#*\:}
		elif [ $Key = "Parameter[6]" ]; then
			Parameter[6]=${line#*\:}
		elif [ $Key = "Parameter[7]" ]; then
			Parameter[7]=${line#*\:}
		elif [ $Key = "Parameter[8]" ]; then
			Parameter[8]=${line#*\:}
		elif [ $Key = "Parameter[9]" ]; then
			Parameter[9]=${line#*\:}
		elif [ $Key = "Process_name" ]; then
			Process_name=${line#*\:}
		else
			Echo "no match paramater"
		fi
	done < $Script_file
	
	while :
	do

			longpoll			
			i=1
			for i in `seq 1 $Max_par_num`
			do 
				cat export.log |${Parameter[$i]} > Parameter_"$Scriptname"_$i
			done
			
			read log_event_type < Parameter_"$Scriptname"_4
			
			if [ $log_event_type = $Event_type ]; then
						
				$Process_name

			fi
			
	 done

elif [ $1 = "-?" ]; then

	cat manual|bgrep Name longpollmon

else

	Script_file=$1

	while read line
	do

		Key=${line%\:*}

		if [ $Key = "Script_name" ]; then
			Scriptname=${line#*\:}
		elif [ $Key = "Waiting_time" ]; then
			Waiting_time=${line#*\:}
		elif [ $Key = "Event_type" ]; then
			Event_type=${line#*\:}
		elif [ $Key = "Max_par_num" ]; then
			Max_par_num=${line#*\:}
		elif [ $Key = "Parameter[1]" ]; then
			Parameter[1]=${line#*\:}
		elif [ $Key = "Parameter[2]" ]; then
			Parameter[2]=${line#*\:}
		elif [ $Key = "Parameter[3]" ]; then
			Parameter[3]=${line#*\:}
		elif [ $Key = "Parameter[4]" ]; then
			Parameter[4]=${line#*\:}
		elif [ $Key = "Parameter[5]" ]; then
			Parameter[5]=${line#*\:}
		elif [ $Key = "Parameter[6]" ]; then
			Parameter[6]=${line#*\:}
		elif [ $Key = "Parameter[7]" ]; then
			Parameter[7]=${line#*\:}
		elif [ $Key = "Parameter[8]" ]; then
			Parameter[8]=${line#*\:}
		elif [ $Key = "Parameter[9]" ]; then
			Parameter[9]=${line#*\:}
		elif [ $Key = "Process_name" ]; then
			Process_name=${line#*\:}
		else
			Echo "no match paramater"
		fi
	done < $Script_file
	
	while :
	do

			longpoll			
			i=1
			for i in `seq 1 $Max_par_num`
			do 
				cat export.log |${Parameter[$i]} > Parameter_"$Scriptname"_$i
			done
			
			read log_event_type < Parameter_"$Scriptname"_4
			
			if [ $log_event_type = $Event_type ]; then
						
				$Process_name

			fi
			
	 done


fi



	 


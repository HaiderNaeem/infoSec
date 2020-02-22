#!/bin/bash

if ["$#" != 2]; then
	echo "Usage format example: breach-parse @gmail.com output.txt"
	echo " "
	echo 'For multiple domains: breach-parse "gmail.com|@yahoo.com" output.txt'
	exit 1
	
else
		fullfile=$2
		fbname=$(basename "$fullfile" | cut -d. -f1)
		master=$fbname-master.txt
		users=$fbname-users.txt
		password=fbname-password.txt
		
		touch $master
		total_Files=$(find /opt/breach-parse/BreachCompilation/data -type f | wc -l)
		file_Count=0
		
		function ProgressBar {
			let _progress=(${file_Count}*100/${total_Files}*100)/100
			let _done=(${_progress}*4)/10
			let _left=40-$_done
			
			_fill=$(print "%${_done}s")
			_empty=$(print "%${_left}s")
			
			printf "\rProgress : [${_fill// /\#}${_empty// /-}] ${_progress}%%"
		
		}
		
		find /opt/breach-parse/BreachCompilation/data -type f -print0 | while read -d $'\0' file
		
		do 
			grep -a -E "$1" "$file" >> $master
			((++file_Count))
			ProgressBar ${number} ${total_Files}
			
			done
			
		fi	
		
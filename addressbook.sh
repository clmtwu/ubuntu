printf "%s" "-- Address Book --"
printf "\n1. List / Search\n"
printf "2. Add\n"
printf "3. Edit\n"
printf "4. Remove\n"
printf "5. Quit\n"

#Lab 5: 1) Already in case form

while :
do
	printf "\nEnter your selection: "
	read VAR_INPUT
	case $VAR_INPUT in 
		1) echo -n "Searching:"
		#!/bin/bash
		INPUT=contacts.csv		
		OLDIFS=$IFS
		IFS=','
		[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
		while read id fname lname company address city county state acode pnumber email
			printf "Name: %-8fname %-8lname Company: %-10company City: %-10city 
				County: %-10county State: %-2state Area Code: %-5acode 
				Phone Number: %-13pnumber Email: %-10email 
		done < $INPUT
		IFS=$OLDIFS
		2) echo -n "Developing: Feature Not Required in Lab 5"
		   ;;
		3) echo -n "Developing: Feature Not Required in Lab 5"
		   ;;
		4) echo -n "Developing: Feature Not Required in Lab 5"
		   ;;
		5) echo -n  "Exit Program"
		sleep 1
		break
		   ;;
 	esac
done
clear

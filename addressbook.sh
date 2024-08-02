printf "%s" "-- Address Book --"
printf "\n1. List / Search\n"
printf "2. Add\n"
printf "3. Edit\n"
printf "4. Remove\n"
printf "5. Quit\n"

while :
do
	printf "\nEnter your selection: "
	read VAR_INPUT
	case $VAR_INPUT in 
		1) printf "Searching:\n\n"
			CONTACT="/home/clement/Downloads/contacts.csv"

			if [ ! -f "$CONTACT" ]; then
				echo "Error: CSV File '$CONTACT' not found"
				exit 1
			fi
			#delimiter: ,
			IFS=','
			while read id fname lname address city county state acode pnumber email 
			do
				printf "ID: %-2s Name: %-10s %-10s" "$id" "$fname" "$lname"
	  			printf "Address: %-20s\n" "$address"
	  			printf "City: %-10s County: %-10s State: %-2s Area Code: %-5s\n" "$city" "$county" "$state" "$acode"
	  			printf "Phone Number: %-13s Email: %-15s\n\n" "$pnumber" "$email" 
			done < "$CONTACT"
			IFS=$'\n'
			echo "Process Finished."
			;;
		2) echo -n "In Development: Feature Not Required in Lab 5"
		   ;;
		3) echo -n "In Development: Feature Not Required in Lab 5"
		   ;;
		4) echo -n "In Development: Feature Not Required in Lab 5"
		   ;;
		5) echo -n "Exiting Program..."
		sleep 1
		break
		   ;;
 	esac
done
clear

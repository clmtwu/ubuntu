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
		1) echo -n "Searching:"
		
		CSV_FILE="/home/clement/Downloads/contacts.csv"

		if [ ! -f "$CSV_FILE" ]; then
			echo "Error: CSV File '$CSV_FILE' not found"
			exit 1
		fi
		
		#delimiter: .
		IFS=','
		
		while read id fname lname company address city county state acode pnumber email 
		do
			printf "ID: %-5s Name: %-20s %-20s Company: %-20s\n" "$id" "$fname" "$lname" "$company"
  			printf "Address: %-40s\n" "$address"
  			printf "City: %-20s County: %-20s State: %-2s Area Code: %-5s\n" "$city" "$county" "$state" "$acode"
  			printf "Phone Number: %-13s Email: %-20s\n\n" "$pnumber" "$email" 
		done < "$CSV_FILE"
		IFS=$'\n'

		echo "Process Finished."
		2) echo -n "In Development: Feature Not Required in Lab 5"
		   ;;
		3) echo -n "In Development: Feature Not Required in Lab 5"
		   ;;
		4) echo -n "In Development: Feature Not Required in Lab 5"
		   ;;
		5) echo -n "Exit Program"
		sleep 1
		break
		   ;;
 	esac
done
clear

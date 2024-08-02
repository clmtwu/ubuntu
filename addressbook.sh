do_list() {
	printf "Searching:\n\n"
	CONTACT="/home/clement/Downloads/contacts.csv"
        if [ ! -f "$CONTACT" ]; then
        	echo "Error: CSV File '$CONTACT' not found"
                sleep 1
                exit 1
        fi
        #delimiter: ,
        IFS=','
        while read id firstName lastName address city county state zip  phone email 
        do
                printf "ID: %-2s Name: %-10s %-10s" "$id" "$firstName" "$lastName"
                printf "Address: %-20s\n" "$address"
                printf "City: %-10s County: %-10s State: %-2s Area Code: %-5s\n" "$city" "$county" "$state" "$zip"
                printf "Phone Number: %-13s Email: %-15s\n\n" "$phone" "$email" 
	done < "$CONTACT"
        IFS=$'\n'
	echo "Process Finished."
}

do_search() {
	# first name is always after id, so we traverse the csv until the first name and backtrack to id
	CONTACT="/home/clement/Downloads/contacts.csv"
	printf "What is the first name of the person you are searching for?\n"
	found=0
	read firstNameInput
	awk -F',' -v search="$firstNameInput" '$1 == search {print; found=1; exit}'$CONTACT
	if [ $found = 0 ]; then
		echo "Error: Name not found"
	fi
}

do_add(){
	# no duplicate checking implementation since we could have two identical entries separated by id #
	do_search
}

do_remove() {
	echo -n "Removing File..."
        rm -f "/home/clement/Downloads/contacts.csv" 
}


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
		1) printf "\nWould you like to list  or search?\n"
		   printf "1. List\n"
		   printf "2. Search\n"
		   read ES_INPUT
		   if [ "$ES_INPUT" == "1" ]; then
			do_list
		   else
			do_search
		   fi 
		   ;;
		2) echo -n "In Development: Feature Not Required in Lab 5"
		   ;;
		3) echo -n "In  Development: Feature Not Required in Lab 5"
		   ;;
		4) do_remove
		   ;;
		5) echo -n "Exiting Program..."
		sleep 1
		break
		   ;;
 	esac
done
clear

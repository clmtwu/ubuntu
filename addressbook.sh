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
	# given some input firstname, scan the csv until i find the matching row and print it. 
	CONTACT="/home/clement/Downloads/contacts.csv"
	printf "\nWhat is the first name of the person you are searching for?\n"
	read firstNameInput

	found=0
	cat "$CONTACT" | awk -F',' -v search="$firstNameInput" '$1 == search {print; found=1; exit}'
	if [ "$found" = 0 ]; then
		echo "Error: Name not found"
	fi
}

do_add(){
	# no duplicate checking implementation since we could have two identical entries separated by id #
	CONTACT="/home/clement/Downloads/contacts.csv"
	printf "Please print the first name of your student:\n"
	read firstName
	printf "Please print the middle  name of your student:\n"
	read middleName
	printf "Please print the last  name of your student:\n"
	read lastName
	printf "Please print the address of your student:\n"
	read address
	printf "Please print the city that your student resides in: \n"
	read city
	printf "Please print the state that your student resides in: \n"
	read state
	printf "Please print the zip code that your student resides in: \n"
	read zip
	printf "Please print your student's phone number:\n"
	read phone
	printf "Please print your student's email: \n"
	read email
	sed -i li"$firstName, $middleName, $lastName, $address, $city, $state, $zip, $phone, $email" "$CONTACT"
}

do_edit() {
	CONTACT="/home/clement/Downloads/contacts.csv"
	clear
	printf "What would you like to edit about this student?"
	printf "1. First Name\n"
	printf "2. Middle Name\n"
	printf "3. Last Name\n"
	printf "4. Address\n"
	printf "5. City\n"
	printf "6. State\n"
	printf "7. Zip\n"
	printf "8. Phone Number\n"
	printf "9. Email\n"

	read CSV_OPTIONS
	case $CSV_OPTIONS in
		1) 
		  ;;
		2)
		  ;;
		3)
		  ;;
		4)
		  ;;
		5)
		  ;;
		6)
		  ;;
		7)
		  ;;
		8)
		  ;;
		9)
		  ;; 
	esac
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
		   case $ES_INPUT in
			1) do_list
			   ;;
			2) do_search
			  ;;
		  esac 
		   ;;
		2) do_add
		   ;;
		3) do_edit
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

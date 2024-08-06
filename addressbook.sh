do_list() {
	printf "Searching:\n\n"
	CONTACT="/$HOME/Downloads/contacts.csv"
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
	CONTACT="/$HOME/Downloads/contacts.csv"
	if [ ! -f "$CONTACT" ]; then
                echo "Error: CSV File '$CONTACT' not found"
                sleep 1
                exit 1
        fi

	printf "\nWhat is the first name of the person you are searching for?\n"
	read firstNameInput

	found=0

	while IFS=, read -r id firstName middleName lastName address city state zip phone email
	do
		if [[ "$firstName" == "$firstNameInput" ]];
		then
			printf "Student found! \n"
			echo "ID: $id, Name: $firstName $middleName $lastName, Address: $address $city $state $zip, Phone Number: $phone, Email: $email"
			found=1
			break
		fi
	done < "$CONTACT"

	if [[ $found -eq 0 ]];
	then
		echo "Name not found"
	fi
}

do_add(){
	# no duplicate checking implementation since we could have two identical entries separated by id #
	CONTACT="/$HOME/Downloads/contacts.csv"
	if [ ! -f "$CONTACT" ]; then
                echo "Error: CSV File '$CONTACT' not found"
                sleep 1
                exit 1
        fi
	tmpfile=$(mktemp)

	printf "Please print the school ID of your student:\n"
	read id

	# Every student should have a student ID that we can use as the integer number
	# This makes searching also a lot easier

	printf "Please print the first name of your student:\n"
	read firstName
	printf "Please print the middle name of your student:\n"
	read middleName
	printf "Please print the last name of your student:\n"
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

	printf "Created!\n"

	new_record="$id,$firstName,$middleName,$lastName,$address,$city,$state,$zip,$phone,$email\n"
	echo "$new_record" >> "$tmpfile"
	tail -n +2 "$CONTACT" >> "$tmpfile"
	mv "$tmpfile" "$CONTACT"
}

do_edit() {

    CONTACT="/$HOME/Downloads/contacts.csv"

    if [ ! -f "$CONTACT" ]; then

                echo "Error: CSV File '$CONTACT' not found"

                sleep 1

                exit 1

        fi

    clear

    printf "\nWhat is the first name of the person you are searching for?\n"
    read firstNameInput
    found=0

    line=$(awk -F, -v name="$firstNameInput" '$2 == name {print NR}' "$CONTACT")
	while IFS=, read -r id firstName middleName lastName address city state
	do
		if [[ "$firstName" == "$firstNameInput" ]];
		then
			printf "Student found!\n"
			found=1
			printf "What would you like to change about the student?\n"
			printf "1. ID\n"
			printf "2. First Name\n"
			printf "3. Middle Name\n"
			printf "4. Last Name\n"
			printf "5. Address\n"
			printf "6. City\n"
			printf "7. State\n"
			printf "8. Zip\n"
			printf "9. Phone"
			printf "10. Email"
			printf "11. Quit"
			read new_data
			clear

			printf "What would you like to change it to be?"
			read change
			case $new_data in
				1)id="$change"
					;;
				2)firstName="$change"
					;;
				3)middleName="$change"
					;;
				4)lastName="$change"
					;;
				5)address="$change"
					;;
				6)city="$change"
					;;
				7)state="$change"
				;;
				8)zip="$change"
					;;
				9)phone="$change"
					;;
				10)email="$change"
					;;
				*)break
					;;
			esac
			sed -i "${line}d" "$CONTACT"
			echo "$id,$firstName,$middleName,$lastName,$address,$city,$state,$zip,$phone,$email" >> "$CONTACT"
			printf "Updated!\n Please use the list command (1, 1) to see the new changes"
		fi    
	done
	if [[ $found -eq 0 ]]; 
	then
		echo "Name not found"
	fi
}


do_remove() {
	printf "Searching:\n\n"
        CONTACT="$HOME/Downloads/contacts.csv"
        if [ ! -f "$CONTACT" ]; then
                echo "Error: CSV File '$CONTACT' not found"
                sleep 1
                exit 1
        fi
	echo -n "Removing File..."
        rm -f "/$HOME/Downloads/contacts.csv"
	echo -n "File Removed! \nPlease re-instate the .csv file if you plan to continue using this program."
}


printf "%s" "-- Address Book --"
while :
do
	printf "\n1. List / Search\n"
	printf "2. Add\n"
	printf "3. Edit\n"
	printf "4. Remove\n"
	printf "5. Quit\n"
	printf "\nEnter your Address Book selection: "
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

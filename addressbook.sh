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

	read -p "Enter the first name of the student to search for: " firstNameInput

	while read id firstName lastName address city county state zip  phone email 
        do
		if [[ ! "$firstName" == "$firstNameInput" ]];
		then
			echo "Error: Student not found"
			exit 1
		fi
		done

    mapfile -t lines < "$CONTACT"

	for ((i=1; i<=${#lines[@]}; i++));
	do
		IFS=, read -r id firstName middleName lastName address city state zip phone email
		if [[ "$firstName" == "$firstNameInput" ]];
		then
			printf "Student found!\n"
			printf "What would you like to change about the student?\n"
			printf "1. ID\n"
			printf "2. First Name\n"
			printf "3. Middle Name\n"
			printf "4. Last Name\n"
			printf "5. Address\n"
			printf "6. City\n"
			printf "7. State\n"
			printf "8. Zip\n"
			printf "9. Phone\n"
			printf "10. Email\n"
			printf "11. Quit\n"
			read choice

			case $choice in
				1)read -p "New ID: " n_id
					lines[$i]="${n_id},${firstName},${middleName},${lastName},${address},${city},${state},${zip},${phone},${email}"
					;;
				2)read -p "New First Name: " nfn
					lines[$i]="${id},${nfn},${middleName},${lastName},${address},${city},${state},${zip},${phone},${email}"
					;;
				3)read -p "New Middle Name:" nmn
					lines[$i]="${id},${firstName},${nmn},${lastName},${address},${city},${state},${zip},${phone},${email}"
					;;
				4)read -p "New Last Name: " nln
					lines[$i]="${id},${firstName},${middleName},${nln},${address},${city},${state},${zip},${phone},${email}"
					;;
				5)read -p "New Address: " new_address
					lines[$i]="${id},${firstName},${middleName},${lastName},${new_address},${city},${state},${zip},${phone},${email}" 
					;;
				6)read -p "New City: " new_city
					lines[$i]="${id},${firstName},${middleName},${lastName},${address},${new_city},${state},${zip},${phone},${email}"
					;;
				7)read -p "New State: " new_state
					lines[$i]="${id},${firstName},${middleName},${lastName},${address},${city},${new_state},${zip},${phone},${email}"
					;;
				8)read -p "New Zip: " new_zip
					lines[$i]="${id},${firstName},${middleName},${lastName},${address},${city},${state},${new_zip},${phone},${email}"
					;;
				9)read -p "New Phone: " new_phone
					lines[$i]="${id},${firstName},${middleName},${lastName},${address},${city},${state},${zip},${new_phone},${email}"
					;;
				10)read -p "New Email: " new_email
					lines[$i]="${id},${firstName},${middleName},${lastName},${address},${city},${state},${zip},${phone},${new_email}"
					;;
				*)break
					;;
			esac
		printf "%s\n" "${lines[@]}" > "$CONTACT"
		fi
	done
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

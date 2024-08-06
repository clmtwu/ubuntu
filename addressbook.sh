do_list() {
	printf "\nSearching:\n\n"
	CONTACT="/$HOME/Downloads/contacts.csv"

	if [ ! -f "$CONTACT" ]; then
		echo "Error: CSV File '$CONTACT' not found"
		sleep 1
		exit 1
	fi

	# delimiter: ,
	# it doesn't really make sense for the delimiter to be a : since the original .csv file uses commas itself
	# furthermore, within the addresses themselves, there are commas that are treated as bash as other variables (rightfully so)
	# it is far better to use perl to refactor everything in this script, but since Lab 6 must be a continuation of Lab 5 this cannot be done.
	# technical debt aside, it makes little sense to combine both .csv formats with the student formats since we get stuck in a local minima where nothing gets done
	# ideally, I would be able to create my own file to format everything the way I want to so I could avoid all of this mess, but here we are.

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
	sleep 1
}

do_search() {
	# given some input firstname, scan the csv until I find the matching row and print it. 
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
		if [[ "$firstName" == "$firstNameInput" ]]; then
			printf "Student found! \n"
			echo "ID: $id, Name: $firstName $middleName $lastName, Address: $address $city $state $zip, Phone Number: $phone, Email: $email"
			found=1
			break
		fi
	done < "$CONTACT"

	if [[ $found -eq 0 ]]; then
		echo "Name not found"
	fi
	sleep 1
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

	new_record="$id,$firstName,$middleName,$lastName,$address,$city,$state,$zip,$phone,$email\n"
	echo "$new_record" >> "$tmpfile"
	tail -n +2 "$CONTACT" >> "$tmpfile"
	mv "$tmpfile" "$CONTACT"

	printf "Created!\n"
	sleep 1
}

do_edit() {
    # similar to edit but instead I delete the entire row and ask for a re-input, since edit had no specification in the lab
	CONTACT="/$HOME/Downloads/contacts.csv"

	if [ ! -f "$CONTACT" ]; then
		echo "Error: CSV File '$CONTACT' not found"
		sleep 1
		exit 1
	fi

	printf "\nWhat is the first name of the person you are searching for?\n"
	read firstNameInput

	found=0
	linenumber=1

	while IFS=, read -r id firstName middleName lastName address city state zip phone email
	do
		if [[ "$firstName" == "$firstNameInput" ]]; then
			printf "Student found! \n"
			echo "ID: $id, Name: $firstName $middleName $lastName, Address: $address $city $state $zip, Phone Number: $phone, Email: $email"
			found=1
			break
		fi
		linenumber=$((linenumber + 1))
	done < "$CONTACT"

	if [[ $found -eq 0 ]]; then
		echo "Name not found"
	else
		temp_file=$(mktemp)
		line_count=0
		while IFS='' read -r line; do
		((line_count++))
		if [[ $line_count != $linenumber ]]; then
			echo "$line" >> "$temp_file"
		fi
		done < "$CONTACT"

		mv "$temp_file" "$CONTACT"
		do_add
	fi
	sleep 1
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

do_sort() {
	# This isn't required but I did it just for fun :)
	printf "Sorting:\n\n"
	CONTACT="$HOME/Downloads/contacts.csv"

	if [ ! -f "$CONTACT" ]; then
			echo "Error: CSV File '$CONTACT' not found"
			sleep 1
			exit 1
	fi

	touch sorted.csv
	sort -t ',' -k 1 -n "$CONTACT" > sorted.csv
	printf "Sorted"
}

# Main Program
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
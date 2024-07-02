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
		1) echo -n "List/Search"
		   ;;
		2) echo -n "Add"
		   ;;
		3) echo -n  "Edit"
		   ;;
		4) echo -n  "Remove"
		   ;;
		5) echo -n  "Exit Program"
		   ;;
 	esac
done
clear

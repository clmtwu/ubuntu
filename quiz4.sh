echo -e "\n COMMAND MENU\n"
echo " a. Current date and time"
echo " b. Users currently logged in"
echo " c. Name of the working directory"
echo -e " d. Contents of the working directory\n"

read -p "Enter a, b, c, or d:" answer
 
echo 

	case "$answer" in
		a) date
		;;
		b) who
		;;
		c) pwd
		;;
		d) ls
		;;
		*)
		echo "There is no selection: $answer"
		;;
	esac

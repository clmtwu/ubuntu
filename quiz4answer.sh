read -p "Enter a, b, c, or d: " answer

echo

if [[ "$answer" == "a" ]]; then
	date
elif [[ "$answer" == "b" ]]; then
        who
elif [[ "$answer" == "c" ]]; then
        pwd
elif [[ "$answer" == "d" ]]; then
        ls
else
	echo "There is no selection: $answer"
fi

# Write a shell script that... 
for file in *; do           # "all... files... in the working directory"
  if [ -d "$file" ]; then   # "directory files, but no other types of files..."
    echo "$file"            # "displays the names..."
  fi
done
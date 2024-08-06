doindent() {
  # Do a small indent depending on how deep into the tree we are
  # using echo "\c" instead of echo en " " since I am using ubuntu
  for i in $(seq 1 "$1"); do
    echo - en " "
  done
}

traverse() {
  # Traverse a directory
  local indent="$2" #encapsulation

  # "Rewrite below... using the for-loop."
  # Traverse a directory
  for item in "$1"/*; do
    doindent "$indent"
    if [ -d "$item" ]; then
      echo "Directory: $item"
      # Use recursion within the loop for subdirectories
      traverse "$item" "$(expr "$indent" + 1)"
    else
      echo "File: $1/$item"  # Use full path for clarity
    fi
  done
}

# NOTE: UNCHANGED AS GIVEN FROM PROMPT
if [ -z "$1" ]; then
  traverse . 0
else
  traverse "$1" 0
fi
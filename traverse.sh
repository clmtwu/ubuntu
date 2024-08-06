doindent() {
  # Do a small indent depending on how deep into the tree we are
  for i in $(seq 1 "$1"); do
    echo -en " "
  done
}

traverse() {
  # Traverse a directory
  local indent="$2" #encapsulation

  # "Rewrite below... using the for-loop."
  # Traverse a directory
  for i in "$1"/*; do
    # My implementation uses recursion to stay within the directory
    # Hence why indent is localized
    doindent "$indent"
    if [ -d "$i" ]; then
      echo "Directory: $i"
      traverse "$i" "$(expr "$indent" + 1)"
    else
      echo "File: $1/$i"
    fi
  done
}

# NOTE: UNCHANGED AS GIVEN FROM PROMPT
if [ -z "$1" ]; then
  traverse . 0
else
  traverse "$1" 0
fi
#!/bin/bash

# Get the PPID of the current process
parent_pid=$$

# Use ps to get the command line of the parent process
parent_cmd=$(ps -p $parent_pid -o cmd=)

# Extract the shell name from the command line
shell_name=$(echo $parent_cmd | cut -d' ' -f1)

echo "Executing shell: $shell_name"
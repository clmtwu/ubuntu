#!/bin/bash

# "These scripts take advantage of the PPID shell variable, 
# which holds the PID number of the shell that is the parent process using the variable"
p_pid=$$

# ps to obtain command line of parent_pid
# -o cmd+ for only the command line
cmdline=$(ps -p $p_pid -o cmd=)

# "The cut utility interprets multiple sequential SPACES as multiple delimiters..."
name=$(echo $cmdline | cut -d' ' -f1)

# "so the script does not work properly without an echo"
echo "Executing shell: $name"
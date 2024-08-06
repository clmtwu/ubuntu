#!/bin/bash

# no regards to how this can be achieved, so we will implement a while loop for "simplicity" (of the programmer (me))
# i trust that the users of this program know how to use control + c to exit a forever loop

while true; do
  clear         # "Clear the window (using the clear command) each time before you display the time"
  date +"%r"    # Read the date man page and display the time, using the %r field discriptor
  sleep 10      # "display the time every 10 seconds"
done

# Every single sentence in the instruction has been executed
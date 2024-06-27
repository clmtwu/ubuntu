echo What is your name?
read NAME

echo What is the description?
read DESCR

echo What is this course?
read COURSE

clear #to clear terminal

echo "****************************************************"
echo "* Name: $NAME                                    *  "
echo "* Description: $DESCR                          *    "
echo "* Course: $COURSE                               *   "
echo "* Due Date: $(date)                                   "
echo "****************************************************"

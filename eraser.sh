#!/bin/bash

FILE_PATH="/home/clement/Downloads/contacts.csv"

sed -i 's/"[^"]*"//g' "$FILE_PATH"

echo "done"

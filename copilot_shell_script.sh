#!/bin/bash

# Prompting user to enter the new assignment
read -p "Insert new assignment: " new_assignment

# Locating the main directory (like $basedir)
dir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

# Verifying that the directory exists
if [[ ! -d "$dir" ]]; then
    echo " ERROR: Couldn’t locate the submission_reminder_ directory."
    exit 1
fi

# Modifying ASSIGNMENT setting inside config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$dir/config/config.env"

echo " Changing NEW ASSIGNMENT to \"$new_assignment\" inside config.env"

# Running the  startup.sh from the $basedir
echo "Starting reminder process with updated assignment"
bash "$dir/startup.sh"

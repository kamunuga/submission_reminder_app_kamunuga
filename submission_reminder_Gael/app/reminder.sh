#!/bin/bash

# Load environment settings and helper scripts
source ./config/config.env
source ./modules/functions.sh

# Path to the submission file
submissions_file="./assets/submissions.txt"

# Show how much time is left and call the reminder
echo "Working on: $ASSIGNMENT"
echo "Still $DAYS_REMAINING day(s) before the deadline"
echo "--------------------------------------------"

check_submissions $submissions_file

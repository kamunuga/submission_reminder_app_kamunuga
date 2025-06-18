#!/bin/bash
cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Launching the Reminder app, just a moment"


# Check if the submissions file exists
if [[ ! -f "$submissions_file" ]]; then
    echo "Error! Couldn’t locate the submissions file at $submissions_file"
    exit 1
fi
check_submissions $submissions_file

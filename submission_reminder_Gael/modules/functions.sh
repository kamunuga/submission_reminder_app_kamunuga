#!/bin/bash
# Function to find and list students missing submissions
function check_submissions {
    local submissions_file=$1
    echo "Looking over submissions in $submissions_file"

    # Start reading from the second line down
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student still needs to turn in $ASSIGNMENT"
        fi
   done < <(tail -n +2 "$submissions_file") # Skip the header
}

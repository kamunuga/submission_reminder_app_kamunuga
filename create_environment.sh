#!/bin/bash
read -p "insert username: " username

# Defining the starting directory
dir="submission_reminder_${username}"

# Setting up the folder structure for the program
mkdir -p "$dir/config"
mkdir -p "$dir/modules"
mkdir -p "$dir/app"
mkdir -p "$dir/assets"

# Writing config settings into config.env
cat <<EOF > "$dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Writing functions inside functions.sh
cat <<'EOF' > "$dir/modules/functions.sh"
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
EOF

# Writing code inside reminder.sh
cat <<'EOF' > "$dir/app/reminder.sh"
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
EOF

# Write the original and five extra students to the file
cat <<EOF > "$dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Edrick, Git, not submitted
Ndoli Frank, Shell Basics,not submitted
Vuningoma, Shell Navigation, submitted
Chris, Git, submitted
Queen, Shell Basics, submitted
Gwiza Elicia, Shell Navigation, not submitted
Manzi Chris, Git, not submitted
Kami Uwambaye, Shell Basics,not submitted
Ineza Lisa, Git, submitted
Rujari Loic, Shell Navigation, submitted
EOF

# Give run permission to all .sh files
find "$dir" -type f -name "*.sh" -exec chmod +x {} \;

# Show success message after setup is done
echo "The project was created successfully in $dir"

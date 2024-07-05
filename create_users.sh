#!/bin/bash
# automating user account creation

# Check if the script is run with the input file argument
if [ -z "$1" ]; then
  echo "Usage: sudo $0 <name-of-text-file>"
  exit 1
fi

# Input file (usernames and groups)
input_file="$1"

# Log file
log_file="/var/log/user_management.log"

# Secure password storage file
password_file="/var/secure/user_passwords.txt"

# Create secure directory
sudo mkdir -p /var/secure
sudo chmod 700 /var/secure
sudo touch "$password_file"
sudo chmod 600 "$password_file"

# Function to generate a random password
generate_password() {
    openssl rand -base64 12
}

# Read input file line by line
while IFS=';' read -r username groups; do
    # Skip empty lines or lines that don't have the proper format
    [[ -z "$username" || -z "$groups" ]] && continue

    # Create groups if they don't exist
    for group in $(echo "$groups" | tr ',' ' '); do
      sudo groupadd "$group" 2>/dev/null || echo "Group $group already exists"
    done

    # Create user if not exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - User $username already exists" | sudo tee -a "$log_file" > /dev/null
    else
        sudo useradd -m -s /bin/bash -G "$groups" "$username" || { echo "Failed to add user $username"; continue; }

        # Set password for newly created user
        password=$(generate_password)
 echo "$username:$password" | sudo chpasswd || { echo "Failed to set password for $username"; continue; }

        # Log actions
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Created user $username with groups: $groups" | sudo tee -a "$log_file" > /dev/null

        # Store password securely
        echo "$username:$password" | sudo tee -a "$password_file" > /dev/null
    fi
done < "$input_file"

echo "$(date '+%Y-%m-%d %H:%M:%S') - User management process completed." | sudo tee -a "$log_file" > /dev/null

                                              

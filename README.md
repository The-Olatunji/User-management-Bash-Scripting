---
#### Script Overview
The script performs the following tasks:
1. Creates two file, a log file to store logs and the other to store user's password.
1. Set right permission for both files.
1. Reads a list of users and groups from a file.
1. Creates users and assigns them to specified groups.
1. Generates random passwords for each newly created user.
1. Logs all actions to /var/log/user_management.log.
1. Stores the generated passwords securely in /var/secure/user_passwords.txt.

#### Key Features
Automated User and Group Creation:

The script automates the creation of users and their respective groups by reading from a file containing user and group information.
Personal groups are created for each user to ensure clear ownership and enhanced security.
Users can be assigned to multiple groups, facilitating organized and efficient permission management.

#### Secure Password Generation:
The script generates random passwords for each user, enhancing security.
Passwords are securely stored in a file with restricted access, ensuring that only authorized personnel can view them.
#### Logging and Documentation:
Actions performed by the script are logged to a file, providing an audit trail for accountability and troubleshooting.
#### Usage:
1 Input File: The script takes an input file containing the list and users and groups they are to be added. it is formatted as user;groups
#### Conclusion
Automating user and group management with a bash script is a very good way to streamline administrative tasks and ensure consistency across a system. In this module, we have demonstrated how to create a script that reads user and group information from a file, creates users, group and sets password while logging the entire process into a log file. This script can be modified and adapted into different environment and requirements making it a versatile tool for system administrators.
Here's a link to my script: [here](https://github.com/The-Olatunji/User-management-Bash-Scripting.git)


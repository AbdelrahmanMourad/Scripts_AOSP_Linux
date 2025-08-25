#!/bin/bash
# The above line tells the system to use the Bash shell to run this script.
# Script must start with the shebang line.


# Check if git is installed.
echo "Checking if git is installed..."
if ! command -v git &> /dev/null; then
    # 'command -v git' checks if 'git' is available.
    # '&> /dev/null' hides the output.
    # 'if ! ...' means "if git is NOT installed".
    sudo apt-get update                # Updates the list of available packages.
    sudo apt-get install -y git        # Installs git. '-y' automatically answers 'yes' to prompts.
else
    echo "git is already installed."
fi


# View git Version.
echo 'git installed version is:'
git --version                           # Prints the installed git version.


# Go to the directory where SSH keys are stored.
echo 'Changing Directory:'
cd ~/.ssh                             # Changes to the .ssh directory in your home folder.


# Generate a new SSH key pair for my Credentials.
echo 'Generating SSH key:'
ssh-keygen -o -t rsa -C "abdelrahmanmourad.am@gmail.com"
# 'ssh-keygen' is the command to generate SSH keys.
# '-o' saves the private key using the new OpenSSH format.
# '-t rsa' specifies the type of key to create (RSA).
# '-C "email"' adds a label (your email) to the key for identification.


# Kist the generated files.
echo 'Generated Files:'
ls                                     # Lists files in the current directory (should show your new keys).


# Show the public key so you can copy it.
echo 'Please copy the Generated SSH Key to your github:'
cat id_rsa.pub                         # Displays the contents of your public key file.


################################################################################
#                            To Run The Script                             #
################################################################################
# 1. Make the script executable (if not already):
#     $ chmod +x git_ssh_key_ubuntu.sh

# 2. Run the script:
#     $ ./git_ssh_key_ubuntu.sh

# Or, you can run it directly with Bash:
#     $ bash git_ssh_key_ubuntu.sh
################################################################################
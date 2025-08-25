
# Make sure git is installed 1st.
echo "Check git is installed:"
sudo apt-get install git

# View git Version.
echo 'git installed version is:'
git --version

# Go to the directory where the key will be generated.
echo 'Changing Directory:'
cd ~/.ssh

# Generate SSH key for my credentials.
echo 'Generating SSH key:'
ssh-keygen -o -t rsa -C "abdelrahmanmourad.am@gmail.com"

# View the generated files.
echo 'Generated Files:'
ls

# Catch the generated key.
echo 'Please copy the Generated SSH Key to your github:'
cat id_rsa.pub 

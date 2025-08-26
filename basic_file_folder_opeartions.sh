#############################################
# Basic File/Folder Operations in Linux
#############################################

# 1. Create a file
touch filename.txt         # Creates an empty file

# 2. Create a directory (folder)
mkdir myfolder            # Creates a directory
mkdir -p parent/child     # Creates nested directories

# 3. Copy files and folders
cp file1.txt file2.txt    # Copy file1.txt to file2.txt
cp file.txt dir/          # Copy file.txt into dir/
cp -r dir1/ dir2/         # Copy directory recursively (with all contents inside)

#### Eample of copying folder contents to another location
cp -r AOSP ~/WORKSPACE/AOSP_15.0.0_36/
#### Example with progress using rsync
rsync -a --info=progress2 AOSP/ ~/WORKSPACE/AOSP_15.0.0_36/

# 4. Move (or rename) files and folders
mv oldname.txt newname.txt    # Rename file
mv file.txt dir/              # Move file into dir/
mv dir1/ dir2/                # Move/rename directory

# 5. Delete files and folders
rm file.txt               # Delete file
rm -f file.txt            # Force delete (no prompt)
rm -r dir/                # Delete directory recursively
rm -rf dir/               # Force delete directory recursively

# 6. Search for files and folders
find . -name "*.txt"      # Find all .txt files in current dir and subdirs
find /path -type d -name "myfolder"   # Find directories named 'myfolder'

# 7. List and sort files/folders
ls                        # List files in current directory
ls -l                     # Long listing (details)
ls -lh                    # Human-readable sizes
ls -lt                    # Sort by modification time (newest first)
ls -lS                    # Sort by file size

# 8. View file contents
cat file.txt              # Print file contents
less file.txt             # View file page by page
head file.txt             # First 10 lines
tail file.txt             # Last 10 lines

# 9. Other useful operations
du -sh dir/               # Show disk usage of directory
df -h                     # Show disk space usage

#############################################
# Aliases and Shortcuts
#############################################

# Temporary alias (only for current terminal session)
alias ll='ls -l --color=auto'        # Example: 'll' lists files in long format

# To remove a temporary alias in the session:
unalias ll

# Permanent alias (always available)
# 1. Open your shell config file (e.g., ~/.bashrc or ~/.zshrc)
# 2. Add your alias, e.g.:
#    alias ll='ls -l --color=auto'
# 3. Save the file and reload config:
#    source ~/.bashrc

# Example permanent aliases:
# alias rm='rm -i'                   # Always prompt before deleting
# alias cp='cp -i'                   # Prompt before overwrite
# alias mv='mv -i'                   # Prompt before overwrite

#############################################
# Notes
#############################################
# - Use 'man <command>' for more details (e.g., man cp)
# - Use wildcards (*, ?) for pattern matching in file names
# - Always be careful with 'rm -rf' as it deletes without recovery

# End of summary
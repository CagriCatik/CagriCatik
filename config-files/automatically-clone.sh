#!/bin/bash

# Prompt the user to enter the GitHub repository URL
read -p "Enter the GitHub repository URL (e.g., https://github.com/user/repo.git): " repo_url

# Extract the repository name from the URL
repo_name=$(basename -s .git "$repo_url")

# Prompt the user to choose between cloning or downloading
echo "Do you want to (c)lone the repository or (d)ownload it as a zip file?"
read -p "(c/d): " choice

# Function to clone the repository
clone_repo() {
    git clone "$repo_url"
    if [ $? -eq 0 ]; then
        echo "Repository cloned successfully into folder: $repo_name"
    else
        echo "Error cloning the repository. Please check the URL and try again."
    fi
}

# Function to download the repository as a zip file
download_repo() {
    zip_url="${repo_url%.git}/archive/refs/heads/main.zip"
    wget -O "$repo_name.zip" "$zip_url"
    if [ $? -eq 0 ]; then
        echo "Repository downloaded as $repo_name.zip"
    else
        echo "Error downloading the repository. Please check the URL or branch name."
    fi
}

# Execute based on the user's choice
if [ "$choice" == "c" ]; then
    clone_repo
elif [ "$choice" == "d" ]; then
    download_repo
else
    echo "Invalid choice. Please run the script again and select either 'c' or 'd'."
fi

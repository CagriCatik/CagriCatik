# Prompt the user to enter the GitHub repository URL
$repo_url = Read-Host -Prompt "Enter the GitHub repository URL (e.g., https://github.com/user/repo.git)"

# Extract the repository name from the URL
$repo_name = [System.IO.Path]::GetFileNameWithoutExtension($repo_url)

# Prompt the user to choose between cloning or downloading
Write-Host "Do you want to (c)lone the repository or (d)ownload it as a zip file?"
$choice = Read-Host -Prompt "(c/d)"

# Function to clone the repository
function Clone-Repo {
    git clone $repo_url
    if ($?) {
        Write-Host "Repository cloned successfully into folder: $repo_name"
    } else {
        Write-Host "Error cloning the repository. Please check the URL and try again."
    }
}

# Function to download the repository as a zip file
function Download-Repo {
    $zip_url = "$($repo_url.TrimEnd('.git'))/archive/refs/heads/main.zip"
    $zip_path = "$repo_name.zip"
    Invoke-WebRequest -Uri $zip_url -OutFile $zip_path
    if (Test-Path $zip_path) {
        Write-Host "Repository downloaded as $zip_path"
    } else {
        Write-Host "Error downloading the repository. Please check the URL or branch name."
    }
}

# Execute based on the user's choice
if ($choice -eq "c") {
    Clone-Repo
} elseif ($choice -eq "d") {
    Download-Repo
} else {
    Write-Host "Invalid choice. Please run the script again and select either 'c' or 'd'."
}

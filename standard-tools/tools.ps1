# Check for administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator."
    exit
}

# Define installation function
function Install-Package {
    param (
        [string]$PackageName,
        [string]$InstallerUrl,
        [string]$ExecutablePath,
        [string]$Arguments = "/quiet /norestart",
        [string]$FileType = "exe"
    )

    if (Test-Path $ExecutablePath) {
        Write-Host "$PackageName is already installed."
    } else {
        Write-Host "Installing $PackageName..."
        $InstallerPath = "$env:TEMP\$PackageName-Installer.$FileType"
        Invoke-WebRequest -Uri $InstallerUrl -OutFile $InstallerPath
        Start-Process -FilePath $InstallerPath -ArgumentList $Arguments -Wait
        Remove-Item $InstallerPath
        Write-Host "$PackageName installation completed."
    }
}

# Install Git
$GitInstallerUrl = "https://github.com/git-for-windows/git/releases/latest/download/Git-2.42.0-64-bit.exe"
$GitExecutablePath = "C:\Program Files\Git\bin\git.exe"
Install-Package -PackageName "Git" -InstallerUrl $GitInstallerUrl -ExecutablePath $GitExecutablePath

# Install Node.js
$NodeInstallerUrl = "https://nodejs.org/dist/v18.17.1/node-v18.17.1-x64.msi"
$NodeExecutablePath = "C:\Program Files\nodejs\node.exe"
Install-Package -PackageName "Node.js" -InstallerUrl $NodeInstallerUrl -ExecutablePath $NodeExecutablePath -FileType "msi"

# Install GitHub CLI
$GitHubCLIInstallerUrl = "https://github.com/cli/cli/releases/latest/download/gh_2.34.0_windows_amd64.msi"
$GitHubCLIExecutablePath = "$env:ProgramFiles\GitHub CLI\gh.exe"
Install-Package -PackageName "GitHub CLI" -InstallerUrl $GitHubCLIInstallerUrl -ExecutablePath $GitHubCLIExecutablePath -FileType "msi"

# Install Python and verify Pip
$PythonInstallerUrl = "https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe"
$PythonExecutablePath = "C:\Python311\python.exe"
Install-Package -PackageName "Python" -InstallerUrl $PythonInstallerUrl -ExecutablePath $PythonExecutablePath

Write-Host "Verifying pip installation..."
if ((& $PythonExecutablePath -m pip --version) -eq $null) {
    Write-Host "Installing pip..."
    & $PythonExecutablePath -m ensurepip
}

# Install VSCode extensions
$extensions = @(
    "ms-python.python",                # Python
    "ms-vscode.cpptools",              # C/C++ tools
    "esbenp.prettier-vscode",          # Prettier for code formatting
    "dbaeumer.vscode-eslint",          # ESLint for JavaScript and TypeScript
    "ms-azuretools.vscode-docker",     # Docker tools
    "ms-vscode.azure-account",         # Azure account integration
    "ms-azuretools.vscode-cosmosdb"    # Azure Cosmos DB tools
)

foreach ($extension in $extensions) {
    Write-Host "Installing VSCode extension: $extension"
    code --install-extension $extension
}

# Set up VSCode settings
$settingsPath = "$env:APPDATA\Code\User\settings.json"
if (!(Test-Path $settingsPath)) {
    New-Item -ItemType File -Path $settingsPath
}

$settingsContent = @'
{
    "editor.fontSize": 14,
    "editor.formatOnSave": true,
    "files.autoSave": "afterDelay",
    "terminal.integrated.shell.windows": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"
}
'@

Set-Content -Path $settingsPath -Value $settingsContent

Write-Host "Installation script completed successfully!"

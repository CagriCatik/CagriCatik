# Define paths and download URLs
$downloadsFolder = "$env:USERPROFILE\Downloads\ToolInstaller"
$tools = @(
    @{
        Name = "Visual Studio Code"
        Url = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
        Installer = "$downloadsFolder\VSCodeSetup.exe"
        SilentArgs = "/silent /mergetasks=!runcode"
    },
    @{
        Name = "KiCad"
        Url = "https://downloads.kicad.org/kicad/windows/kicad-6.0.11-x86_64.exe"
        Installer = "$downloadsFolder\KiCadSetup.exe"
        SilentArgs = "/S"
    },
    @{
        Name = "FreeCAD"
        Url = "https://github.com/FreeCAD/FreeCAD/releases/download/0.20.2/FreeCAD-0.20.2-WIN-x64-installer.exe"
        Installer = "$downloadsFolder\FreeCADSetup.exe"
        SilentArgs = "/S"
    }
)

# Create downloads folder if not exists
if (-not (Test-Path $downloadsFolder)) {
    New-Item -Path $downloadsFolder -ItemType Directory | Out-Null
}

# Function to download and install a tool
function Install-Tool {
    param (
        [string]$name,
        [string]$url,
        [string]$installerPath,
        [string]$silentArgs
    )

    Write-Host "Downloading $name..." -ForegroundColor Cyan
    try {
        Invoke-WebRequest -Uri $url -OutFile $installerPath
        Write-Host "Downloaded $name successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to download $name. Check your internet connection or the URL." -ForegroundColor Red
        return
    }

    Write-Host "Installing $name..." -ForegroundColor Cyan
    try {
        Start-Process -FilePath $installerPath -ArgumentList $silentArgs -Wait -NoNewWindow
        Write-Host "$name installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install $name. Check the installer file or permissions." -ForegroundColor Red
    }
}

# Download and install each tool
foreach ($tool in $tools) {
    Install-Tool -name $tool.Name -url $tool.Url -installerPath $tool.Installer -silentArgs $tool.SilentArgs
}

Write-Host "All tools have been installed!" -ForegroundColor Yellow

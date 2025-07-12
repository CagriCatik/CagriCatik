# installer.ps1

# Check for admin rights
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run this script as Administrator!"
    exit 1
}

# App list
$apps = @(
    @{ Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode" },
    @{ Name = "Microsoft Teams"; Id = "Microsoft.Teams" },
    @{ Name = "Docker Desktop"; Id = "Docker.DockerDesktop" },
    @{ Name = "KiCad"; Id = "KiCad.KiCad" },
    @{ Name = "FreeCAD"; Id = "FreeCAD.FreeCAD" },
    @{ Name = "Bambu Studio"; Id = "Bambulab.BambuStudio" },
    @{ Name = "WhatsApp"; Id = "WhatsApp.WhatsApp" },
    @{ Name = "Git"; Id = "Git.Git" },
    @{ Name = "GitHub Desktop"; Id = "GitHub.GitHubDesktop" }
)

# Logging
$logFile = "$PSScriptRoot\install-log.txt"
"Installation started at $(Get-Date)" | Out-File $logFile

# Install loop
foreach ($app in $apps) {
    Write-Host "`nInstalling $($app.Name)..."
    try {
        winget install --id $($app.Id) -e --accept-package-agreements --accept-source-agreements -h | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Installed: $($app.Name)"
            "[$(Get-Date)] Installed: $($app.Name)" | Out-File $logFile -Append
        } else {
            Write-Warning "Failed: $($app.Name), Exit code: $LASTEXITCODE"
            "[$(Get-Date)] Failed: $($app.Name), Exit code: $LASTEXITCODE" | Out-File $logFile -Append
        }
    } catch {
        Write-Error "Error installing $($app.Name): $_"
        "[$(Get-Date)] Error: $($app.Name): $_" | Out-File $logFile -Append
    }
}

# Final output
Write-Host "`nAll installations attempted. See log file:" -ForegroundColor Yellow
Write-Host $logFile

# =============================================================
# Ubuntu-22.04 WSL Setup Script (with Removal of Existing Ubuntu-22.04)
# This script:
#   • Checks for admin rights
#   • Enables WSL and Virtual Machine Platform (if not already enabled)
#   • Removes any existing Ubuntu-22.04 installations from WSL
#   • Installs Ubuntu-22.04 (via WSL) without blocking further execution
#   • Removes any existing Ubuntu-22.04 Windows Terminal profiles and adds a new one
# =============================================================

# Ensure script is running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as an Administrator. Please re-run in an elevated PowerShell window."
    exit
}

# Enable required Windows features for WSL
$requiresRestart = $false

# Enable Windows Subsystem for Linux
$wslFeature = Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
if ($wslFeature.State -ne 'Enabled') {
    Write-Host "Enabling Windows Subsystem for Linux..."
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart | Out-Null
    $requiresRestart = $true
} else {
    Write-Host "WSL feature already enabled."
}

# Enable Virtual Machine Platform
$vmFeature = Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
if ($vmFeature.State -ne 'Enabled') {
    Write-Host "Enabling Virtual Machine Platform..."
    Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart | Out-Null
    $requiresRestart = $true
} else {
    Write-Host "Virtual Machine Platform already enabled."
}

# If a restart is required, prompt user to restart or exit
if ($requiresRestart) {
    Write-Host "A system restart is required to complete feature installation."
    Write-Host "Restarting now..."
    Start-Sleep -Seconds 2
    Restart-Computer -Force
    exit
}

# Update the WSL Kernel
Write-Host "Updating the WSL kernel..."
wsl --update

# Remove any existing Ubuntu-22.04 installations
$installedDistros = wsl.exe --list --quiet 2>$null
$ubuntuDistros = $installedDistros -split "`n" | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '(?i)ubuntu-22.04' }

if ($ubuntuDistros.Count -gt 0) {
    Write-Host "Existing Ubuntu-22.04 installation(s) detected. Removing them..."
    foreach ($distro in $ubuntuDistros) {
        Write-Host "Unregistering distro: $distro"
        wsl.exe --unregister $distro
    }
    Write-Host "All existing Ubuntu-22.04 installations have been removed."
} else {
    Write-Host "No existing Ubuntu-22.04 installation found."
}

# Install Ubuntu-22.04 distribution for WSL without blocking further script execution
Write-Host "Installing Ubuntu-22.04..."
Start-Process -FilePath "wsl.exe" -ArgumentList "--install -d Ubuntu-22.04" -NoNewWindow
Write-Host "Ubuntu-22.04 installation initiated. Follow any on-screen prompts in the new distro console window."

# Configure Windows Terminal Profile for Ubuntu-22.04
$wtSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (Test-Path $wtSettingsPath) {
    Write-Host "Updating Windows Terminal settings: Removing any existing Ubuntu-22.04 profiles..."
    try {
        # Read the current settings
        $json = Get-Content $wtSettingsPath -Raw | ConvertFrom-Json
        
        # Ensure the profiles structure exists
        if (-not $json.profiles) {
            $json.profiles = @{ list = @() }
        } elseif (-not $json.profiles.list) {
            $json.profiles.list = @()
        }
        
        # Remove any profiles with the name "Ubuntu-22.04"
        $json.profiles.list = $json.profiles.list | Where-Object { $_.name -ne "Ubuntu-22.04" }
        
        # Create a new unique GUID for the Ubuntu-22.04 profile
        $ubuntuGuid = (New-Guid).ToString("B")
        $ubuntuProfile = @{
            guid              = $ubuntuGuid
            name              = "Ubuntu-22.04"
            commandline       = "wsl.exe -d Ubuntu-22.04"
            startingDirectory = "%USERPROFILE%"
            hidden            = $false
        }
        $json.profiles.list += $ubuntuProfile
        
        # Write the updated settings back to the file
        $json | ConvertTo-Json -Depth 10 | Set-Content $wtSettingsPath
        Write-Host "Ubuntu-22.04 profile added to Windows Terminal."
    }
    catch {
        Write-Error "An error occurred while updating Windows Terminal settings: $_"
    }
}
else {
    Write-Host "Windows Terminal settings file not found."
    Write-Host "If you have Windows Terminal installed, open it once so that the settings file is created."
}

Write-Host "Setup complete. You should now have a fresh Ubuntu-22.04 installation in WSL and a Windows Terminal profile to launch it."

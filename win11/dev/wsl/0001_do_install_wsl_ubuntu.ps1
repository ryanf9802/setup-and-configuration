if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as an Administrator. Please re-run in an elevated PowerShell window."
    exit
}

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

# SYSTEM RESTART
if ($requiresRestart) {
    Write-Host "A system restart is required to complete feature installation."
    Write-Host "Restarting now..."
    Start-Sleep -Seconds 2
    Restart-Computer -Force
    exit
}

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

# Install Ubuntu-22.04 distribution for WSL (asynchronously)
Write-Host "Installing Ubuntu-22.04..."
Start-Process -FilePath "wsl.exe" -ArgumentList "--install -d Ubuntu-22.04" -NoNewWindow
Write-Host "Ubuntu-22.04 installation initiated. Follow any on-screen prompts in the new distro console window."

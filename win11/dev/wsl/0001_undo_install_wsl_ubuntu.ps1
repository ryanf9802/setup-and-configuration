# =============================================================
# Ubuntu-22.04 WSL Uninstall Script (with Removal of Windows Terminal Profile)
# This script:
#   • Checks for admin rights
#   • Unregisters the Ubuntu-22.04 installation from WSL (if it exists)
#   • Removes the Ubuntu-22.04 Windows Terminal profile (if it exists)
# =============================================================

# Ensure script is running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as an Administrator. Please re-run in an elevated PowerShell window."
    exit
}

# Unregister any existing Ubuntu-22.04 installations from WSL
$installedDistros = wsl.exe --list --quiet 2>$null
$ubuntuDistros = $installedDistros -split "`n" | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '(?i)ubuntu-22.04' }

if ($ubuntuDistros.Count -gt 0) {
    Write-Host "Found the following Ubuntu-22.04 installation(s):"
    foreach ($distro in $ubuntuDistros) {
        Write-Host "Unregistering distro: $distro"
        wsl.exe --unregister $distro
    }
    Write-Host "Ubuntu-22.04 WSL installation(s) have been unregistered."
} else {
    Write-Host "No Ubuntu-22.04 installation found in WSL."
}

# Remove the Ubuntu-22.04 Windows Terminal profile from settings.json
$wtSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (Test-Path $wtSettingsPath) {
    Write-Host "Checking Windows Terminal settings for Ubuntu-22.04 profile..."
    try {
        # Read the current Windows Terminal settings JSON
        $json = Get-Content $wtSettingsPath -Raw | ConvertFrom-Json

        # Check if the profiles and list exist
        if ($json.profiles -and $json.profiles.list) {
            $profileCountBefore = $json.profiles.list.Count
            # Remove any profiles with the name "Ubuntu-22.04"
            $json.profiles.list = $json.profiles.list | Where-Object { $_.name -ne "Ubuntu-22.04" }
            $profileCountAfter = $json.profiles.list.Count

            if ($profileCountBefore -ne $profileCountAfter) {
                # Write the updated settings back to the file
                $json | ConvertTo-Json -Depth 10 | Set-Content $wtSettingsPath
                Write-Host "Ubuntu-22.04 profile removed from Windows Terminal settings."
            }
            else {
                Write-Host "No Ubuntu-22.04 profile found in Windows Terminal settings."
            }
        }
        else {
            Write-Host "No profiles section found in Windows Terminal settings."
        }
    }
    catch {
        Write-Error "An error occurred while updating Windows Terminal settings: $_"
    }
}
else {
    Write-Host "Windows Terminal settings file not found. Please run Windows Terminal at least once to generate the settings file."
}

Write-Host "Uninstallation complete."

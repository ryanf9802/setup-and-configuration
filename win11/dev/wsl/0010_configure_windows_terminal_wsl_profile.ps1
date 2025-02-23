# Define the Windows Terminal settings file path
$wtSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (Test-Path $wtSettingsPath) {
    Write-Host "Loading Windows Terminal settings from $wtSettingsPath ..."
    try {
        # Read and convert the JSON settings file
        $json = Get-Content $wtSettingsPath -Raw | ConvertFrom-Json

        # Ensure the profiles structure exists
        if (-not $json.profiles -or -not $json.profiles.list) {
            Write-Host "Profiles section or list not found in settings file."
            exit
        }

        # Locate the Ubuntu-22.04 profile
        $profile = $json.profiles.list | Where-Object { $_.name -eq "Ubuntu-22.04" }
        if (-not $profile) {
            Write-Host "Ubuntu-22.04 profile not found in Windows Terminal settings."
            exit
        }

        # Set the profile's color scheme to "Dark+"
        $profile.colorScheme = "Dark+"
        Write-Host "Profile 'Ubuntu-22.04' now uses the 'Dark+' color scheme."

        # Write the updated settings back to the file
        $json | ConvertTo-Json -Depth 10 | Set-Content $wtSettingsPath
        Write-Host "Windows Terminal settings have been updated."
    }
    catch {
        Write-Error "An error occurred while updating Windows Terminal settings: $_"
    }
}
else {
    Write-Host "Windows Terminal settings file not found. Please run Windows Terminal at least once so that the settings file is created."
}

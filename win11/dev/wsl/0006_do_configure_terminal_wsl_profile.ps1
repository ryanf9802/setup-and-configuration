# Configure Windows Terminal Profile Appearance for Ubuntu-22.04

# Define the path to the Windows Terminal settings file.
$wtSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (Test-Path $wtSettingsPath) {
    Write-Host "Configuring the Ubuntu-22.04 profile appearance..."

    try {
        # Load the current settings file.
        $json = Get-Content $wtSettingsPath -Raw | ConvertFrom-Json

        # Verify that the profiles list exists.
        if (-not $json.profiles -or -not $json.profiles.list) {
            Write-Error "Profiles list not found in the settings file."
            exit 1
        }

        # Find the Ubuntu-22.04 profile.
        $profile = $json.profiles.list | Where-Object { $_.name -eq "Ubuntu-22.04" }
        if (-not $profile) {
            Write-Error "Profile 'Ubuntu-22.04' not found."
            exit 1
        }

        # Define the desired configuration settings.
        $desiredColorScheme = "Solarized Dark"
        $desiredFontFace    = "Cascadia Code"
        $desiredCursorShape = "bar"

        # Update the profile settings.
        $profile.colorScheme = $desiredColorScheme
        $profile.fontFace    = $desiredFontFace
        $profile.cursorShape = $desiredCursorShape

        # Write the updated settings back to the file.
        $json | ConvertTo-Json -Depth 10 | Set-Content $wtSettingsPath

        Write-Host "Successfully configured the Ubuntu-22.04 profile:"
        Write-Host "  Color Scheme: $desiredColorScheme"
        Write-Host "  Font Face:    $desiredFontFace"
        Write-Host "  Cursor Shape: $desiredCursorShape"
    }
    catch {
        Write-Error "An error occurred while updating the profile: $_"
    }
}
else {
    Write-Host "Windows Terminal settings file not found."
    Write-Host "Please open Windows Terminal at least once to generate the settings file."
}

Write-Host "Profile configuration complete."

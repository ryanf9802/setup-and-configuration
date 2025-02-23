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

        # Define the custom color scheme name
        $schemeName = "CustomDarkGray"

        # Create a new scheme object with the desired background color
        $newScheme = @{
            name          = $schemeName
            background    = "#2D2D2D"
            foreground    = "#FFFFFF"  # Adjust as needed
            black         = "#000000"
            red           = "#C51E14"
            green         = "#1DC121"
            yellow        = "#C7C329"
            blue          = "#0A2FC4"
            purple        = "#C839C5"
            cyan          = "#20C5C6"
            white         = "#C7C7C7"
            brightBlack   = "#686868"
            brightRed     = "#FD6F6B"
            brightGreen   = "#67F86F"
            brightYellow  = "#FFFA72"
            brightBlue    = "#6A76FB"
            brightPurple  = "#FD7CFC"
            brightCyan    = "#68FDFE"
            brightWhite   = "#FFFFFF"
        }

        # Ensure the schemes section exists
        if (-not $json.schemes) {
            $json.schemes = @()
        }

        # Check if the scheme already exists, and update or add accordingly
        $existingScheme = $json.schemes | Where-Object { $_.name -eq $schemeName }
        if ($existingScheme) {
            $existingScheme.background = "#2D2D2D"
            Write-Host "Updated existing color scheme '$schemeName'."
        }
        else {
            $json.schemes += $newScheme
            Write-Host "Added new color scheme '$schemeName'."
        }

        # Update the profile to use the new color scheme
        $profile.colorScheme = $schemeName
        Write-Host "Profile 'Ubuntu-22.04' now uses the '$schemeName' color scheme."

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

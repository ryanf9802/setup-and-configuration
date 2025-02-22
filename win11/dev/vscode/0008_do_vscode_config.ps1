# Define the path to VSCode's settings.json
$settingsPath = "$env:APPDATA\Code\User\settings.json"

# If the settings file doesn't exist, initialize an empty JSON object
if (!(Test-Path $settingsPath)) {
    $settings = @{}
} else {
    # Read the existing settings file as a raw string and convert from JSON
    $json = Get-Content $settingsPath -Raw
    $settings = $json | ConvertFrom-Json
}

# Set explorer.compactFolders to false
$settings."explorer.compactFolders" = $false

# Convert the updated settings back to JSON and write to the file
$settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath

Write-Host "VSCode's explorer.compactFolders has been set to false."

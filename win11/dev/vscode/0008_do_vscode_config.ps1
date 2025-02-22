# Define a list of VSCode settings (property names and their values)
$configSettings = @{
    "explorer.compactFolders" = $false
    # Add additional settings as needed, for example:
    # "editor.fontSize" = 14
    # "files.autoSave" = "afterDelay"
}

# Define the path to VSCode's settings.json file
$settingsPath = "$env:APPDATA\Code\User\settings.json"

# Load existing settings if the file exists, otherwise start with an empty object
if (Test-Path $settingsPath) {
    $json = Get-Content $settingsPath -Raw
    $settings = $json | ConvertFrom-Json
} else {
    $settings = @{}
}

# Iterate over each property/value pair and add/update it in the settings object
foreach ($key in $configSettings.Keys) {
    $value = $configSettings[$key]
    # Use Add-Member with -Force to update or add the property
    $settings | Add-Member -MemberType NoteProperty -Name $key -Value $value -Force
}

# Convert the updated settings object back to JSON and write it to the file
$settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath

Write-Host "VSCode settings have been updated."

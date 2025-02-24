# Check if the PowerShell profile exists, create it if it doesn't.
if (-not (Test-Path $PROFILE)) {
    New-Item -Type File -Path $PROFILE -Force | Out-Null
    Write-Output "Created profile file at $PROFILE"
}

# Define a marker to identify the block of alias definitions.
$marker = "# Alias definitions added by 0012_do_powershell_aliases"

# Prepare the alias definitions with a marker.
$aliasBlock = @"
$marker
Set-Alias -Name l -Value Get-ChildItem -Force -Scope Global
"@

# Check if the marker is already in the profile to avoid duplicate entries.
if (-not (Get-Content $PROFILE | Select-String -SimpleMatch $marker)) {
    Add-Content -Path $PROFILE -Value $aliasBlock
    Write-Output "Alias definitions appended to your profile."
} else {
    Write-Output "Alias definitions already exist in your profile."
}

. $PROFILE
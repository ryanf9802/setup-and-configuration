$SCRIPT_ID = 0015

function Log_Info {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    Write-Host "[$SCRIPT_ID] $Message" -ForegroundColor Gray
}

function Log_Error {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    Write-Host "[$SCRIPT_ID] $Message" -ForegroundColor Red
}

function Log_Success {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    Write-Host "[$SCRIPT_ID] $Message" -ForegroundColor Green
}

function Log_Warning {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    Write-Host "[$SCRIPT_ID] $Message" -ForegroundColor Yellow
}

# Get a list of all installed extensions
$extensions = code --list-extensions

# Loop through and uninstall each extension
foreach ($ext in $extensions) {
    Log_Info "Uninstalling extension: $ext"
    $output = code --uninstall-extension $ext 2>&1
    if ($LASTEXITCODE -eq 0) {
        Log_Success "Successfully uninstalled: $ext"
    } else {
        Log_Error "Failed to uninstall: $ext`n$output"
    }
}

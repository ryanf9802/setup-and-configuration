# Define the path for our custom prompt configuration file.
$promptFile = "$env:USERPROFILE\powershell_prompt.ps1"

# Prepare the content with a placeholder <ESC> for the escape character.
$content = @'
$RED    = "<ESC>[0;31m"
$GREEN  = "<ESC>[1;32m"
$YELLOW = "<ESC>[0;33m"
$BLUE   = "<ESC>[0;34m"
$PURPLE = "<ESC>[1;35m"
$CYAN   = "<ESC>[0;36m"
$WHITE  = "<ESC>[0;37m"
$NC     = "<ESC>[0m"

function Get-GitInfo {
    try {
        git rev-parse --is-inside-work-tree > $null 2>&1
        if ($LASTEXITCODE -eq 0) {
            $repoPath = git rev-parse --show-toplevel 2>$null
            $repo = if ($repoPath) { Split-Path $repoPath -Leaf } else { "" }
            $branch = (git symbolic-ref --short HEAD 2>$null).Trim()
            if (git rev-parse --abbrev-ref "@{u}" > $null 2>&1) {
                $ahead = (git rev-list --count "@{u}..HEAD" 2>$null).Trim()
            } else {
                $ahead = 0
            }
            return "$PURPLE[$repo | $branch | $ahead]$NC "
        }
    }
    catch {
        return ""
    }
    return ""
}

function Shorten-Path {
    param(
        [string]$Path
    )
    # Get the drive (e.g., "C:\")
    $drive = [System.IO.Path]::GetPathRoot($Path)
    # Remove the drive part and split the rest of the path
    $rest = $Path.Substring($drive.Length)
    $parts = $rest -split '\\' | Where-Object { $_ -ne "" }
    # If there are 2 or fewer subdirectories, return the full path.
    if ($parts.Count -le 2) {
        return $Path
    }
    else {
        # Otherwise, show only the last two folders.
        $lastTwo = $parts[$parts.Count - 2] + "\" + $parts[$parts.Count - 1]
        return " $drive...\$lastTwo"
    }
}

function prompt {
    $username = [System.Environment]::UserName
    $hostname = [System.Environment]::MachineName
    $cwd = (Get-Location).Path
    # Use the helper function to shorten the working directory if needed.
    $shortCwd = Shorten-Path $cwd
    $gitInfo = Get-GitInfo
    return "${GREEN}$username@$hostname${NC}:${CYAN}$shortCwd${NC} $gitInfo> "
}
'@

# Replace the placeholder <ESC> with the actual escape character.
$esc = [char]27
$content = $content -replace "<ESC>", $esc

# Write the content to the prompt file.
$content | Out-File -FilePath $promptFile -Encoding UTF8

Write-Output "PowerShell prompt configuration written to $promptFile."

# Ensure that your PowerShell profile exists.
if (-not (Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

# Read the current content of your profile.
$profileContent = Get-Content $PROFILE -ErrorAction SilentlyContinue
$dotSourceLine = ". '$promptFile'"

# If the dot-source line isn’t already present, add it.
if ($profileContent -notcontains $dotSourceLine) {
    Add-Content -Path $PROFILE -Value "`n# Dot-source custom prompt configuration`n$dotSourceLine"
    Write-Output "Added prompt configuration sourcing to $PROFILE."
} else {
    Write-Output "Prompt configuration sourcing already exists in $PROFILE."
}

# Reload your profile in the current session.
. $PROFILE

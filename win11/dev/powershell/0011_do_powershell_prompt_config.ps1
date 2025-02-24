# Define the path for our custom prompt configuration file.
$promptFile = "$env:USERPROFILE\powershell_prompt.ps1"

# Write the prompt configuration to the file.
@'
# ANSI color definitions (using PowerShell escape sequence syntax)
$RED    = "`e[0;31m"
$GREEN  = "`e[1;32m"
$YELLOW = "`e[0;33m"
$BLUE   = "`e[0;34m"
$PURPLE = "`e[1;35m"
$CYAN   = "`e[0;36m"
$WHITE  = "`e[0;37m"
$NC     = "`e[0m"

function Get-GitInfo {
    try {
        # Check if the current directory is inside a Git repository.
        git rev-parse --is-inside-work-tree > $null 2>&1
        if ($LASTEXITCODE -eq 0) {
            # Retrieve the repository's top-level directory and extract its name.
            $repoPath = git rev-parse --show-toplevel 2>$null
            $repo = if ($repoPath) { Split-Path $repoPath -Leaf } else { "" }
            # Get the current branch name.
            $branch = (git symbolic-ref --short HEAD 2>$null).Trim()
            # If an upstream exists, count the number of commits ahead.
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

function prompt {
    # Retrieve the username, hostname, and current working directory.
    $username = [System.Environment]::UserName
    $hostname = [System.Environment]::MachineName
    $cwd = (Get-Location).Path
    # Get Git status info if available.
    $gitInfo = Get-GitInfo
    # Format the prompt: username@hostname in green, working directory in cyan,
    # Git info in purple, followed by a '>'.
    return "${GREEN}$username@$hostname${NC}:${CYAN}$cwd${NC} $gitInfo> "
}
'@ | Out-File -FilePath $promptFile -Encoding UTF8

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

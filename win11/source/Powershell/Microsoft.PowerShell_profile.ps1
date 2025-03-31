$NVIM_INIT="C:\Users\ryanf\AppData\Local\nvim\init.lua"
$NVIM_DIR="C:\Users\ryanf\AppData\Local\nvim"

function l {
    if (Get-Command lsd -ErrorAction SilentlyContinue) {
        lsd -a -l --group-dirs=first
    } else {
        Get-ChildItem -Force
    }
}

### ANSI Escape Color Codes (Using ESC character)
$ESC    = [char]27
$RED    = "${ESC}[0;31m"
$GREEN  = "${ESC}[1;32m"
$YELLOW = "${ESC}[0;33m"
$BLUE   = "${ESC}[0;34m"
$PURPLE = "${ESC}[1;35m"
$CYAN   = "${ESC}[0;36m"
$WHITE  = "${ESC}[0;37m"
$NC     = "${ESC}[0m"

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
    $drive = [System.IO.Path]::GetPathRoot($Path)
    $rest = $Path.Substring($drive.Length)
    $parts = $rest -split '\\' | Where-Object { $_ -ne "" }
    if ($parts.Count -le 2) {
        return $Path
    } else {
        $lastTwo = $parts[$parts.Count - 2] + "\" + $parts[$parts.Count - 1]
        return " $drive...\$lastTwo"
    }
}

function prompt {
    $username = [System.Environment]::UserName
    $hostname = [System.Environment]::MachineName
    $cwd = (Get-Location).Path
    $shortCwd = Shorten-Path $cwd
    $gitInfo = Get-GitInfo
    return "$GREEN${username}@${hostname}$NC" + ":" + "$CYAN${shortCwd}$NC $gitInfo> "
}

function ExtractText {
    param (
        [string]$Path = ".",
        [string]$OutFile = $null
    )

    $basePath = (Resolve-Path $Path).Path
    $results = @()

    Get-ChildItem -Path $basePath -Recurse -File | ForEach-Object {
        try {
            $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
            $content = [System.Text.Encoding]::UTF8.GetString($bytes)

            # Check for non-text characters (binary noise)
            if ($content -match '[\x00-\x08\x0B\x0C\x0E-\x1F]') {
                return
            }

            $trimmedContent = $content.Trim()
            $relativePath = $_.FullName.Substring($basePath.Length).TrimStart('\', '/')

            # Determine language for code block from file extension
            $extension = [System.IO.Path]::GetExtension($_.Name).TrimStart('.').ToLower()
            if ([string]::IsNullOrWhiteSpace($extension)) { $extension = "txt" }

            $results += "### $relativePath"
            $results += '```'
            $results += $trimmedContent
            $results += '```'
            $results += ""
        } catch {
            # Skip unreadable files
        }
    }

    if ($OutFile) {
        $results | Out-File -FilePath $OutFile -Encoding utf8
    } else {
        $results
    }
}


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

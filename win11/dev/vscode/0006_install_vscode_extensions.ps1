# VSCode extension IDs
$extensions = @(
    "DavidAnson.vscode-markdownlint"
)

foreach ($extension in $extensions) {
    Write-Host "Installing extension: $extension"
    code --install-extension $extension
}

# VSCode extension IDs
$extensions = @(
    "DavidAnson.vscode-markdownlint"
)

foreach ($extension in $extensions) {
    code --install-extension --force $extension
}

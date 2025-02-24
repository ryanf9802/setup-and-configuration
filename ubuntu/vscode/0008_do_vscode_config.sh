#!/bin/bash

# Define patterns to exclude (these will all be set to true)
EXCLUDE_PATTERNS=(
    "**/node_modules"
    "**/dist"
    "**/.git"
)

# Compute a JSON object for the files.exclude setting from the list.
# Each pattern becomes a key with the value true.
EXCLUDE_JSON=$(printf '%s\n' "${EXCLUDE_PATTERNS[@]}" | jq -R . | jq -s 'map({(.): true}) | add')

# Path to VSCode's settings.json file in WSL
settingsPath="$HOME/.vscode-server/data/Machine/settings.json"

# Define our config updates as an array of jq filter expressions.
# Note: Keys with dots must be quoted.
CONFIGS=(
    '.["explorer.compactFolders"] = false'
    '.["editor.fontSize"] = 14'
    '.["gitlens.plusFeatures.enabled"] = false'
    '.["gitlens.showWhatsNewAfterUpgrades"] = false'
    '.["gitlens.currentLine.enabled"] = true'
    '.["editor.formatOnSave"] = true'
    '.["editor.formatOnSaveMode"] = "modificationsIfAvailable"'
    '.["gitlens.currentLine.dateFormat"] = "YYYY-MM-DD"'
    '.["workbench.remoteIndicator.showExtensionRecommendations"] = false'
    '.["extensions.ignoreRecommendations"] = true'
    '.["files.exclude"] = ""'
)

# Build and apply the jq filter using the CONFIGS array.
updateSettings() {
    local filter=""
    for conf in "${CONFIGS[@]}"; do
        if [ -z "$filter" ]; then
            filter="$conf"
        else
            filter="$filter | $conf"
        fi
    done
    jq "$filter"
}

# Create the settings file with an empty JSON object if it doesn't exist
if [ ! -f "$settingsPath" ]; then
    mkdir -p "$(dirname "$settingsPath")"
    echo "{}" >"$settingsPath"
fi

# Update settings: load the existing settings, apply changes, and write back to file
tmpFile=$(mktemp)
if updateSettings <"$settingsPath" >"$tmpFile"; then
    mv "$tmpFile" "$settingsPath"
    echo "VSCode settings have been updated."
else
    echo "Error updating settings."
    rm "$tmpFile"
    exit 1
fi

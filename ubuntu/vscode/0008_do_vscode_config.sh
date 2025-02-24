#!/bin/bash

# Path to VSCode's settings.json file in WSL
settingsPath="$HOME/.vscode-server/data/Machine/settings.json"

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

if [ ! -f "$settingsPath" ]; then
    mkdir -p "$(dirname "$settingsPath")"
    echo "{}" >"$settingsPath"
fi

# Load the existing settings, apply changes, write back to file
tmpFile=$(mktemp)
if updateSettings <"$settingsPath" >"$tmpFile"; then
    mv "$tmpFile" "$settingsPath"
    echo "VSCode settings have been updated."
else
    echo "Error updating settings."
    rm "$tmpFile"
    exit 1
fi

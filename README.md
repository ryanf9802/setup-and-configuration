# Setup and Configuration Scripts

This repository contains a collection of PowerShell and shell scripts designed to streamline the setup and configuration of a new machine or an existing system. These scripts automate common tasks, install essential software, and enhance terminal usability for numerous OS environments.

## Features

- **WSL Installation & Configuration**

  - Automates the installation of Windows Subsystem for Linux (WSL)
  - Configures Ubuntu with essential packages and settings
  - Sets up an optimized Windows Terminal profile for WSL

- **PowerShell Customization**

  - Enhances PowerShell prompt with colorized output and Git status
  - Defines global aliases for improved command efficiency
  - Configures Windows Terminal settings

- **Ubuntu Terminal Enhancements**

  - Customizes the Bash prompt with Git status and colorized output
  - Applies personalized `.bashrc` and `.bash_aliases` configurations
  - Installs commonly used development tools

- **Software Installation**

  - Automates installation of key development tools and utilities
  - Configures VSCode with essential extensions and settings

- **OS Feature Configuration**
  - Adjusts OS settings for improved usability and helpful functionality
  - Configures VSCode and other development tools with predefined settings
  - Ensures smooth integration between Windows and WSL

## Getting Started

### Prerequisites

- Git installed and configured

### Installation

1. Clone this repository

```
git clone https://github.com/ryanf9802/setup-and-configuration.git
```

2. Review and modify any scripts to match system preferences and needs

### Usage

Each script is self-contained and can be executed independently. However, for a full system setup, follow the order outlined in the [Operation Steps](#operation-steps) section.

### Contributing

Contributions are welcome! Feel free to submit issues and pull requests to improve these scripts and introduce functionality.

## Operation Steps

### Powershell Setup

1. [Powershell `0011` Powershell Prompt Configuration](./win11/dev/powershell/0011_do_powershell_prompt_config.ps1)
2. [Powershell `0012` Powershell Profile Aliases](./win11/dev/powershell/0012_do_powershell_aliases.ps1)

### WSL Ubuntu Setup

1. [Powershell `0001` Install WSL Ubuntu](./win11/dev/wsl/0001_do_install_wsl_ubuntu.ps1)
2. [Powershell `0010` Configure WSL Ubuntu Terminal Profile](./win11/dev/wsl/0010_do_configure_windows_terminal_wsl_profile.ps1)
3. [Powershell `0003` Provide Setup Resources to Ubuntu](./win11/dev/wsl/0003_do_clone_setup_repo_to_wsl.ps1)
4. [Ubuntu `0004` Create Workspace Directory](./ubuntu/common/0004_do_create_workspace_directory.sh)
5. [Ubuntu `0013` Hush Bash MOTD](./ubuntu/common/0013_do_hush_motd.sh)
6. [Ubuntu `0002` Bash Aliases](./ubuntu/dev/0002_do_bash_aliases.sh)
7. [Ubuntu `0005` Ubuntu Git Configuration](./ubuntu/dev/0005_do_ubuntu_git_config.sh)
8. [Ubuntu `0007` Ubuntu Terminal Configuration](./ubuntu/dev/0007_do_terminal_config.sh)
9. [Ubuntu `0014` Reload .bashrc](./ubuntu/common/0014_do_reload_bashrc.sh)
10. [Ubuntu `0009` Ubuntu Package Installation and Update](./ubuntu/common/0009_do_install_update_packages.sh)
11. [Ubuntu `0008` VSCode Settings Configuration](./ubuntu/vscode/0008_do_vscode_config.sh)
12. [Ubuntu `0006` VSCode Extension Installation](./ubuntu/vscode/0006_do_install_vscode_extensions.sh)

# Setup Repository

Ryan Fitzpatrick

## Operation Steps

Only execute the top level (numbered) steps. The substeps (bulleted) are the scripts run within the parent.

### Powershell Setup

1. [Powershell `0011` Powershell Prompt Configuration](./win11/dev/powershell/0011_do_powershell_prompt_config.ps1)
2. [Powershell `0012` Powershell Profile Aliases](./win11/dev/powershell/0012_do_powershell_aliases.ps1)

### WSL Ubuntu Setup

1. [Powershell `0001` Install WSL Ubuntu](./win11/dev/wsl/0001_do_install_wsl_ubuntu.ps1)
2. [Powershell `0010` Configure WSL Ubuntu Terminal Profile](./win11/dev/wsl/0010_do_configure_windows_terminal_wsl_profile.ps1)
3. [Powershell `0003` Provide Setup Resources to Ubuntu](./win11/dev/wsl/0003_do_clone_setup_repo_to_wsl.ps1)
4. [WSL `0004` Initial Ubuntu Setup](./ubuntu/common/0004_do_initial_ubuntu_setup.sh)
   - [`0002` Bash Aliases](./ubuntu/dev/0002_do_bash_aliases.sh)
   - [`0005` Ubuntu Git Configuration](./ubuntu/dev/0005_do_ubuntu_git_config.sh)
   - [`0007` Ubuntu Terminal Configuration](./ubuntu/dev/0007_do_terminal_config.sh)
   - [`0009` Ubuntu Package Installation and Update](./ubuntu/common/0009_do_install_update_packages.sh)
5. [WSL `0008` VSCode Settings Configuration](./ubuntu/vscode/0008_do_vscode_config.sh)
6. [WSL `0006` VSCode Extension Installation](./ubuntu/vscode/0006_do_install_vscode_extensions.sh)

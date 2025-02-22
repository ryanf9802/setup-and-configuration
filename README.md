# Setup Repository

Ryan Fitzpatrick

## Full Execution Steps

Only the top level steps must be completed- all subtasks (indented bullets/numbers) are completed by the parent.

1. PS `0001`
	1. Enable required windows features for WSL
		- WSL Feature
		- Virtual Machine Platform
	2. **Machine Restart**
	3. Update WSL Kernel
	4. Remove any pre-existing Ubuntu 22.04 installations
	5. Install Ubuntu 22.04 WSL distribution (**async**)
	6. Configure windows terminal profile for Ubuntu
2. PS `0003`
	1. Clones Setup repo to ubuntu
3. WSL `0004` Ubuntu configuration
	1. Creates `~/workspace` directory
	2. Creates `~/hushlogin` to silence Ubuntu MOTDs
	3. `0002` Registers Aliases
	4. `0005` Git configuration
	5. `0007` Configures terminal/prompt display
	6. Reloads `~/.bashrc`
4. PS `0008` VSCode Configuration
5. PS `0006` VSCode Extensions
# NeoVim Installation

The `nvim` folder should be placed in `C:\Users\<Username>\AppData\Local`.

## Installation Instructions

### Chocolatey

> For managing/installing CLI tools/packages

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Be sure to run `choco --version` afterwards to validate installation.

### Neovim / Dependencies

```
choco install neovim mingw ripgrep make -y
```

#### Install Validation

- `nvim`
- `gcc --version`
- `rg --version`
- `make --version`

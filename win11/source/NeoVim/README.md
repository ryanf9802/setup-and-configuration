# NVIM Application Directory

The `nvim` folder should be placed in `C:\Users\ryanf\AppData\Local`.

## Dependencies

### Chocolately

> For managing/installing CLI tools/packages

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Be sure to run `choco --version` afterwards to validate installation.

### Node.JS and NPM

```
choco install nodejs.install -y
```

### Ripgrep

> For telescope fuzzy finder live grep

```
choco install ripgrep -y
```

Run `rg --version` to validate installation.

### Make

> For improved fuzzy find matching

```
choco install make -y
```

Run `make --version` to validate installation.

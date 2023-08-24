# Check if script is run with admin priviledges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Output "This script needs to be run Administrator Priviledges."
  exit
}

# Setup winget
Function Install-Winget {
  if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
    Write-Host "Winget Already Installed" -ForegroundColor Green
  }
  else {
    Write-Host "Winget is not installed. Installing Winget...." -ForegroundColor Yellow
    Invoke-WebRequest https://raw.githubusercontent.com/asheroto/winget-install/master/winget-install.ps1 -UseBasicParsing | Invoke-Expression
  }
}

# Setup chocolatey
Function Install-Choco {
  if ((Get-Command -Name choco -ErrorAction Ignore) -and (Get-Item "$env:ChocolateyInstall\choco.exe" -ErrorAction Ignore).VersionInfo.ProductVersion) {
    Write-Host "Chocolatey Already Installed" -ForegroundColor Green
  }
  else {
    Write-Host "Chocolatey is not installed. Installing chocolatey...." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction Stop
    powershell choco feature enable -n allowGlobalConfirmation

    Write-Host "Chocolatey installed!" -ForegroundColor Green
  }
}

Function Install-PwshModules {
  Write-Host "#### Installing PowerShell Modules ####" -ForegroundColor Yellow
  Write-Host "Installing PowerShellGet.."-ForegroundColor Cyan
  Install-Module PowerShellGet -Force -AllowClobber
  Write-Host "Installing PSReadLine.." -ForegroundColor Cyan
  Install-Module PSReadLine -AllowPrerelease -Force
  Write-Host "Installing PSFzf.." -ForegroundColor Cyan
  Install-Module -Name PSFzf -Force
  Write-Host "Installing PSDotFiles.." -ForegroundColor Cyan
  Install-Module -Name PSDotFiles -Force
}

Function Install-Wsl {
  Write-Host "#### Setting up WSL ####" -ForegroundColor Yellow
  If (Get-Command -Name wsl -ErrorAction Ignore) {
    Write-Host "WSL is already installed..." -ForegroundColor Green
  }
  Else {
    wsl --install --no-distribution
  }
  wsl --set-default-version 2
  If ((wsl -l -v) -replace "`0" | Select-String -Pattern "Ubuntu-22.04") {
    Write-Host "Ubuntu 22.04 already installed..." -ForegroundColor Green
  }
  Else {
    Write-Host "Installing Ubuntu 22.04.." -ForegroundColor Cyan
    wsl --install Ubuntu-22.04
  }
}

Function Install-Pkgs ($obj) {
  if (!$obj) {
    Write-Host "Invalid selection" -ForegroundColor red
    return
  }
  Write-Host "#### Installing $($obj.Type) ####" -ForegroundColor Yellow
  if ($obj.Winget) {
    foreach ($pkg in $obj.Winget) {
      Write-Host "Installing $($pkg.split(".")[1]) ..." -ForegroundColor Cyan
      winget install --id=$pkg --source winget --exact --silent --accept-package-agreements
    }
  }
  if ($obj.Choco) {
    foreach ($pkg in $obj.Choco) {
      Write-Host "Installing $pkg ..." -ForegroundColor Cyan
      choco install $pkg -y --limit-output
    }
  }
  Write-Host ""
}

$pkgs =
[PSCustomObject]@{
  Type   = "Essentials"
  Winget =
  "7zip.7zip",
  "Bitwarden.Bitwarden",
  "Brave.Brave",
  "File-New-Project.EarTrumpet",
  "Flameshot.Flameshot",
  "Google.Drive",
  "Microsoft.PowerToys",
  "Notepad++.Notepad++",
  "Obsidian.Obsidian",
  "OBSProject.OBSStudio",
  "SyncTrayzor.SyncTrayzor",
  "Twilio.Authy",
  "VideoLAN.VLC",
  "voidtools.Everything.Alpha"
},
[PSCustomObject]@{
  Type   = "Utils"
  Winget =
  "AntibodySoftware.WizTree",
  "AutoHotkey.AutoHotkey",
  "BleachBit.BleachBit",
  "code51.Carnac", # Screen key
  "Espanso.Espanso",
  "geeksoftwareGmbH.PDF23Creator",
  "GIMP.GIMP",
  "Oracle.VirtualBox",
  "qBittorrent.qBittorrent",
  "StefanSundin.Superf4",
  "TechPowerUp.NVCleanstall",
  "valinet.ExplorerPatcher"
},
[PSCustomObject]@{
  Type   = "Dev Packages"
  Winget =
  "Git.Git",
  "GoLang.Go",
  "JesseDuffield.lazygit",
  "Microsoft.PowerShell",
  "Microsoft.VisualStudioCode",
  "Microsoft.WindowsTerminal",
  "Neovim.Neovim",
  "OpenJS.NodeJS",
  "Python.Python.3.12",
  "Rustlang.Rust.MSVC",
  "Schniz.fnm",
  "wez.wezterm"
  Choco  =
  "make",
  "mingw"
},
[PSCustomObject]@{
  Type   = "CLI Packages"
  Winget =
  "ajeetdsouza.zoxide",
  "BurntSushi.ripgrep.MSVC",
  "junegunn.fzf",
  "o2sh.onefetch",
  "sharkdp.bat",
  "sharkdp.fd",
  "Starship.Starship"
  Choco  =
  "lsd",
  "winfetch"
},
[PSCustomObject]@{
  Type   = "Gaming Packges"
  Winget =
  "EpicGames.EpicGamesLauncher",
  "Valve.Steam"
}

## Other useful pkgs ##
# "CPUID.CPU-Z"
# "Rufus.Rufus_Microsoft.Winget.Source_7wekyb3d8bbwe"
# "UderzoSoftware.SpaceSniffer"
# "Safing.Portmaster"
# "Wagnardsoft.DisplayDriverUninstaller"
# "CPUID.HWMonitor"
# "Balena.Etcher"
# "xanderfrangos.twinkletray"

# Check if Package managers are installed
Install-Choco
Install-Winget

Write-Host "
Choose what to install
1. Essentials
2. Utils
3. Dev
4. CLI
5. Gaming
6. PowerShell Modules
7. Install WSL
0. (ALL)

" -ForegroundColor Blue
$selected = Read-Host "Enter Choice (eg: 1,2) "
Write-Host ""

If ($selected -eq "") {
  Write-Host "Invalid Option" -ForegroundColor Red
}
ElseIf ($selected.Length -gt 1) {
  $selected = $selected.split(",")
  ForEach ($i in $selected) {
    If ($i -eq 6) {
      Install-PwshModules
    }
    Else {
      Install-Pkgs($pkgs[$i - 1])
    }
  }
}
Else {
  switch ($selected) {
    0 {
      ForEach ($obj in $pkgs) {
        Install-Pkgs($obj)
      }
      Install-PwshModules
      Install-Wsl
    }
    6 {
      Install-PwshModules
    }
    7 {
      Install-Wsl
    }
    Default {
      Install-Pkgs($pkgs[$selected - 1])
    }
  }
}

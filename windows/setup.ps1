# Check if script is run with admin priviledges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Write-Output "This script needs to be run Administrator Priviledges."
  exit
}

Function Print() {
  param(
    [String]$content,
    [System.ConsoleColor]$color
  )
  Write-Host $content -ForegroundColor $color
}

# Setup winget
Function Install-Winget {
  if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe) {
    Print "Winget Already Installed" Green
  }
  else {
    Print "Winget is not installed. Installing Winget...." Yellow
    Invoke-WebRequest https://raw.githubusercontent.com/asheroto/winget-install/master/winget-install.ps1 -UseBasicParsing | Invoke-Expression
  }
}

# Setup chocolatey
Function Install-Choco {
  if ((Get-Command -Name choco -ErrorAction Ignore) -and (Get-Item "$env:ChocolateyInstall\choco.exe" -ErrorAction Ignore).VersionInfo.ProductVersion) {
    Print "Chocolatey Already Installed" Green
  }
  else {
    Print "Chocolatey is not installed. Installing chocolatey...." Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction Stop
    powershell choco feature enable -n allowGlobalConfirmation

    Print "Chocolatey installed!" Green
  }
}

# Setup scoop
Function Install-Scoop {
  if (Get-Command -Name scoop -ErrorAction Ignore) {
    Print "Scoop is Already Installed" Green
  }
  else {
    Print "scoop is not installed. Installing scoop...." Yellow
    Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
    scoop bucket add extras
  }
}

Function Install-PwshModules {
  Print "#### Installing PowerShell Modules ####" Yellow
  Print "Installing PowerShellGet.." Cyan
  Install-Module -Name PowerShellGet -AllowPrerelease -Force
  Print "Installing PSReadLine.."  Cyan
  Install-Module PSReadLine -Force
  Print "Installing PSFzf.." Cyan
  Install-Module -Name PSFzf -Force
}

Function Install-Wsl {
  Print "#### Setting up WSL ####" Yellow
  wsl --install --no-distribution
  wsl --set-default-version 2
}

Function Install-Pkgs ($obj) {
  if (!$obj) {
    Print "Invalid selection" Red
    return
  }
  Print "#### Installing $($obj.Type) ####" Yellow
  if ($obj.Winget) {
    foreach ($pkg in $obj.Winget) {
      Print "Installing $($pkg.split(".")[1]) ..." Cyan
      winget install --id=$pkg --source winget --exact --silent --accept-package-agreements
    }
  }
  if ($obj.Choco) {
    foreach ($pkg in $obj.Choco) {
      Print "Installing $pkg ..." Cyan
      choco install $pkg -y --limit-output
    }
  }
  if ($obj.Scoop) {
    foreach ($pkg in $obj.Scoop) {
      Print "Installing $pkg ..." Cyan
      scoop install $pkg
    }
  }
  Write-Host ""
}
$pkgs =
[PSCustomObject]@{
  Type   = "System Utilities"
  Winget =
  "7zip.7zip",  # File compression
  "AntibodySoftware.WizTree",  # Disk space analyzer
  "CodeSector.TeraCopy",  # File transfer
  "File-New-Project.EarTrumpet",  # Audio control
  "Microsoft.PowerToys",  # System enhancements
  "voidtools.Everything.Alpha",  # File search
  "glzr-io.glazewm",  # Window management
  "glzr-io.zebar",  # Status bar
  "StefanSundin.Superf4",  # Process killer
  "Microsoft.OpenSSH.Beta"
},
[PSCustomObject]@{
  Type   = "Media & Communication"
  Winget =
  "VideoLAN.VLC",  # Media player
  "OBSProject.OBSStudio",  # Screen recording
  "Spotify.Spotify",  # Music
  "Discord.Discord",  # Communication
  "Flameshot.Flameshot"  # Screenshot
},
[PSCustomObject]@{
  Type   = "Productivity & Documents"
  Winget =
  "Notepad++.Notepad++",
  "Bitwarden.Bitwarden",  # Password manager
  "TheDocumentFoundation.LibreOffice",
  "Brave.Brave",  # Browser
  "Espanso.Espanso",  # Text expander
  "DEVCOM.JetBrainsMonoNerdFont"
},
[PSCustomObject]@{
  Type   = "Cloud & Sync"
  Winget =
  "Google.Drive",
  "Google.GoogleDrive",
  "SyncTrayzor.SyncTrayzor"
},
[PSCustomObject]@{
  Type   = "Development Environment"
  Winget =
  "Git.Git",
  "Microsoft.PowerShell",
  "Microsoft.VisualStudioCode",
  "Microsoft.WindowsTerminal",
  "Neovim.Neovim",
  "wez.wezterm",
  "JesseDuffield.lazygit"
},
[PSCustomObject]@{
  Type   = "Programming Languages & SDKs"
  Winget =
  "GoLang.Go",
  "Rustlang.Rustup",
  "Schniz.fnm"  # Node.js version manager
  Choco  =
  "make",
  "mingw"
},
[PSCustomObject]@{
  Type   = "CLI Tools"
  Winget =
  "ajeetdsouza.zoxide",  # Directory jumper
  "BurntSushi.ripgrep.MSVC",  # Search tool
  "junegunn.fzf",  # Fuzzy finder
  "o2sh.onefetch",  # Git repo summary
  "sharkdp.bat",  # Cat alternative
  "sharkdp.fd",  # Find alternative
  "Starship.Starship"  # Shell prompt
  Choco  =
  "lsd",  # ls alternative
  "winfetch"  # System info
  Scoop  =
  "kanata"  # Keyboard customization
},
[PSCustomObject]@{
  Type   = "Hardware & Diagnostics"
  Winget =
  "Wagnardsoft.DisplayDriverUninstaller",
  "CPUID.HWMonitor",
  "TechPowerUp.NVCleanstall",
  "seerge.g-helper"  # ASUS ROG control
},
[PSCustomObject]@{
  Type   = "Virtualization & Downloads"
  Winget =
  "Oracle.VirtualBox",
  "qBittorrent.qBittorrent"
},
[PSCustomObject]@{
  Type   = "Gaming"
  Winget =
  "EpicGames.EpicGamesLauncher",
  "Valve.Steam"
}

# Rest of the script remains the same, but update the menu options:
Print "
Choose what to install
1. System Utilities
2. Media & Communication
3. Productivity & Documents
4. Cloud & Sync
5. Development Environment
6. Programming Languages & SDKs
7. CLI Tools
8. Hardware & Diagnostics
9. Virtualization & Downloads
10. Gaming
11. PowerShell Modules
12. Install WSL
0. (ALL)
"  Blue

$selected = Read-Host "Enter Choice (eg: 1,2) "
Write-Host ""

If ([string]::IsNullOrWhiteSpace($selected)) {
    Print "No selection provided. Please select at least one option." Red
}
ElseIf ($selected.Length -gt 1) {
    $selected = $selected.split(",")
    ForEach ($i in $selected) {
        If ($i -eq 11) {
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
        11 {
            Install-PwshModules
        }
        12 {
            Install-Wsl
        }
        Default {
            Install-Pkgs($pkgs[$selected - 1])
        }
    }
}

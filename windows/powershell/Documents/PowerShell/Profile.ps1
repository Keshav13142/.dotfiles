# Refer
# https://github.com/ChrisTitusTech/powershell-profile/blob/main/Microsoft.PowerShell_profile.ps1
# https://gist.github.com/shanselman/25f5550ad186189e0e68916c6d7f44c3

# Set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

########### Initialize modules ##############
# Starship
Invoke-Expression (&starship init powershell)

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -EditMode Windows
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) {
      'prompt'
    }
    else {
      'pwd'
    }
    (zoxide init --hook $hook powershell | Out-String)
  })

#################### Functions ###########################
# General
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function export($name, $value) {
  set-item -force -path "env:$name" -value $value;
}

function unzip ($file) {
  Write-Output("Extracting", $file, "to", $pwd)
  $fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
  Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function pkill($name) {
  Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
  Get-Process $name
}

function find-file($name) {
  Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Output "${_}"
  }
}

function grep($regex, $dir) {
  if ( $dir ) {
    Get-ChildItem $dir | select-string $regex
    return
  }
  $input | select-string $regex
}

function Unzip([string]$zipfile, [string]$outpath) {
  [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

function updateOMPThemes() {
  $zipfile = "$ENV:USERPROFILE\Downloads\themes.zip"
  $outpath = "$ENV:USERPROFILE\Documents\omp_themes"

  Set-Location C:\Users\Keshavv\Downloads

  # Download the lates themes
  wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v14.22.0/themes.zip

  # Remove old themes
  Remove-Item C:\Users\Keshavv\Documents\omp_themes\ -Recurse

  # Extract themes and copy to correct path
  [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
  Remove-Item $zipfile
}

function add_to_path {
  param (
    [string]$addPath,
    [ValidateSet('Process', 'User', 'Machine')]
    [string]$Scope = 'Process'
  )
  if (Test-Path $addPath) {
    $regexAddPath = [regex]::Escape($addPath)
    $arrPath = [System.Environment]::GetEnvironmentVariable('PATH', $Scope)  | Where-Object { $_ -notMatch "^$regexAddPath\\?" }
    $value = ($arrPath + $addPath) -join ';'
    [System.Environment]::SetEnvironmentVariable('PATH', $value, $Scope)
  }
  else {
    Throw "'$addPath' is not a valid path."
  }
}

# Empty the Recycle Bin on all drives
function Clear-RecycleBin {
  $RecBin = (New-Object -ComObject Shell.Application).Namespace(0xA)
  $RecBin.Items() | ForEach-Object { Remove-Item $_.Path -Recurse -Confirm:$false }
}

# Create a new directory and enter it
function New-Dir([String] $path) {
  New-Item $path -ItemType Directory -ErrorAction SilentlyContinue;
  Set-Location $path
}

# Set a permanent Environment variable, and reload it into $env
function Set-Environment([String] $variable, [String] $value) {
  Set-ItemProperty "HKCU:\Environment" $variable $value
  Invoke-Expression "`$env:${variable} = `"$value`""
}

#################### Aliases ###########################
# General
${function:debloat} = { Invoke-WebRequest christitus.com/win | Invoke-Expression }
${function:cmatrix} = { Invoke-WebRequest https://raw.githubusercontent.com/matriex/cmatrix/master/cmatrix.psm1 | Invoke-Expression }
${function:admin} = { Start-Process wezterm-gui -Verb runAs }
${function:betterCat} = { bat -p $args }
${function:lsd_ls} = { lsd --config-file C:\Users\skesh\AppData\Roaming\lsd\config.yml $args }
${function:ll} = { lsd_ls -l }
${function:la} = { lsd_ls -al }
${function:l} = { lsd_ls -al }
${function:clist} = { choco list }
${function:open} = { explorer $args }
${function:et} = { exit }
${function:Set-ParentLocation} = { Set-Location .. }
${function:~} = { Set-Location ~ }
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }
${function:touch} = { New-Item $args }

Set-Alias -Name cat -Value betterCat -Force
Set-Alias -Name cd -Value z -Force -Option AllScope
Set-Alias -Name cl -Value clear
Set-Alias -Name copy -Value clip -Force -Option AllScope
Set-Alias -Name ff -Value find-file
Set-Alias -Name lg -Value lazygit
Set-Alias -Name ls -Value lsd_ls -Force
Set-Alias -Name ogcat -Value Get-Content
Set-Alias -Name op -Value open
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin
Set-Alias -Name time -Value Measure-Command
$lvimPath = "$ENV:USERPROFILE\.local\bin\lvim.ps1"
if (Test-Path $lvimPath -PathType Leaf) {
  Set-Alias lvim "$lvimPath"
  Set-Alias -Name v -Value lvim
}
else {
  Set-Alias -Name v -Value nvim
}
Set-Alias ".." Set-ParentLocation
Set-Alias head 'C:\Program Files\Git\usr\bin\head.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias mkd New-Dir
Set-Alias tail 'C:\Program Files\Git\usr\bin\tail.exe'
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias trsh Clear-RecycleBin

# Npm
${function:ns} = { npm start }
${function:nr} = { npm run $args }
${function:nrd} = { npm run dev }
${function:nrb} = { npm run build }
${function:nra} = { npm run android }
${function:nh} = {
  Write-Host "ns  => npm start"
  Write-Host "nrd => npm run dev"
  Write-Host "nra => npm run android"
  Write-Host "nrb => npm run build"
  Write-Host "nr  => npm run {name}"
}

# Github
${function:gitAdd} = { git add $args }
${function:gitLog} = { git log }
${function:gitRefLog} = { git reflog }
${function:gitBranch} = { git branch -a }
${function:gitCommit} = { git commit -m $args }
${function:gitClone} = { git clone $args }
${function:gitRemoteAdd} = { git remote add origin $args }
${function:gitRemoteRemove} = { git remote remove origin $args }
${function:gitRemoteList} = { git remote -v }
${function:gitCheckout} = { git checkout $args }
${function:gitFetch} = { git fetch }
${function:gitPull} = { git pull }
${function:gitPush} = { git push }
${function:gs} = { git status }

Set-Alias g git
Set-Alias -Name gl -Value gitLog -Force
Set-Alias -Name ga -Value gitAdd
Set-Alias -Name grl -Value gitRefLog
Set-Alias -Name gb -Value gitBranch
Set-Alias -Name gc -Value gitCommit -Force
Set-Alias -Name gcl -Value gitClone
Set-Alias -Name gra -Value gitRemoteAdd
Set-Alias -Name grr -Value gitRemoteRemove
Set-Alias -Name gr -Value gitRemoteList
Set-Alias -Name gf -Value gitFetch
Set-Alias -Name gp -Value gitPush -Force
Set-Alias -Name gco -Value gitCheckout -Force
Set-Alias -Name gcn -Value gitCheckoutNew -Force

$reg_path = "HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout"
$reg_name = "Scancode Map"
function add_remap() {
  New-ItemProperty -Path $reg_path -Name $reg_name -PropertyType Binary -Value ([byte[]](
      0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00,
      0x02, 0x00, 0x00, 0x00, # No.of keymaps
      0x01, 0x00, 0x3A, 0x00, # Remap caps to esc
      0x00, 0x00, 0x00, 0x00
    ))
}
function rm_remmap {
  Remove-ItemProperty -Path $reg_path -Name $reg_name
}

######################## Exports #########################
Set-Environment "KOMOREBI_CONFIG_HOME" "$ENV:USERPROFILE\.config\komorebi"

######################## Other stuff #########################
# Autocompletion for winget commands
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
  $Local:word = $wordToComplete.Replace('"', '""')
  $Local:ast = $commandAst.ToString().Replace('"', '""')
  winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

# Insert text from the clipboard as a here string
Set-PSReadLineKeyHandler -Key Ctrl+V `
  -BriefDescription PasteAsHereString `
  -LongDescription "Paste the clipboard text as a here string" `
  -ScriptBlock {
  param($key, $arg)

  Add-Type -Assembly PresentationCore
  if ([System.Windows.Clipboard]::ContainsText()) {
    # Get clipboard text - remove trailing spaces, convert \r\n to \n, and remove the final \n.
    $text = ([System.Windows.Clipboard]::GetText() -replace "\p{Zs}*`r?`n", "`n").TrimEnd()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("@'`n$text`n'@")
  }
  else {
    [Microsoft.PowerShell.PSConsoleReadLine]::Ding()
  }
}

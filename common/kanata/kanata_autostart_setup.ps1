$KanataDirectoryPath = "$env:UserProfile\.config\kanata"

$KanataExePath = $(Get-Command -Name "kanata" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue)

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Kanata" -Value "`"C:\Windows\System32\conhost.exe`" --headless `"$KanataExePath`" --cfg `"$KanataDirectoryPath\kanata.kbd`""

$wpmExePath = $(Get-Command -Name "wpm" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue)

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "wpm" -Value "`"C:\Windows\System32\conhost.exe`" --headless `"$wpmExePath`""

# Add-MpPreference -ExclusionPath "$wpmExePath"

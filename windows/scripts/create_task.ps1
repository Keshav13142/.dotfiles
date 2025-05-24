$currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if (-not $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  Write-Warning "This script requires Administrator privileges to run."
  Write-Warning "Please right-click on the script file and select 'Run as administrator', or open an elevated PowerShell prompt."
  Write-Warning "Exiting script."
  exit 1
}
Write-Host "Running with Administrator privileges. Proceeding..."

$TaskName = "Launch My Custom Apps"
$TaskDescription = "Starts Komorebi, WHKD, YASB, Kanata, Masir at user logon using a custom PowerShell script."
$PowerShellScriptPath = "$env:USERPROFILE\.config\scripts\start_all.ps1"
$LogonUser = $env:USERNAME

$Action = New-ScheduledTaskAction -Execute "conhost.exe" `
  -Argument "--headless powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""$PowerShellScriptPath"""

$Trigger = New-ScheduledTaskTrigger -AtLogOn -User $LogonUser

$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries `
  -DontStopIfGoingOnBatteries `
  -RunOnlyIfNetworkAvailable:$false `
  -ExecutionTimeLimit ([System.TimeSpan]::Zero) `
  -MultipleInstances IgnoreNew -Compatibility Win8

$Principal = New-ScheduledTaskPrincipal -UserId $LogonUser `
  -LogonType Interactive `

$Task = New-ScheduledTask -Action $Action `
  -Trigger $Trigger `
  -Settings $Settings `
  -Principal $Principal `
  -Description $TaskDescription `

Write-Host "Attempting to register scheduled task '$TaskName'..."

try
{
  Write-Host "Checking if task '$TaskName' exists to delete..."
  if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue)
  {
    Write-Host "Task '$TaskName' found. Deleting it..."
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
    Write-Host "Task '$TaskName' deleted successfully."
  } else
  {
    Write-Host "Task '$TaskName' does not exist. Proceeding to create."
  }

  # Step 2: Register (Create) the new task
  Write-Host "Creating new scheduled task '$TaskName'..."
  Register-ScheduledTask -InputObject $Task -TaskName $TaskName
  Write-Host "Task '$TaskName' created successfully."
} catch
{
  Write-Error "Failed to register scheduled task '$TaskName'. Error: $($_.Exception.Message)"
  Write-Warning "Ensure you run this script with Administrator privileges if using RunLevel Highest."
}

Write-Host "`nVerifying task status..."
Get-ScheduledTask -TaskName $TaskName | Select-Object TaskName, State, LastRunTime, LastTaskResult

# Disable-ScheduledTask -TaskName $TaskName
# Enable-ScheduledTask -TaskName $TaskName
# Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false

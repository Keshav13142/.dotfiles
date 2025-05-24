function pkill($name)
{
  Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

pkill masir
pkill kanata
pkill whkd
pkill komorebi
pkill komorebi-bar
pkill yasb

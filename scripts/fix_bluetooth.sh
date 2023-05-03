echo "fixing BT"
## Hard Refresh
## End Service (If it is running)
sudo systemctl stop bluetooth.service
## Removes Hardware Emulation
sudo systemctl unmask bluetooth.service

## Start Service
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth

## Re-Enable Hardware Emulation
sudo systemctl mask bluetooth.service
sudo rmmod btusb
sudo modprobe btusb

## Unblock from rfkill
rfkill unblock all

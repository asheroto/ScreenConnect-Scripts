# Stop ScreenConnect services

Write-Output "Stopping service: ScreenConnect Web Server"
Stop-Service "ScreenConnect Web Server" -Force

Write-Output "Stopping service: ScreenConnect Relay"
Stop-Service "ScreenConnect Relay" -Force

Write-Output "Stopping service: ScreenConnect Session Manager"
Stop-Service "ScreenConnect Session Manager" -Force

Write-Output "Stopping service: ScreenConnect Security Manager"
Stop-Service "ScreenConnect Security Manager" -Force
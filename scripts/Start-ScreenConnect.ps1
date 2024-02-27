# Start ScreenConnect services

Write-Output "Starting service: ScreenConnect Web Server"
Start-Service "ScreenConnect Web Server"

Write-Output "Starting service: ScreenConnect Relay"
Start-Service "ScreenConnect Relay"

Write-Output "Starting service: ScreenConnect Session Manager"
Start-Service "ScreenConnect Session Manager"

Write-Output "Starting service: ScreenConnect Security Manager"
Start-Service "ScreenConnect Security Manager"
# Backup the ScreenConnect directory to the user profile's desktop
# This script assumes that the ScreenConnect directory is located at C:\Program Files (x86)\ScreenConnect (or wherever $env:ProgramFiles(x86) points to)

try {
    Write-Output "Stopping ScreenConnect services..."
    ./Stop-ScreenConnect.ps1

    # Wait 5 seconds to release file locks
    Write-Output "Waiting 5 seconds to release file locks..."
    Start-Sleep -Seconds 5

    # Archive the ScreenConnect directory with a timestamp using Compress-Archive
    Write-Output "Creating ZIP archive..."
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    $archivePath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop', "ScreenConnect_$timestamp.zip")
    $sourcePath = "${env:ProgramFiles(x86)}\ScreenConnect"
    Compress-Archive -Path $sourcePath -DestinationPath $archivePath
    Write-Output ("ZIP archive created at: " + $archivePath)

    # Start ScreenConnect services
    Write-Output "Starting ScreenConnect services..."
    ./Start-ScreenConnect.ps1

    Write-Output "ScreenConnect backup complete!"
    Write-Output "File is located on your desktop at: $archivePath"
} catch {
    Write-Error $_.Exception.Message
    Write-Output "Error Code: $($_.Exception.HResult)"
}
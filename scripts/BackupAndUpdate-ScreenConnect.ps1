# This script performs a backup and update on ScreenConnect

# ============================================================================ #
# Backup the ScreenConnect directory to the user profile's desktop
# This script assumes that the ScreenConnect directory is located at C:\Program Files (x86)\ScreenConnect (or wherever $env:ProgramFiles(x86) points to)
# ============================================================================ #

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

    Write-Output "ScreenConnect backup complete!"
    Write-Output "File is located on your desktop at: $archivePath"
    Write-Output ""
} catch {
    Write-Error $_.Exception.Message
    Write-Output "Error Code: $($_.Exception.HResult)"
}

# ============================================================================ #
# Update ScreenConnect to latest version by downloading the latest MSI file from the ScreenConnect website and installing it silently
# ============================================================================ #

try {
    # Define function to get web content
    Function Get-WebContent {
        param (
            [string]$url
        )
        Write-Output "Fetching web content from $url..."
        $webClient = New-Object System.Net.WebClient
        return $webClient.DownloadString($url)
    }

    # Fetch HTML content
    Write-Output "Starting HTML fetch..."
    $html = Get-WebContent -url "https://screenconnect.connectwise.com/download"

    # Define regex pattern to find MSI file URLs
    Write-Output "Defining regex pattern for MSI URL..."
    $pattern = "https:\/\/[^""]+\.msi"

    # Find matches
    Write-Output "Searching for MSI URL in HTML content..."
    $rMatches = [regex]::Matches($html, $pattern)

    # Initialize variable to hold MSI URL
    $msiUrl = $null

    # Check if at least one match was found
    if ($rMatches.Count -gt 0) {
        Write-Output "MSI URL found..."
        $msiUrl = $rMatches[0].Value
    } else {
        Write-Output "No MSI file found..."
        exit
    }

    # Output the URL
    Write-Output "MSI URL: $msiUrl"

    # Prepare temp folder path and MSI file name
    $tempFolder = [System.IO.Path]::GetTempPath()
    $msiFileName = [System.IO.Path]::GetFileName($msiUrl)
    $msiFilePath = Join-Path $tempFolder $msiFileName

    # Download the MSI file to temp folder
    Write-Output "Downloading MSI file to temp folder..."
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($msiUrl, $msiFilePath)

    # Install the MSI file silently
    Write-Output "Starting silent installation..."
    Start-Process "msiexec.exe" -ArgumentList "/i $msiFilePath /qn" -Wait

    # Delete the MSI file from temp folder
    Write-Output "Deleting MSI file from temp folder..."
    Remove-Item -Path $msiFilePath -Force

    ./Start-ScreenConnect.ps1
} catch {
    Write-Error $_.Exception.Message
    Write-Output "Error Code: $($_.Exception.HResult)"
}
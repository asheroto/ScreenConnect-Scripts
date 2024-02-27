# Update ScreenConnect to latest version by downloading the latest MSI file from the ScreenConnect website and installing it silently

try {
    Write-Warning "Backup will not occur unless performed manually!"
    Write-Warning "Continuing in 5 seconds..."
    Start-Sleep -Seconds 5

    ./Stop-ScreenConnect.ps1

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
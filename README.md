[![GitHub Sponsor](https://img.shields.io/github/sponsors/asheroto?label=Sponsor&logo=GitHub)](https://github.com/sponsors/asheroto?frequency=one-time&sponsor=asheroto)
<a href="https://ko-fi.com/asheroto"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Ko-Fi Button" height="20px"></a>
<a href="https://www.buymeacoffee.com/asheroto"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=seb6596&button_colour=FFDD00&font_colour=000000&font_family=Lato&outline_colour=000000&coffee_colour=ffffff](https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20coffee&emoji=&slug=asheroto&button_colour=FFDD00&font_colour=000000&font_family=Lato&outline_colour=000000&coffee_colour=ffffff)" height="40px"></a>

# ScreenConnect Scripts / ConnectWise Control Scripts

> [!IMPORTANT]
> These scripts are **ONLY** for self-hosted installations, which is less commonly used. **These scripts will NOT work on the cloud-based version.** Please do not contact me asking about backing up and restoring ScreenConnect for the cloud.

I went back and forth between the two names, but I think I'm going to stick with ScreenConnect Scripts since the name of the EXE and the Windows Service is ScreenConnect.

This repository is a small collection of simple PowerShell scripts that help ScreenConnect administrators manage their server.

## Scripts

| Script Name                         | Description                                                                                                                                                                                                                                                                |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Backup-ScreenConnect.ps1`          | Backs up your ScreenConnect folder to a zip file located on your desktop. It stops ScreenConnect services, zips the folder, and then restarts the services.                                                                                                                |
| `BackupAndUpdate-ScreenConnect.ps1` | Backs up your ScreenConnect folder, then updates ScreenConnect to the latest version.                                                                                                                                                                                      |
| `Restart-ScreenConnect.ps1`         | Restarts the ScreenConnect services.                                                                                                                                                                                                                                       |
| `Start-ScreenConnect.ps1`           | Starts the ScreenConnect services.                                                                                                                                                                                                                                         |
| `Stop-ScreenConnect.ps1`            | Stops the ScreenConnect services.                                                                                                                                                                                                                                          |
| `Update-ScreenConnect.ps1`          | Updates your ScreenConnect server to the latest version. The script stops the services, downloads the latest stable version by scraping the ScreenConnect website, installs the update, and restarts the services. This does not update agents, only ScreenConnect itself. |

## Usage

Several of the scripts require each other, so you'll need to download all of them for the scripts to work. Simply download the repo as a zip file and extract it.

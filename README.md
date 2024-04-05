# Set Static IP

This repository contains a PowerShell script and its standalone executable version that allows you to set a static IP address on a Windows machine. The script retrieves the current IP settings, saves them, removes the current IP configuration, and sets new static IP settings. If the current IP address is not in the APIPA range (169.254.0.0/16), it also sets the default gateway and DNS servers.

## Files

- `set_static_ip.ps1`: The PowerShell script file.
- `set_static_ip.exe`: The standalone executable version of the script.

## Prerequisites

- Windows operating system
- PowerShell execution policy set to allow script execution (for the `.ps1` file)
- Administrator privileges

## Usage

### PowerShell Script

1. Open PowerShell with administrator privileges.
2. Navigate to the directory where the `set_static_ip.ps1` file is located.
3. Run the script by executing the following command:

   ```powershell
   .\set_static_ip.ps1
   ```

### Standalone Executable

1. Open Command Prompt or PowerShell with administrator privileges.
2. Navigate to the directory where the `set_static_ip.exe` file is located.
3. Run the executable by executing the following command:

   ```
   .\set_static_ip.exe
   ```

   Alternatively, you can right-click on the `set_static_ip.exe` file and select "Run as administrator" to run the script with administrator privileges.

## Script Details

The script performs the following steps:

1. Retrieves the active network adapter and its IP configuration.
2. Saves the current IP address, subnet mask, default gateway, and DNS servers.
3. Removes the current IP configuration from the network adapter.
4. Checks if the current IP address is in the APIPA range (169.254.0.0/16).
5. Sets the new static IP address and subnet mask on the network adapter.
6. If the IP address is not in the APIPA range, it sets the default gateway and DNS servers.
7. Disables IPv6 on the network adapter.

## Notes

- The script assumes that there is only one active network adapter. If you have multiple active adapters, you may need to modify the script accordingly.
- The script sets the static IP address based on the current IP settings. If you want to set a different IP address, modify the `$ipAddress` variable in the script.
- The script disables IPv6 on the network adapter. If you require IPv6, remove or comment out the last line of the script.

## Disclaimer

Use this script and executable at your own risk. Make sure you understand what they do and have tested them in a non-production environment before running them on a production system. The author is not responsible for any damage or loss caused by the usage of these files.

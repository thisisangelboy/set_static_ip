# Get active IP settings
$adapter = Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}
$ipConfig = $adapter | Get-NetIPConfiguration

# Save current IP settings
$ipAddress = $ipConfig.IPv4Address.IPAddress
$subnetMask = $ipConfig.IPv4Address.PrefixLength
$defaultGateway = $ipConfig.IPv4DefaultGateway.NextHop
$dnsServers = $ipConfig.DNSServer.ServerAddresses

# Remove current IP settings
$ipConfig | Remove-NetIPAddress -Confirm:$false

# Check if IP address is in the APIPA range
$ipAddressBytes = ($ipAddress.Split('.'))[0..3] | ForEach-Object { [byte]$_ }
$isAPIPAddress = $ipAddressBytes[0] -eq 169 -and $ipAddressBytes[1] -eq 254

# Set new static IP settings
$ipConfig | New-NetIPAddress -IPAddress $ipAddress -PrefixLength $subnetMask

# Set default gateway and DNS servers only if IP address is not in the APIPA range
if (-not $isAPIPAddress) {
    $ipConfig | New-NetRoute -DestinationPrefix "0.0.0.0/0" -NextHop $defaultGateway
    Set-DnsClientServerAddress -InterfaceIndex ($adapter.InterfaceIndex) -ServerAddresses $dnsServers
}

# Disable IPv6
$adapter | Disable-NetAdapterBinding -ComponentID ms_tcpip6
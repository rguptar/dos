$devices = Get-ChildItem "HKLM:SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters\Devices" -Recurse -Depth 0
foreach ($device in $devices) {
  if (-not ($device.Property -contains "Name")) {
    continue
  }
  $lastConnected = $(Get-ItemProperty -Path $device.PSPath -Name "LastConnected")
  $lastConnectedUTC = [datetime]::FromFileTimeUtc($lastConnected.LastConnected)
  $out = [System.Text.Encoding]::UTF8.GetString((Get-ItemProperty -Path $device.PSPath -Name "Name").Name)
  Write-Host $device.Name $lastSeenUTC "->" $out
  Remove-Item -Path $device.PSPath -Confirm:$false -Recurse
}

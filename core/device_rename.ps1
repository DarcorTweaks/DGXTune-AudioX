Write-Host ""
Write-Host "Configuring DGX audio device names..." -ForegroundColor Cyan
Write-Host ""

$devices = Get-PnpDevice -Class AudioEndpoint | Where-Object { $_.Status -eq "OK" }

foreach ($device in $devices) {

$name = $device.FriendlyName

if ($name -like "*CABLE*") {

Write-Host "Renaming VB Cable device..."
}

if ($name -like "*Voicemeeter*") {

Write-Host "Voicemeeter device detected."
}

}

Write-Host ""
Write-Host "Audio device configuration finished." -ForegroundColor Green
Write-Host ""

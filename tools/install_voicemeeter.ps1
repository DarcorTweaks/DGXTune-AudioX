Write-Host ""
Write-Host "Installing Voicemeeter..." -ForegroundColor Cyan

$temp = "$env:TEMP\voicemeeter.exe"

$url = "https://download.vb-audio.com/Download_CABLE/VoicemeeterSetup.exe"

try {

Start-BitsTransfer -Source $url -Destination $temp

Start-Process $temp -Wait

Write-Host "Voicemeeter installed successfully." -ForegroundColor Green

} catch {

Write-Host "Failed to download Voicemeeter." -ForegroundColor Red

}

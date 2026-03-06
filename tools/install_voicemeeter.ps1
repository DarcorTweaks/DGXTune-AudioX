Write-Host ""
Write-Host "Installing Voicemeeter..." -ForegroundColor Cyan

$temp = "$env:TEMP\voicemeeter.exe"

$url = "https://download.vb-audio.com/Download_CABLE/VoicemeeterSetup.exe"

try{

Invoke-WebRequest $url -OutFile $temp

Start-Process $temp -Wait

Write-Host "Voicemeeter installation finished." -ForegroundColor Green

}catch{

Write-Host "Failed to download Voicemeeter." -ForegroundColor Red

}

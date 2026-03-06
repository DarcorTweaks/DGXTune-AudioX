Write-Host ""
Write-Host "Installing Voicemeeter..." -ForegroundColor Cyan

$tools = "$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

$url = "https://download.vb-audio.com/Download_CABLE/VoicemeeterSetup.exe"

$file = "$tools\voicemeeter.exe"

Invoke-WebRequest $url -OutFile $file

Start-Process $file -Wait

Write-Host "Voicemeeter installation finished." -ForegroundColor Green

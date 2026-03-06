Write-Host ""
Write-Host "Installing Peace Equalizer..." -ForegroundColor Cyan

$temp = "$env:TEMP\PeaceSetup.exe"

$url = "https://sourceforge.net/projects/peace-equalizer-apo-extension/files/latest/download"

Invoke-WebRequest $url -OutFile $temp

Start-Process $temp -Wait

Write-Host "Peace installation finished." -ForegroundColor Green

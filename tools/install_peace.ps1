Write-Host ""
Write-Host "Installing Peace Equalizer..." -ForegroundColor Cyan

$tools = "$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

$url = "https://sourceforge.net/projects/peace-equalizer-apo-extension/files/latest/download"

$file = "$tools\peace.exe"

Invoke-WebRequest $url -OutFile $file

Start-Process $file -Wait

Write-Host "Peace installation finished." -ForegroundColor Green

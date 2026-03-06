Write-Host ""
Write-Host "Installing Equalizer APO..." -ForegroundColor Cyan

$tools = "$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

$url = "https://sourceforge.net/projects/equalizerapo/files/latest/download"

$file = "$tools\eapo.exe"

Invoke-WebRequest $url -OutFile $file

Start-Process $file -ArgumentList "/S" -Wait

Write-Host "Equalizer APO installation finished." -ForegroundColor Green

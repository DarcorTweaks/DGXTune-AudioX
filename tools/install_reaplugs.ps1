Write-Host ""
Write-Host "Installing ReaPlugs..." -ForegroundColor Cyan

$tools = "$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

$url = "https://www.reaper.fm/files/2.x/reaplugs236-install.exe"

$file = "$tools\reaplugs.exe"

Invoke-WebRequest $url -OutFile $file

Start-Process $file -Wait

Write-Host "ReaPlugs installation finished." -ForegroundColor Green

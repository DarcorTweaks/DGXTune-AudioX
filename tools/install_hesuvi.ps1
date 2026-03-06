Write-Host ""
Write-Host "Installing HeSuVi..." -ForegroundColor Cyan

$tools = "$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

$url = "https://sourceforge.net/projects/hesuvi/files/latest/download"

$file = "$tools\hesuvi.exe"

Invoke-WebRequest $url -OutFile $file

Start-Process $file -ArgumentList "/S" -Wait

Write-Host "HeSuVi installation finished." -ForegroundColor Green

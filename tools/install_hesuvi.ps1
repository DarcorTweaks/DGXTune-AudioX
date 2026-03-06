Write-Host ""
Write-Host "Installing HeSuVi..." -ForegroundColor Cyan

$temp = "$env:TEMP\hesuvi.exe"

$url = "https://sourceforge.net/projects/hesuvi/files/latest/download"

Invoke-WebRequest $url -OutFile $temp

Start-Process $temp -Wait

Write-Host "HeSuVi installation finished." -ForegroundColor Green

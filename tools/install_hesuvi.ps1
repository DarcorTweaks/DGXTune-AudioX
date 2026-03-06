Write-Host ""
Write-Host "Installing HeSuVi..." -ForegroundColor Cyan

$temp = "$env:TEMP\hesuvi.exe"

$url = "https://sourceforge.net/projects/hesuvi/files/latest/download"

try{

Invoke-WebRequest $url -OutFile $temp

Start-Process $temp -ArgumentList "/S" -Wait

Write-Host "HeSuVi installation finished." -ForegroundColor Green

}catch{

Write-Host "Failed to install HeSuVi." -ForegroundColor Red

}

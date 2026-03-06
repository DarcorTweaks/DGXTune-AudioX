Write-Host ""
Write-Host "Installing ReaPlugs..." -ForegroundColor Cyan

$temp = "$env:TEMP\reaplugs.exe"

$url = "https://www.reaper.fm/files/2.x/reaplugs236-install.exe"

try{

Invoke-WebRequest $url -OutFile $temp

Start-Process $temp -Wait

Write-Host "ReaPlugs installation finished." -ForegroundColor Green

}catch{

Write-Host "Failed to install ReaPlugs." -ForegroundColor Red

}

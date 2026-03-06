Write-Host ""
Write-Host "Installing Peace Equalizer..." -ForegroundColor Cyan

$temp = "$env:TEMP\peace.zip"

$url = "https://sourceforge.net/projects/peace-equalizer-apo-extension/files/latest/download"

try{

Invoke-WebRequest $url -OutFile $temp

Expand-Archive $temp "$env:TEMP\peace" -Force

Start-Process "$env:TEMP\peace\Peace Setup.exe" -Wait

Write-Host "Peace installation finished." -ForegroundColor Green

}catch{

Write-Host "Failed to install Peace." -ForegroundColor Red

}

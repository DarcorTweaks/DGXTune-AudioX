Write-Host ""
Write-Host "Installing Equalizer APO..." -ForegroundColor Cyan

$temp = "$env:TEMP\eapo.exe"

$url = "https://sourceforge.net/projects/equalizerapo/files/latest/download"

try {

Invoke-WebRequest $url -OutFile $temp

Start-Process $temp -ArgumentList "/S" -Wait

Write-Host "Equalizer APO installed successfully." -ForegroundColor Green

} catch {

Write-Host "Failed to download Equalizer APO." -ForegroundColor Red

}

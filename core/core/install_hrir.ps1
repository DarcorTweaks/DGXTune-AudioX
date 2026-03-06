Write-Host ""
Write-Host "Installing DGX HRIR..." -ForegroundColor Cyan
Write-Host ""

$source = "$PSScriptRoot\..\hrir\EAC_Default.wav"

$destination = "C:\Program Files\EqualizerAPO\config\HeSuVi\hrir"

if (!(Test-Path $destination)) {

New-Item -ItemType Directory -Path $destination -Force | Out-Null

}

Copy-Item $source "$destination\EAC_Default.wav" -Force

Write-Host "HRIR installed successfully." -ForegroundColor Green
Write-Host ""

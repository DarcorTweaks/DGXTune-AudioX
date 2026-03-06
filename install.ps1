Clear-Host

Write-Host ""
Write-Host "DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "DarcorTweaks Competitive Audio Suite" -ForegroundColor DarkGray
Write-Host ""

$temp = "$env:TEMP\DGXTune"
$installer = "$temp\installer.ps1"

if (!(Test-Path $temp)) {
    New-Item -ItemType Directory -Path $temp | Out-Null
}

$url = "https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/installer.ps1"

Write-Host "Downloading installer..." -ForegroundColor Yellow

Invoke-WebRequest $url -OutFile $installer

Write-Host "Starting installer..." -ForegroundColor Green

Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$installer`""

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

Write-Host "Descargando instalador..." -ForegroundColor Yellow

Invoke-WebRequest $url -OutFile $installer

Write-Host "Iniciando instalador..." -ForegroundColor Green

Start-Sleep 1

powershell -ExecutionPolicy Bypass -File $installer

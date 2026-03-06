Clear-Host

Write-Host ""
Write-Host "DGX Tune AudioX Launcher" -ForegroundColor Cyan
Write-Host "DarcorTweaks Competitive Audio Suite" -ForegroundColor DarkGray
Write-Host ""

$temp = "$env:TEMP\DGXTune"
$installer = "$temp\DGXInstaller.ps1"

if (!(Test-Path $temp)) {
    New-Item -ItemType Directory -Path $temp | Out-Null
}

$url = "https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/DGXInstaller.ps1"

Write-Host "Descargando instalador..." -ForegroundColor Yellow

Invoke-WebRequest $url -OutFile $installer

Write-Host "Iniciando instalador..." -ForegroundColor Green

Start-Sleep 2

Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$installer`"" -Verb RunAs

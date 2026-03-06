chcp 65001 > $null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Clear-Host

Write-Host ""
Write-Host "===============================================" -ForegroundColor DarkYellow
Write-Host "               DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "        Instalador de Audio Competitivo" -ForegroundColor Gray
Write-Host "               DarcorTweaks" -ForegroundColor DarkGray
Write-Host "===============================================" -ForegroundColor DarkYellow
Write-Host ""

Write-Host "Que deseas hacer?"
Write-Host ""

Write-Host "[1] Instalacion completa"
Write-Host "[2] Diagnostico de audio"
Write-Host "[3] Salir"
Write-Host ""

$choice = Read-Host "Selecciona una opcion"

if ($choice -eq "1") {

Write-Host ""
Write-Host "Iniciando instalacion..." -ForegroundColor Green
Start-Sleep 2

}

if ($choice -eq "2") {

Write-Host ""
Write-Host "Dispositivos de audio detectados:" -ForegroundColor Cyan
Get-PnpDevice -Class AudioEndpoint

}

Read-Host "Presiona ENTER para salir"

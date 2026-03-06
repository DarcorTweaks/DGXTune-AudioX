Clear-Host

Write-Host ""
Write-Host "=================================================" -ForegroundColor DarkYellow
Write-Host "                 DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "         Instalador de Audio Competitivo" -ForegroundColor Gray
Write-Host "                DarcorTweaks" -ForegroundColor DarkGray
Write-Host "=================================================" -ForegroundColor DarkYellow
Write-Host ""

Write-Host "Este instalador configurará el sistema de audio competitivo."
Write-Host ""

Write-Host "[1] Instalación completa"
Write-Host "[2] Diagnóstico de audio"
Write-Host "[3] Salir"
Write-Host ""

$choice = Read-Host "Selecciona una opción"

if ($choice -eq "1") {

Write-Host ""
Write-Host "Instalando herramientas de audio..." -ForegroundColor Green

Start-Sleep 2

}

if ($choice -eq "2") {

Write-Host ""
Write-Host "Dispositivos de audio detectados:" -ForegroundColor Cyan

Get-PnpDevice -Class AudioEndpoint

}

Read-Host "Presiona ENTER para salir"

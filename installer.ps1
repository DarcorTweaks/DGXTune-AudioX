Clear-Host

function Banner {

Write-Host ""
Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor DarkYellow
Write-Host "║               DGX Tune AudioX                ║" -ForegroundColor Cyan
Write-Host "║         Instalador de Audio Competitivo     ║" -ForegroundColor Gray
Write-Host "║               DarcorTweaks                  ║" -ForegroundColor DarkGray
Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor DarkYellow
Write-Host ""

Write-Host "Este instalador configurará el sistema de audio competitivo." -ForegroundColor Gray
Write-Host ""
Write-Host "⚠ Advertencia:" -ForegroundColor Yellow
Write-Host "El audio del sistema se reiniciará durante la instalación." -ForegroundColor Red
Write-Host "Cierra programas y guarda tu trabajo antes de continuar." -ForegroundColor Red
Write-Host ""

}

function Menu {

Write-Host "¿Qué deseas hacer?" -ForegroundColor White
Write-Host ""

Write-Host "[1] Instalación completa (recomendado)"
Write-Host "[2] Reinstalar motor de audio"
Write-Host "[3] Reparar configuración"
Write-Host "[4] Diagnóstico de audio"
Write-Host "[5] Salir"
Write-Host ""

}

function Pause {

Read-Host "Presiona ENTER para continuar"

}

function Diagnostico {

Write-Host ""
Write-Host "Dispositivos de audio detectados:" -ForegroundColor Cyan
Get-PnpDevice -Class AudioEndpoint
Pause

}

do {

Clear-Host

Banner
Menu

$choice = Read-Host "Selecciona una opción"

switch ($choice) {

"1" {

Write-Host ""
Write-Host "Iniciando instalación completa..." -ForegroundColor Green
Write-Host ""

Start-Sleep 2

irm https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/core.ps1 | iex

Pause

}

"2" {

Write-Host ""
Write-Host "Reinstalando motor de audio..." -ForegroundColor Cyan

irm https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/engine.ps1 | iex

Pause

}

"3" {

Write-Host ""
Write-Host "Reparando configuración..." -ForegroundColor Yellow

irm https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/config.ps1 | iex

Pause

}

"4" { Diagnostico }

}

} while ($choice -ne "5")

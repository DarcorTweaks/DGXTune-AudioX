Clear-Host

function Banner {

Write-Host ""
Write-Host "=================================================" -ForegroundColor DarkYellow
Write-Host "                 DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "         Instalador de Audio Competitivo" -ForegroundColor Gray
Write-Host "                DarcorTweaks" -ForegroundColor DarkGray
Write-Host "=================================================" -ForegroundColor DarkYellow
Write-Host ""

Write-Host "Este instalador configurará el sistema de audio competitivo." -ForegroundColor Gray
Write-Host ""
Write-Host "⚠ Advertencia:" -ForegroundColor Yellow
Write-Host "El audio del sistema se reiniciará durante la instalación." -ForegroundColor Red
Write-Host "Cierra programas antes de continuar." -ForegroundColor Red
Write-Host ""

}

function InstallAudio {

$tools="$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

Write-Host ""
Write-Host "[1/5] Instalando VB Cable..." -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" -OutFile "$tools\cable.zip"
Expand-Archive "$tools\cable.zip" "$tools\cable" -Force
Start-Process "$tools\cable\VBCABLE_Setup_x64.exe" -Wait


Write-Host "[2/5] Instalando Voicemeeter..." -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VoicemeeterSetup.exe" -OutFile "$tools\vm.exe"
Start-Process "$tools\vm.exe" -Wait


Write-Host "[3/5] Instalando Equalizer APO..." -ForegroundColor Cyan

Invoke-WebRequest "https://sourceforge.net/projects/equalizerapo/files/latest/download" -OutFile "$tools\eapo.exe"
Start-Process "$tools\eapo.exe" -ArgumentList "/S" -Wait


Write-Host "[4/5] Instalando HeSuVi..." -ForegroundColor Cyan

Invoke-WebRequest "https://sourceforge.net/projects/hesuvi/files/latest/download" -OutFile "$tools\hesuvi.exe"
Start-Process "$tools\hesuvi.exe" -ArgumentList "/S" -Wait


Write-Host "[5/5] Instalando ReaPlugs..." -ForegroundColor Cyan

Invoke-WebRequest "https://www.reaper.fm/files/2.x/reaplugs236-install.exe" -OutFile "$tools\reaplugs.exe"
Start-Process "$tools\reaplugs.exe" -Wait

Write-Host ""
Write-Host "Instalación finalizada." -ForegroundColor Green

}

function Diagnostico {

Write-Host ""
Write-Host "Dispositivos de audio detectados:" -ForegroundColor Cyan

Get-PnpDevice -Class AudioEndpoint

}

do {

Clear-Host
Banner

Write-Host "[1] Instalación completa"
Write-Host "[2] Diagnóstico de audio"
Write-Host "[3] Salir"
Write-Host ""

$choice = Read-Host "Selecciona una opción"

switch ($choice) {

"1" { InstallAudio }
"2" { Diagnostico }

}

Pause

} while ($choice -ne "3")

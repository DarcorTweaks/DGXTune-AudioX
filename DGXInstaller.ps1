chcp 65001 > $null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Clear-Host

function Banner {

Write-Host ""
Write-Host "====================================================" -ForegroundColor DarkGray
Write-Host "                 DGX TUNE AUDIOX" -ForegroundColor Cyan
Write-Host "            Competitive Audio Installer" -ForegroundColor Gray
Write-Host "----------------------------------------------------" -ForegroundColor DarkGray
Write-Host "               Developed by DarcorTweaks" -ForegroundColor DarkGray
Write-Host "====================================================" -ForegroundColor DarkGray
Write-Host ""

}

$base = Split-Path -Parent $MyInvocation.MyCommand.Path

function InstallEngine {

powershell -ExecutionPolicy Bypass -File "$base\core\audio_cleanup.ps1"
powershell -ExecutionPolicy Bypass -File "$base\core\audio_engine.ps1"

}

function SelectGame {

powershell -ExecutionPolicy Bypass -File "$base\core\game_selector.ps1"

}

function Diagnostics {

Write-Host ""
Write-Host "Detected Audio Devices:" -ForegroundColor Cyan
Write-Host ""

Get-PnpDevice -Class AudioEndpoint

Write-Host ""

}

function Menu {

Write-Host "Select Option" -ForegroundColor Yellow
Write-Host ""

Write-Host "[1] Install DGX Audio Engine"
Write-Host "[2] Select Game Preset"
Write-Host "[3] Audio Diagnostics"
Write-Host "[4] Exit Installer"
Write-Host ""

}

do {

Clear-Host

Banner
Menu

$choice = Read-Host "Option"

switch ($choice){

"1" { InstallEngine }

"2" { SelectGame }

"3" { Diagnostics }

}

Read-Host "Press ENTER to continue"

} while ($choice -ne "4")

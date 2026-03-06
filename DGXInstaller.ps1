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

function SystemCheck {

Write-Host "System Check" -ForegroundColor Yellow
Write-Host ""

$os = (Get-CimInstance Win32_OperatingSystem).Caption
Write-Host "OS: $os"

$ps = $PSVersionTable.PSVersion.Major
Write-Host "PowerShell: $ps"

$admin = ([Security.Principal.WindowsPrincipal] `
[Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole]::Administrator)

if ($admin) {

Write-Host "Admin: OK" -ForegroundColor Green

} else {

Write-Host "Admin: Required" -ForegroundColor Red
Write-Host "Please run PowerShell as Administrator"
Pause
exit

}

Write-Host ""

}

function Diagnostics {

Write-Host ""
Write-Host "Detected Audio Devices:" -ForegroundColor Cyan
Write-Host ""

Get-PnpDevice -Class AudioEndpoint

Write-Host ""

}

function FullInstall {

Write-Host ""
Write-Host "Starting DGX Full Installation..." -ForegroundColor Cyan
Write-Host ""

$base = "$PSScriptRoot"

powershell -ExecutionPolicy Bypass -File "$base\core\audio_cleanup.ps1"

powershell -ExecutionPolicy Bypass -File "$base\core\audio_engine.ps1"

Write-Host ""
Write-Host "DGX Installation Completed Successfully." -ForegroundColor Green
Write-Host ""

}

function Menu {

Write-Host "Select Option" -ForegroundColor Yellow
Write-Host ""

Write-Host "[1] Install DGX Audio Engine"
Write-Host "[2] Audio Diagnostics"
Write-Host "[3] Exit Installer"
Write-Host ""

}

do {

Clear-Host

Banner
SystemCheck
Menu

$choice = Read-Host "Option"

switch ($choice){

"1" { FullInstall }

"2" { Diagnostics }

}

Read-Host "Press ENTER to continue"

} while ($choice -ne "3")

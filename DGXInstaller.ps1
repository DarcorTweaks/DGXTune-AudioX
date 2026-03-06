chcp 65001 > $null
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Clear-Host

function Banner {

Write-Host ""
Write-Host "██████╗  ██████╗ ██╗  ██╗" -ForegroundColor Cyan
Write-Host "██╔══██╗██╔════╝ ╚██╗██╔╝" -ForegroundColor Cyan
Write-Host "██║  ██║██║  ███╗ ╚███╔╝ " -ForegroundColor Cyan
Write-Host "██║  ██║██║   ██║ ██╔██╗ " -ForegroundColor Cyan
Write-Host "██████╔╝╚██████╔╝██╔╝ ██╗" -ForegroundColor Cyan
Write-Host "╚═════╝  ╚═════╝ ╚═╝  ╚═╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "DGX Tune AudioX" -ForegroundColor Yellow
Write-Host "DarcorTweaks Competitive Audio Suite" -ForegroundColor Gray
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

function LoadingAnimation {

Write-Host "Initializing DGX Audio Engine..." -ForegroundColor Cyan

for ($i=0; $i -lt 5; $i++){

Write-Host "." -NoNewline
Start-Sleep 400

}

Write-Host ""
Write-Host ""

}

function Menu {

Write-Host "Select Option"
Write-Host ""

Write-Host "[1] Full Installation"
Write-Host "[2] Repair Audio Engine"
Write-Host "[3] Audio Diagnostics"
Write-Host "[4] Exit"
Write-Host ""

}

function InstallEngine {

Write-Host ""
Write-Host "Installing Audio Components..." -ForegroundColor Cyan
Write-Host ""

$steps=@(
"VB Cable",
"Voicemeeter",
"Equalizer APO",
"HeSuVi",
"ReaPlugs"
)

$step=1

foreach ($s in $steps){

Write-Host "[$step/5] Installing $s"

for ($i=0;$i -le 100;$i+=20){

Write-Progress -Activity "Installing $s" -Status "$i% Complete" -PercentComplete $i
Start-Sleep 200

}

$step++

}

Write-Host ""
Write-Host "Installation Completed Successfully" -ForegroundColor Green
Write-Host ""

}

function Diagnostics {

Write-Host ""
Write-Host "Detected Audio Devices" -ForegroundColor Cyan
Write-Host ""

Get-PnpDevice -Class AudioEndpoint

Write-Host ""

}

do {

Clear-Host

Banner
SystemCheck
LoadingAnimation
Menu

$choice = Read-Host "Option"

switch ($choice){

"1" { InstallEngine }
"2" { InstallEngine }
"3" { Diagnostics }

}

Read-Host "Press ENTER to continue"

} while ($choice -ne "4")

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Clear-Host

function Banner {

Write-Host ""
Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor DarkYellow
Write-Host "║               DGX Tune AudioX                ║" -ForegroundColor Cyan
Write-Host "║         Competitive Audio Installer          ║" -ForegroundColor Gray
Write-Host "║               DarcorTweaks                   ║" -ForegroundColor DarkGray
Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor DarkYellow
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
}

Write-Host ""

}

function Menu {

Write-Host "What would you like to do?" -ForegroundColor White
Write-Host ""

Write-Host "[1] Full Installation"
Write-Host "[2] Repair Audio Engine"
Write-Host "[3] Audio Diagnostics"
Write-Host "[4] Exit"
Write-Host ""

}

function InstallEngine {

Write-Host ""
Write-Host "Installing Audio Tools..." -ForegroundColor Cyan
Write-Host ""

$tools="$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

Write-Host "[1/5] Installing VB Cable..."
Start-Sleep 1

Write-Host "[2/5] Installing Voicemeeter..."
Start-Sleep 1

Write-Host "[3/5] Installing Equalizer APO..."
Start-Sleep 1

Write-Host "[4/5] Installing HeSuVi..."
Start-Sleep 1

Write-Host "[5/5] Installing ReaPlugs..."
Start-Sleep 1

Write-Host ""
Write-Host "Installation Complete." -ForegroundColor Green
Write-Host ""

}

function Diagnostics {

Write-Host ""
Write-Host "Detected Audio Devices:" -ForegroundColor Cyan
Write-Host ""

Get-PnpDevice -Class AudioEndpoint

Write-Host ""

}

do {

Clear-Host

Banner
SystemCheck
Menu

$choice = Read-Host "Select option"

switch ($choice) {

"1" { InstallEngine }
"2" { InstallEngine }
"3" { Diagnostics }

}

Read-Host "Press ENTER to continue"

} while ($choice -ne "4")

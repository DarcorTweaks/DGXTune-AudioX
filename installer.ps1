Clear-Host

Write-Host ""
Write-Host "======================================"
Write-Host "       DGX Tune AudioX Installer"
Write-Host "         DarcorTweaks Suite"
Write-Host "======================================"
Write-Host ""

$workspace = "$env:USERPROFILE\DGXTune"
$tools = "$env:TEMP\DGXTools"

if (!(Test-Path $workspace)) {
    New-Item -ItemType Directory -Path $workspace | Out-Null
}

if (!(Test-Path $tools)) {
    New-Item -ItemType Directory -Path $tools | Out-Null
}

Write-Host "Workspace ready: $workspace" -ForegroundColor Green

Write-Host ""
Write-Host "1 Fresh Start (remove audio tools)"
Write-Host "2 Install Audio Engine"
Write-Host "3 Install LEQ Control Panel"
Write-Host "4 Diagnostics"
Write-Host "5 Exit"
Write-Host ""

$choice = Read-Host "Option"

function FreshStart {

Write-Host "Removing previous audio tools..."

Get-WmiObject Win32_Product |
Where-Object {$_.Name -like "*Voicemeeter*"} |
ForEach-Object {$_.Uninstall()}

Get-WmiObject Win32_Product |
Where-Object {$_.Name -like "*Equalizer APO*"} |
ForEach-Object {$_.Uninstall()}

Get-WmiObject Win32_Product |
Where-Object {$_.Name -like "*HeSuVi*"} |
ForEach-Object {$_.Uninstall()}

Write-Host "Cleanup completed." -ForegroundColor Green

}

function InstallEngine {

Write-Host "Installing audio engine..." -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" -OutFile "$tools\cable.zip"

Expand-Archive "$tools\cable.zip" "$tools\cable" -Force

Start-Process "$tools\cable\VBCABLE_Setup_x64.exe" -Verb RunAs -Wait

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VoicemeeterSetup.exe" -OutFile "$tools\voicemeeter.exe"

Start-Process "$tools\voicemeeter.exe" -Wait

Invoke-WebRequest "https://sourceforge.net/projects/equalizerapo/files/latest/download" -OutFile "$tools\eapo.exe"

Start-Process "$tools\eapo.exe" -ArgumentList "/S" -Wait

Invoke-WebRequest "https://sourceforge.net/projects/hesuvi/files/latest/download" -OutFile "$tools\hesuvi.exe"

Start-Process "$tools\hesuvi.exe" -ArgumentList "/S" -Wait

Invoke-WebRequest "https://www.reaper.fm/files/2.x/reaplugs236-install.exe" -OutFile "$tools\reaplugs.exe"

Start-Process "$tools\reaplugs.exe" -Wait

Write-Host "Audio engine installed." -ForegroundColor Green

}

function InstallLEQ {

Write-Host "Installing LEQ Control Panel..."

git clone https://github.com/ArtIsWar/LEQControlPanel.git "$tools\LEQ"

cd "$tools\LEQ"

dotnet build src/LEQControlPanel/LEQControlPanel.csproj -c Release

Write-Host "LEQ compiled." -ForegroundColor Green

}

switch ($choice) {

"1" {FreshStart}

"2" {InstallEngine}

"3" {InstallLEQ}

"4" {Get-PnpDevice -Class AudioEndpoint}

default {Write-Host "Exit"}

}

pause

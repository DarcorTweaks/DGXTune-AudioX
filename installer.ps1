Clear-Host

function Show-Banner {

Write-Host ""
Write-Host "==============================================" -ForegroundColor DarkGray
Write-Host "               DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "        Competitive Audio Engine Installer" -ForegroundColor Gray
Write-Host "                DarcorTweaks" -ForegroundColor DarkGray
Write-Host "==============================================" -ForegroundColor DarkGray
Write-Host ""

}

function Pause-Continue {

Write-Host ""
Read-Host "Press ENTER to continue"

}

function FreshStart {

Write-Host ""
Write-Host "[DGX] Removing previous audio tools..." -ForegroundColor Yellow

Get-WmiObject Win32_Product |
Where-Object {$_.Name -like "*Voicemeeter*"} |
ForEach-Object {$_.Uninstall()}

Get-WmiObject Win32_Product |
Where-Object {$_.Name -like "*Equalizer APO*"} |
ForEach-Object {$_.Uninstall()}

Get-WmiObject Win32_Product |
Where-Object {$_.Name -like "*HeSuVi*"} |
ForEach-Object {$_.Uninstall()}

Write-Host "[DGX] Cleanup completed." -ForegroundColor Green

Pause-Continue

}

function InstallEngine {

$tools = "$env:TEMP\DGXTools"

if (!(Test-Path $tools)) {

New-Item -ItemType Directory -Path $tools | Out-Null

}

Write-Host ""
Write-Host "[1/5] Installing VB-Audio Cable..." -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" -OutFile "$tools\cable.zip"

Expand-Archive "$tools\cable.zip" "$tools\cable" -Force

Start-Process "$tools\cable\VBCABLE_Setup_x64.exe" -Verb RunAs -Wait


Write-Host "[2/5] Installing Voicemeeter..." -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VoicemeeterSetup.exe" -OutFile "$tools\voicemeeter.exe"

Start-Process "$tools\voicemeeter.exe" -Wait


Write-Host "[3/5] Installing Equalizer APO..." -ForegroundColor Cyan

Invoke-WebRequest "https://sourceforge.net/projects/equalizerapo/files/latest/download" -OutFile "$tools\eapo.exe"

Start-Process "$tools\eapo.exe" -ArgumentList "/S" -Wait


Write-Host "[4/5] Installing HeSuVi..." -ForegroundColor Cyan

Invoke-WebRequest "https://sourceforge.net/projects/hesuvi/files/latest/download" -OutFile "$tools\hesuvi.exe"

Start-Process "$tools\hesuvi.exe" -ArgumentList "/S" -Wait


Write-Host "[5/5] Installing ReaPlugs..." -ForegroundColor Cyan

Invoke-WebRequest "https://www.reaper.fm/files/2.x/reaplugs236-install.exe" -OutFile "$tools\reaplugs.exe"

Start-Process "$tools\reaplugs.exe" -Wait


Write-Host ""
Write-Host "[DGX] Audio Engine installed successfully." -ForegroundColor Green

Pause-Continue

}

function InstallLEQ {

$tools = "$env:TEMP\DGXTools"

Write-Host ""
Write-Host "[DGX] Downloading LEQ Control Panel..." -ForegroundColor Cyan

git clone https://github.com/ArtIsWar/LEQControlPanel.git "$tools\LEQ"

cd "$tools\LEQ"

Write-Host "[DGX] Building LEQ Control Panel..." -ForegroundColor Cyan

dotnet build src/LEQControlPanel/LEQControlPanel.csproj -c Release

Write-Host "[DGX] LEQ Control Panel compiled." -ForegroundColor Green

Pause-Continue

}

function Diagnostics {

Write-Host ""
Write-Host "Detected Audio Devices:" -ForegroundColor Cyan

Get-PnpDevice -Class AudioEndpoint

Pause-Continue

}

do {

Clear-Host

Show-Banner

Write-Host "Select an option:" -ForegroundColor White
Write-Host ""

Write-Host "1  Fresh Start (remove previous audio tools)"
Write-Host "2  Install DGX Audio Engine"
Write-Host "3  Install LEQ Control Panel"
Write-Host "4  Diagnostics"
Write-Host "5  Exit"

Write-Host ""

$choice = Read-Host "Option"

switch ($choice) {

"1" { FreshStart }
"2" { InstallEngine }
"3" { InstallLEQ }
"4" { Diagnostics }
"5" { break }

}

} while ($choice -ne "5")

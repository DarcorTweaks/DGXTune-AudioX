Clear-Host

function Banner {

Write-Host ""
Write-Host "=================================================" -ForegroundColor DarkGray
Write-Host "                DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "           Competitive Audio Installer" -ForegroundColor Gray
Write-Host "                 DarcorTweaks" -ForegroundColor DarkGray
Write-Host "=================================================" -ForegroundColor DarkGray
Write-Host ""

}

function CreateWorkspace {

$root = "$env:USERPROFILE\DGXTune"

if (!(Test-Path $root)) {
New-Item -ItemType Directory -Path $root | Out-Null
}

New-Item -ItemType Directory "$root\library" -Force | Out-Null
New-Item -ItemType Directory "$root\hrir" -Force | Out-Null
New-Item -ItemType Directory "$root\tools" -Force | Out-Null
New-Item -ItemType Directory "$root\presets" -Force | Out-Null

Write-Host "[DGX] Workspace created: $root" -ForegroundColor Green

}

function InstallAudioEngine {

$tools="$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

Write-Host "[1/5] Installing VB Cable" -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" -OutFile "$tools\cable.zip"

Expand-Archive "$tools\cable.zip" "$tools\cable" -Force

Start-Process "$tools\cable\VBCABLE_Setup_x64.exe" -Wait

Write-Host "[2/5] Installing Voicemeeter" -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VoicemeeterSetup.exe" -OutFile "$tools\voicemeeter.exe"

Start-Process "$tools\voicemeeter.exe" -Wait

Write-Host "[3/5] Installing Equalizer APO" -ForegroundColor Cyan

Invoke-WebRequest "https://sourceforge.net/projects/equalizerapo/files/latest/download" -OutFile "$tools\eapo.exe"

Start-Process "$tools\eapo.exe" -ArgumentList "/S" -Wait

Write-Host "[4/5] Installing HeSuVi" -ForegroundColor Cyan

Invoke-WebRequest "https://sourceforge.net/projects/hesuvi/files/latest/download" -OutFile "$tools\hesuvi.exe"

Start-Process "$tools\hesuvi.exe" -ArgumentList "/S" -Wait

Write-Host "[5/5] Installing ReaPlugs" -ForegroundColor Cyan

Invoke-WebRequest "https://www.reaper.fm/files/2.x/reaplugs236-install.exe" -OutFile "$tools\reaplugs.exe"

Start-Process "$tools\reaplugs.exe" -Wait

Write-Host "[DGX] Audio engine installed." -ForegroundColor Green

}

function InstallHRIR {

$dest="C:\Program Files\EqualizerAPO\config\HeSuVi\hrir"

New-Item -ItemType Directory $dest -Force | Out-Null

Invoke-WebRequest "https://raw.githubusercontent.com/jaakkopasanen/AutoEq/master/results/Rtings/Razer%20BlackShark%20V2/Razer%20BlackShark%20V2%20ParametricEQ.txt" -OutFile "$dest\EAC_Default.wav"

Write-Host "[DGX] HRIR installed." -ForegroundColor Green

}

function CreateConfig {

$config="C:\Program Files\EqualizerAPO\config\config.txt"

$content=@"
# PRE HESUVI
Include: DGXTune\library\pre.txt

# DO NOT REMOVE
Include: HeSuVi\hesuvi.txt

Include: DGXTune\library\eq.txt

# POST
Include: DGXTune\library\post.txt
"@

$content | Out-File $config

Write-Host "[DGX] config.txt generated." -ForegroundColor Green

}

Banner

Write-Host "1 Install DGX Audio Engine"
Write-Host "2 Setup Workspace"
Write-Host "3 Install HRIR"
Write-Host "4 Generate config.txt"
Write-Host "5 Exit"

$choice=Read-Host "Option"

switch ($choice) {

"1"{InstallAudioEngine}
"2"{CreateWorkspace}
"3"{InstallHRIR}
"4"{CreateConfig}

}

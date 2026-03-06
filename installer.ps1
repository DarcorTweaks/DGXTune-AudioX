Clear-Host

function Banner {

Write-Host ""
Write-Host "=================================================" -ForegroundColor DarkGray
Write-Host "                 DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "           Competitive Audio Installer" -ForegroundColor Gray
Write-Host "                 DarcorTweaks" -ForegroundColor DarkGray
Write-Host "=================================================" -ForegroundColor DarkGray
Write-Host ""

}

function Pause-Continue {

Read-Host "Press ENTER to continue"

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

Pause-Continue

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

function InstallAudioEngine {

$tools="$env:TEMP\DGXTools"

if (!(Test-Path $tools)) {
New-Item -ItemType Directory -Path $tools | Out-Null
}

Write-Host "[1/5] Installing VB Cable..." -ForegroundColor Cyan

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


Write-Host "[DGX] Audio Engine installed successfully." -ForegroundColor Green

Pause-Continue

}

function InstallHRIR {

$dest="C:\Program Files\EqualizerAPO\config\HeSuVi\hrir"

New-Item -ItemType Directory $dest -Force | Out-Null

Invoke-WebRequest "https://raw.githubusercontent.com/jaakkopasanen/AutoEq/master/results/Rtings/Razer%20BlackShark%20V2/Razer%20BlackShark%20V2%20ParametricEQ.txt" -OutFile "$dest\EAC_Default.wav"

Write-Host "[DGX] HRIR installed." -ForegroundColor Green

Pause-Continue

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

Pause-Continue

}

function InstallLEQ {

$tools="$env:TEMP\DGXTools"

Write-Host "[DGX] Downloading LEQ Control Panel..." -ForegroundColor Cyan

git clone https://github.com/ArtIsWar/LEQControlPanel.git "$tools\LEQ"

cd "$tools\LEQ"

dotnet build src/LEQControlPanel/LEQControlPanel.csproj -c Release

Write-Host "[DGX] LEQ Control Panel compiled." -ForegroundColor Green

Pause-Continue

}

function CreateShortcuts {

$desktop = [Environment]::GetFolderPath("Desktop")
$root = "$env:USERPROFILE\DGXTune"

$WScriptShell = New-Object -ComObject WScript.Shell

$shortcut = $WScriptShell.CreateShortcut("$desktop\DGXTune.lnk")
$shortcut.TargetPath = $root
$shortcut.Save()

$shortcut2 = $WScriptShell.CreateShortcut("$desktop\Equalizer APO Editor.lnk")
$shortcut2.TargetPath = "C:\Program Files\EqualizerAPO\Editor.exe"
$shortcut2.Save()

Write-Host "[DGX] Desktop shortcuts created." -ForegroundColor Green

Pause-Continue

}

do {

Clear-Host

Banner

Write-Host "1 Fresh Start (remove previous audio tools)"
Write-Host "2 Install DGX Audio Engine"
Write-Host "3 Setup Workspace"
Write-Host "4 Install HRIR"
Write-Host "5 Generate config.txt"
Write-Host "6 Install LEQ Control Panel"
Write-Host "7 Create Desktop Shortcuts"
Write-Host "8 Exit"

Write-Host ""

$choice = Read-Host "Option"

switch ($choice) {

"1" { FreshStart }
"2" { InstallAudioEngine }
"3" { CreateWorkspace }
"4" { InstallHRIR }
"5" { CreateConfig }
"6" { InstallLEQ }
"7" { CreateShortcuts }

}

} while ($choice -ne "8")

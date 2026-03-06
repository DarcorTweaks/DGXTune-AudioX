Clear-Host

Write-Host ""
Write-Host "=================================================" -ForegroundColor DarkGray
Write-Host "                 DGX Tune AudioX" -ForegroundColor Cyan
Write-Host "           Competitive Audio Installer" -ForegroundColor Gray
Write-Host "                 DarcorTweaks" -ForegroundColor DarkGray
Write-Host "=================================================" -ForegroundColor DarkGray
Write-Host ""

$root="$env:USERPROFILE\DGXTune"
$tools="$env:TEMP\DGXTools"

New-Item -ItemType Directory $root -Force | Out-Null
New-Item -ItemType Directory "$root\library" -Force | Out-Null
New-Item -ItemType Directory "$root\library\COD\S0\eq" -Force | Out-Null
New-Item -ItemType Directory "$root\library\BF6\S0\eq" -Force | Out-Null
New-Item -ItemType Directory "$root\library\APEX\S0\eq" -Force | Out-Null

New-Item -ItemType Directory "$root\hrir" -Force | Out-Null
New-Item -ItemType Directory "$root\tools" -Force | Out-Null

New-Item -ItemType Directory $tools -Force | Out-Null

Write-Host "[DGX] Library structure created." -ForegroundColor Green


Write-Host "[1/5] Installing VB Cable..." -ForegroundColor Cyan

Invoke-WebRequest "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" -OutFile "$tools\cable.zip"

Expand-Archive "$tools\cable.zip" "$tools\cable" -Force

Start-Process "$tools\cable\VBCABLE_Setup_x64.exe" -Wait


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


$config="C:\Program Files\EqualizerAPO\config\config.txt"

$content=@"
# PRE HESUVI
Include: DGXTune\library\COD\S0\COD_S0_pre.txt

# DO NOT REMOVE
Include: HeSuVi\hesuvi.txt

Include: DGXTune\library\COD\S0\eq\headphone.txt

# POST
Include: DGXTune\library\COD\S0\COD_S0_post.txt
"@

$content | Out-File $config

Write-Host "[DGX] config.txt generated." -ForegroundColor Green


$desktop=[Environment]::GetFolderPath("Desktop")

$WScriptShell=New-Object -ComObject WScript.Shell

$shortcut=$WScriptShell.CreateShortcut("$desktop\DGXTune.lnk")
$shortcut.TargetPath=$root
$shortcut.Save()

Write-Host "[DGX] Desktop shortcut created." -ForegroundColor Green


Write-Host ""
Write-Host "[DGX] Installation Completed." -ForegroundColor Green
Write-Host "Restart recommended." -ForegroundColor Yellow

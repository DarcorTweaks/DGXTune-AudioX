Write-Host ""
Write-Host "=========================================" -ForegroundColor DarkYellow
Write-Host "        DGX Tune AudioX Engine" -ForegroundColor Cyan
Write-Host "          DarcorTweaks" -ForegroundColor Gray
Write-Host "=========================================" -ForegroundColor DarkYellow
Write-Host ""

$base = "$PSScriptRoot\.."

Write-Host ""
Write-Host "[1/6] Installing VB Cable..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_vbcable.ps1"

Write-Host ""
Write-Host "[2/6] Installing Voicemeeter..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_voicemeeter.ps1"

Write-Host ""
Write-Host "[3/6] Installing Equalizer APO..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_equalizerapo.ps1"

Write-Host ""
Write-Host "[4/6] Installing Peace Equalizer..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_peace.ps1"

Write-Host ""
Write-Host "[5/6] Installing HeSuVi..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_hesuvi.ps1"

Write-Host ""
Write-Host "[6/6] Installing ReaPlugs..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_reaplugs.ps1"

Write-Host ""
Write-Host "Installing HRIR..."
powershell -ExecutionPolicy Bypass -File "$base\core\install_hrir.ps1"

Write-Host ""
Write-Host "Generating Equalizer APO config..."
powershell -ExecutionPolicy Bypass -File "$base\core\generate_config.ps1"

Write-Host ""
Write-Host "Configuring audio devices..."
powershell -ExecutionPolicy Bypass -File "$base\core\device_rename.ps1"

Write-Host ""
Write-Host "=========================================" -ForegroundColor DarkGreen
Write-Host "DGX Audio Engine installed successfully!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor DarkGreen
Write-Host ""

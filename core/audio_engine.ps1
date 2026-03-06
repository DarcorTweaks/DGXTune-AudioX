Write-Host ""
Write-Host "Starting DGX Audio Engine installation..." -ForegroundColor Cyan
Write-Host ""

$base = "$PSScriptRoot\.."

Write-Host "[1/6] Installing VB Cable..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_vbcable.ps1"

Write-Host "[2/6] Installing Voicemeeter..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_voicemeeter.ps1"

Write-Host "[3/6] Installing Equalizer APO..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_equalizerapo.ps1"

Write-Host "[4/6] Installing Peace..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_peace.ps1"

Write-Host "[5/6] Installing HeSuVi..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_hesuvi.ps1"

Write-Host "[6/6] Installing ReaPlugs..."
powershell -ExecutionPolicy Bypass -File "$base\tools\install_reaplugs.ps1"

Write-Host ""
Write-Host "DGX Audio Engine installed successfully." -ForegroundColor Green
Write-Host ""

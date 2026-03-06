Write-Host ""
Write-Host "=========================================" -ForegroundColor DarkGray
Write-Host "         DGX Tune AudioX Engine" -ForegroundColor Cyan
Write-Host "           DarcorTweaks" -ForegroundColor Gray
Write-Host "=========================================" -ForegroundColor DarkGray
Write-Host ""

$base = "$PSScriptRoot\.."

$steps = @(
"VB Cable",
"Voicemeeter",
"Equalizer APO",
"Peace",
"HeSuVi",
"ReaPlugs",
"HRIR",
"Equalizer Config",
"Device Setup"
)

$total = $steps.Count
$i = 0

function StepProgress($name){

$i++
$percent = ($i / $total) * 100

Write-Progress `
-Activity "Installing DGX Audio Engine" `
-Status $name `
-PercentComplete $percent

}

StepProgress "Installing VB Cable"
powershell -ExecutionPolicy Bypass -File "$base\tools\install_vbcable.ps1"

StepProgress "Installing Voicemeeter"
powershell -ExecutionPolicy Bypass -File "$base\tools\install_voicemeeter.ps1"

StepProgress "Installing Equalizer APO"
powershell -ExecutionPolicy Bypass -File "$base\tools\install_equalizerapo.ps1"

StepProgress "Installing Peace"
powershell -ExecutionPolicy Bypass -File "$base\tools\install_peace.ps1"

StepProgress "Installing HeSuVi"
powershell -ExecutionPolicy Bypass -File "$base\tools\install_hesuvi.ps1"

StepProgress "Installing ReaPlugs"
powershell -ExecutionPolicy Bypass -File "$base\tools\install_reaplugs.ps1"

StepProgress "Installing HRIR"
powershell -ExecutionPolicy Bypass -File "$base\core\install_hrir.ps1"

StepProgress "Generating Equalizer Config"
powershell -ExecutionPolicy Bypass -File "$base\core\generate_config.ps1"

StepProgress "Configuring Audio Devices"
powershell -ExecutionPolicy Bypass -File "$base\core\device_rename.ps1"

Write-Progress -Activity "Installing DGX Audio Engine" -Completed

Write-Host ""
Write-Host "=========================================" -ForegroundColor DarkGreen
Write-Host " DGX Audio Engine Installed Successfully" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor DarkGreen
Write-Host ""

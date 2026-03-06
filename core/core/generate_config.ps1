Write-Host ""
Write-Host "Generating Equalizer APO configuration..." -ForegroundColor Cyan
Write-Host ""

$configPath = "C:\Program Files\EqualizerAPO\config\config.txt"

$content = @"

# DGX Tune AudioX Configuration

# PRE HESUVI
Include: DGXTune-AudioX\library\WARZONE\S0\WARZONE_pre.txt

# HESUVI SURROUND
Include: HeSuVi\hesuvi.txt

# HEADPHONE EQ
# Replace with your headset EQ file
# Example: DT990_WARZONE_S0.txt

# POST HESUVI
Include: DGXTune-AudioX\library\WARZONE\S0\WARZONE_post.txt

"@

Set-Content -Path $configPath -Value $content

Write-Host "config.txt created successfully." -ForegroundColor Green
Write-Host ""

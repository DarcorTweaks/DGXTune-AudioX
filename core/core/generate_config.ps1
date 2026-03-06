Write-Host ""
Write-Host "Generating Equalizer APO config..." -ForegroundColor Cyan

$config = "C:\Program Files\EqualizerAPO\config\config.txt"

$content = @"
# DGX Tune AudioX Configuration

Include: HeSuVi\hesuvi.txt

"@

Set-Content $config $content

Write-Host "config.txt generated." -ForegroundColor Green

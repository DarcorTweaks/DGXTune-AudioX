Write-Host ""
Write-Host "=========================================" -ForegroundColor DarkYellow
Write-Host "         DGX Fresh Audio Cleanup" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor DarkYellow
Write-Host ""

$apps = @(
"Voicemeeter",
"Equalizer APO",
"HeSuVi",
"Peace",
"ReaPlugs"
)

foreach ($app in $apps) {

Write-Host "Checking for $app..."

$installed = Get-WmiObject Win32_Product | Where-Object {$_.Name -like "*$app*"}

if ($installed) {

Write-Host "Removing $app..." -ForegroundColor Yellow
$installed.Uninstall()

} else {

Write-Host "$app not found."

}

}

Write-Host ""
Write-Host "Cleanup finished." -ForegroundColor Green
Write-Host ""

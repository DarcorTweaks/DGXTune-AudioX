Write-Host ""
Write-Host "Running DGX audio cleanup..." -ForegroundColor Yellow
Write-Host ""

$programs = @(
"Voicemeeter",
"Equalizer APO",
"HeSuVi",
"Peace",
"ReaPlugs"
)

foreach ($program in $programs) {

Write-Host "Checking for $program..."

$found = Get-WmiObject Win32_Product | Where-Object { $_.Name -like "*$program*" }

if ($found) {

Write-Host "Removing $program..." -ForegroundColor Red
$found.Uninstall()

} else {

Write-Host "$program not found."

}

}

Write-Host ""
Write-Host "Cleanup finished." -ForegroundColor Green
Write-Host ""

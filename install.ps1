Clear-Host

Write-Host ""
Write-Host "DGX Tune AudioX Installer" -ForegroundColor Cyan
Write-Host "Downloading components..." -ForegroundColor Gray
Write-Host ""

$repo = "https://github.com/DarcorTweaks/DGXTune-AudioX/archive/refs/heads/main.zip"

$temp = "$env:TEMP\DGXTune"
$zip = "$temp\DGXTune.zip"

if(Test-Path $temp){

Remove-Item $temp -Recurse -Force

}

New-Item -ItemType Directory $temp | Out-Null

Invoke-WebRequest $repo -OutFile $zip

Expand-Archive $zip $temp -Force

$folder = Get-ChildItem $temp | Where-Object {$_.Name -like "DGXTune-AudioX*"} | Select-Object -First 1

$path = "$temp\$($folder.Name)"

Write-Host "Starting installer..." -ForegroundColor Green

Start-Process powershell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$path\DGXInstaller.ps1`""

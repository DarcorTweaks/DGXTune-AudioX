Write-Host ""
Write-Host "Installing ReaPlugs..." -ForegroundColor Cyan

$installer = "$PSScriptRoot\..\installers\reaplugs236_x64-install.exe"

if(Test-Path $installer){

Start-Process $installer -Verb RunAs -Wait

Write-Host "ReaPlugs installation finished." -ForegroundColor Green

}else{

Write-Host "ReaPlugs installer not found." -ForegroundColor Red

}

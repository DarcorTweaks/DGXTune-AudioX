Write-Host ""
Write-Host "Installing Peace Equalizer..." -ForegroundColor Cyan

$installer = "$PSScriptRoot\..\installers\PeaceSetup.exe"

if(Test-Path $installer){

Start-Process $installer -Verb RunAs -Wait

Write-Host "Peace installation finished." -ForegroundColor Green

}else{

Write-Host "Peace installer not found." -ForegroundColor Red

}

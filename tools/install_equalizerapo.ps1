Write-Host ""
Write-Host "Installing Equalizer APO..." -ForegroundColor Cyan

$installer = "$PSScriptRoot\..\installers\EqualizerAPO64-1.4.exe"

if(Test-Path $installer){

Start-Process $installer -Verb RunAs -Wait

Write-Host "Equalizer APO installation finished." -ForegroundColor Green

}else{

Write-Host "Equalizer APO installer not found." -ForegroundColor Red

}

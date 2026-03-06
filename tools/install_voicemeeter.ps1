Write-Host ""
Write-Host "Installing Voicemeeter..." -ForegroundColor Cyan

$installer = "$PSScriptRoot\..\installers\voicemeetersetup.exe"

if(Test-Path $installer){

Start-Process $installer -Verb RunAs -Wait

Write-Host "Voicemeeter installation finished." -ForegroundColor Green

}else{

Write-Host "Voicemeeter installer not found." -ForegroundColor Red

}

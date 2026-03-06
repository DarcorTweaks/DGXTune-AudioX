Write-Host ""
Write-Host "Installing Hi-Fi Cable..." -ForegroundColor Cyan

$installer = "$PSScriptRoot\..\installers\HiFiCableAsioBridgeSetup.exe"

if(Test-Path $installer){

Start-Process $installer -Verb RunAs -Wait

Write-Host "Hi-Fi Cable installation finished." -ForegroundColor Green

}else{

Write-Host "Hi-Fi Cable installer not found." -ForegroundColor Red

}

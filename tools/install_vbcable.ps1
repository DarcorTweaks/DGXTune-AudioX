Write-Host ""
Write-Host "Installing VB Cable..." -ForegroundColor Cyan

$installer = "$PSScriptRoot\..\installers\VBCABLE_Setup.exe"

if(Test-Path $installer){

Start-Process $installer -Verb RunAs -Wait

Write-Host "VB Cable installation finished." -ForegroundColor Green

}else{

Write-Host "VB Cable installer not found." -ForegroundColor Red

}

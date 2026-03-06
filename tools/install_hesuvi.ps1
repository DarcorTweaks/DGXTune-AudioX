Write-Host ""
Write-Host "Installing HeSuVi..." -ForegroundColor Cyan

$installer = "$PSScriptRoot\..\installers\HeSuVi_2.0.0.1.exe"

if(Test-Path $installer){

Start-Process $installer -Verb RunAs -Wait

Write-Host "HeSuVi installation finished." -ForegroundColor Green

}else{

Write-Host "HeSuVi installer not found." -ForegroundColor Red

}

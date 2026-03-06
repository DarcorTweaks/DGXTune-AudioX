Write-Host ""
Write-Host "Installing HRIR..." -ForegroundColor Cyan

$src = "$PSScriptRoot\..\hrir\EAC_Default.wav"
$dst = "C:\Program Files\EqualizerAPO\config\HeSuVi\hrir\EAC_Default.wav"

if(Test-Path $src){

Copy-Item $src $dst -Force

Write-Host "HRIR installed successfully." -ForegroundColor Green

}else{

Write-Host "HRIR file missing." -ForegroundColor Red

}

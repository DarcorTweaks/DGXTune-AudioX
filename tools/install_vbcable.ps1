Write-Host ""
Write-Host "Installing VB Cable..." -ForegroundColor Cyan

$tools = "$env:TEMP\DGXTools"

New-Item -ItemType Directory $tools -Force | Out-Null

$url = "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip"

$zip = "$tools\vbcable.zip"

Invoke-WebRequest $url -OutFile $zip

Expand-Archive $zip "$tools\vbcable" -Force

Start-Process "$tools\vbcable\VBCABLE_Setup_x64.exe" -Wait

Write-Host "VB Cable installation finished." -ForegroundColor Green

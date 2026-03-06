Write-Host ""
Write-Host "========================================="
Write-Host "         DGX Tune AudioX Engine"
Write-Host "           DarcorTweaks"
Write-Host "========================================="
Write-Host ""

$base = Split-Path -Parent $MyInvocation.MyCommand.Path
$tools = "$base\..\tools"

function RunTool($script){

    $path = "$tools\$script"

    if(Test-Path $path){

        powershell -ExecutionPolicy Bypass -File $path

    }else{

        Write-Host "$script not found." -ForegroundColor Red

    }

}

function RunCore($script){

    $path = "$base\$script"

    if(Test-Path $path){

        powershell -ExecutionPolicy Bypass -File $path

    }else{

        Write-Host "$script not found." -ForegroundColor Red

    }

}

Write-Host ""
Write-Host "Installing VB Cable..." -ForegroundColor Cyan
RunTool "install_vbcable.ps1"

Write-Host ""
Write-Host "Installing Voicemeeter..." -ForegroundColor Cyan
RunTool "install_voicemeeter.ps1"

Write-Host ""
Write-Host "Installing Equalizer APO..." -ForegroundColor Cyan
RunTool "install_equalizerapo.ps1"

Write-Host ""
Write-Host "Installing Peace Equalizer..." -ForegroundColor Cyan
RunTool "install_peace.ps1"

Write-Host ""
Write-Host "Installing HeSuVi..." -ForegroundColor Cyan
RunTool "install_hesuvi.ps1"

Write-Host ""
Write-Host "Installing ReaPlugs..." -ForegroundColor Cyan
RunTool "install_reaplugs.ps1"

Write-Host ""
Write-Host "Installing HRIR..." -ForegroundColor Cyan
RunCore "install_hrir.ps1"

Write-Host ""
Write-Host "Generating Equalizer APO config..." -ForegroundColor Cyan
RunCore "generate_config.ps1"

Write-Host ""
Write-Host "Configuring DGX audio device names..." -ForegroundColor Cyan
RunCore "device_rename.ps1"

Write-Host ""
Write-Host ""
Write-Host "========================================="
Write-Host " DGX Audio Engine Installed Successfully"
Write-Host "========================================="
Write-Host ""

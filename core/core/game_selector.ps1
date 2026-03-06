Write-Host ""
Write-Host "=========================================" -ForegroundColor DarkGray
Write-Host "           DGX Game Selector" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor DarkGray
Write-Host ""

Write-Host "[1] Warzone"
Write-Host "[2] Apex"
Write-Host "[3] Valorant"
Write-Host "[4] CS2"
Write-Host ""

$choice = Read-Host "Select Game"

switch ($choice){

"1" { $game="WARZONE" }
"2" { $game="APEX" }
"3" { $game="VALORANT" }
"4" { $game="CS2" }

default {

Write-Host "Invalid selection"
exit

}

}

$config = "C:\Program Files\EqualizerAPO\config\config.txt"

$content = @"

# DGX Tune AudioX

# PRE
Include: DGXTune-AudioX\library\$game\S0\${game}_pre.txt

# HESUVI
Include: HeSuVi\hesuvi.txt

# POST
Include: DGXTune-AudioX\library\$game\S0\${game}_post.txt

"@

Set-Content $config $content

Write-Host ""
Write-Host "$game preset activated." -ForegroundColor Green
Write-Host ""

Write-Host ""
Write-Host "=========================================" -ForegroundColor DarkGray
Write-Host "           DGX Game Selector" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor DarkGray
Write-Host ""

$games = @(
"Warzone",
"Apex",
"Valorant",
"CS2"
)

Write-Host "Select Game Preset"
Write-Host ""

for ($i=0; $i -lt $games.Count; $i++){

Write-Host "[$($i+1)] $($games[$i])"

}

Write-Host ""

$choice = Read-Host "Option"

switch ($choice){

"1" { $game = "WARZONE" }
"2" { $game = "APEX" }
"3" { $game = "VALORANT" }
"4" { $game = "CS2" }

default {

Write-Host "Invalid option"
exit

}

}

$configPath = "C:\Program Files\EqualizerAPO\config\config.txt"

$content = @"

# DGX Tune AudioX

# PRE HESUVI
Include: DGXTune-AudioX\library\$game\S0\${game}_pre.txt

# HESUVI
Include: HeSuVi\hesuvi.txt

# POST
Include: DGXTune-AudioX\library\$game\S0\${game}_post.txt

"@

Set-Content -Path $configPath -Value $content

Write-Host ""
Write-Host "$game preset activated." -ForegroundColor Green
Write-Host ""

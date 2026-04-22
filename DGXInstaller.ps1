# ====================================================================
# DGX TUNE AUDIOX - CORE INSTALLER & AIO LEQ INTEGRATION
# ====================================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 1. Detectar rutas
$coreDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $coreDir
$installersPath = "$repoRoot\installers"
$toolsPath = "$repoRoot\tools"

# Archivos
$fileAPO = "EqualizerAPO.exe"
$fileVM = "VoicemeeterSetup.exe"
$fileCable = "VBCableSetup_x64.exe"
$filePeace = "Peace.exe"
$leqPanelScript = "$toolsPath\DGX_LEQ_Panel.ps1"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " INICIANDO INSTALACIÓN DEL MOTOR DGX AUDIOX..." -ForegroundColor White
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

# Crear carpetas si no existen
if (!(Test-Path $installersPath)) { New-Item -ItemType Directory -Path $installersPath | Out-Null }
if (!(Test-Path $toolsPath)) { New-Item -ItemType Directory -Path $toolsPath | Out-Null }

# Función de instalación
function Install-DGXApp ($FileName, $SilentArgs, $IsExecutable) {
    $localFilePath = "$installersPath\$FileName"
    if (!(Test-Path $localFilePath)) {
        Write-Host "      [!] Descargando $FileName..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/installers/$FileName" -OutFile $localFilePath
    }
    if ($IsExecutable) {
        Write-Host "      -> Instalando $FileName..." -ForegroundColor Gray
        Start-Process -FilePath $localFilePath -ArgumentList $SilentArgs -Wait -NoNewWindow
        Write-Host "      [OK] $FileName instalado." -ForegroundColor Green
    }
}

# ==========================================
# FASE 1: INSTALACIÓN BASE
# ==========================================
Write-Host "[1/5] Preparando Equalizer APO..." -ForegroundColor Yellow
Install-DGXApp -FileName $fileAPO -SilentArgs "/S" -IsExecutable $true

Write-Host ""
Write-Host "[2/5] Preparando Voicemeeter..." -ForegroundColor Yellow
Install-DGXApp -FileName $fileVM -SilentArgs "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART" -IsExecutable $true

Write-Host ""
Write-Host "[3/5] Preparando VB-Cable..." -ForegroundColor Yellow
Install-DGXApp -FileName $fileCable -SilentArgs "-i -h" -IsExecutable $true

Write-Host ""
Write-Host "[4/5] Copiando Peace GUI..." -ForegroundColor Yellow
Install-DGXApp -FileName $filePeace -SilentArgs "" -IsExecutable $false
$apoConfigPath = "C:\Program Files\EqualizerAPO\config"
if (Test-Path $apoConfigPath) {
    Copy-Item -Path "$installersPath\$filePeace" -Destination "$apoConfigPath\Peace.exe" -Force
}

# ==========================================
# FASE 2: CREACIÓN AUTOMÁTICA DEL PANEL LEQ
# ==========================================
Write-Host ""
Write-Host "[5/5] Generando Interfaz Gráfica (LEQ Control Panel)..." -ForegroundColor DarkOrange

# Aquí guardamos TODO el código de la ventanita naranja dentro del instalador
$panelCode = @'
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "DGXTune - LEQ Control Panel"
$form.Size = New-Object System.Drawing.Size(420, 260)
$form.BackColor = [System.Drawing.Color]::FromArgb(255, 25, 25, 25)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$title = New-Object System.Windows.Forms.Label
$title.Text = "DGX AUDIO: LEQ ENGINE"
$title.ForeColor = [System.Drawing.Color]::DarkOrange
$title.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(80, 20)
$form.Controls.Add($title)

$sliderLabel = New-Object System.Windows.Forms.Label
$sliderLabel.Text = "Release Time: 2 (COMPETITIVO)"
$sliderLabel.ForeColor = [System.Drawing.Color]::DarkOrange
$sliderLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$sliderLabel.AutoSize = $true
$sliderLabel.Location = New-Object System.Drawing.Point(100, 70)
$form.Controls.Add($sliderLabel)

$slider = New-Object System.Windows.Forms.TrackBar
$slider.Minimum = 1
$slider.Maximum = 7
$slider.Value = 2
$slider.TickStyle = "BottomRight"
$slider.Location = New-Object System.Drawing.Point(50, 100)
$slider.Size = New-Object System.Drawing.Size(300, 45)

$slider.add_Scroll({
    if ($slider.Value -eq 2) {
        $sliderLabel.Text = "Release Time: $($slider.Value) (COMPETITIVO)"
        $sliderLabel.ForeColor = [System.Drawing.Color]::DarkOrange
    } else {
        $sliderLabel.Text = "Release Time: $($slider.Value) (ESTÁNDAR)"
        $sliderLabel.ForeColor = [System.Drawing.Color]::White
    }
})
$form.Controls.Add($slider)

$btnApply = New-Object System.Windows.Forms.Button
$btnApply.Text = "ACTIVAR COMPRESIÓN"
$btnApply.BackColor = [System.Drawing.Color]::DarkOrange
$btnApply.ForeColor = [System.Drawing.Color]::Black
$btnApply.FlatStyle = "Flat"
$btnApply.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$btnApply.Size = New-Object System.Drawing.Size(300, 45)
$btnApply.Location = New-Object System.Drawing.Point(50, 150)

$btnApply.add_Click({
    $val = $slider.Value
    [System.Windows.Forms.MessageBox]::Show("Optimizando audio...", "DGXTune", 0, [System.Windows.Forms.MessageBoxIcon]::Information)
    
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $leqScript = "$scriptDir\EnableLoudness.ps1" # Apunta al script de Falcosc en la misma carpeta
    
    if (Test-Path $leqScript) {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        . $leqScript -releaseTime $val
    } else {
        [System.Windows.Forms.MessageBox]::Show("Falta EnableLoudness.ps1 en la carpeta tools.", "Error", 0, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})
$form.Controls.Add($btnApply)

[void]$form.ShowDialog()
'@

# Escribimos el código de la interfaz en un archivo físico dentro de \tools
Set-Content -Path $leqPanelScript -Value $panelCode -Encoding UTF8
Write-Host "      [OK] Código de interfaz gráfica inyectado." -ForegroundColor Green

# Crear Acceso Directo en el Escritorio
$WshShell = New-Object -comObject WScript.Shell
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$Shortcut = $WshShell.CreateShortcut("$DesktopPath\DGX LEQ Panel.lnk")
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$leqPanelScript`""
$Shortcut.Description = "DGXTune - Control de Pasos Warzone"
$Shortcut.IconLocation = "powershell.exe,0"
$Shortcut.Save()
Write-Host "      [OK] Acceso directo creado en el escritorio." -ForegroundColor Green

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " INSTALACIÓN COMPLETADA EXITOSAMENTE." -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

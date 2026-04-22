# ====================================================================
# DGX TUNE AUDIOX - CORE INSTALLER & AIO LEQ INTEGRATION
# ====================================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 1. Detectar rutas dinámicas
$coreDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $coreDir
$installersPath = "$repoRoot\installers"
$toolsPath = "$repoRoot\tools"

# Nombres de archivos
$fileAPO = "EqualizerAPO.exe"
$fileVM = "VoicemeeterSetup.exe"
$fileCable = "VBCableSetup_x64.exe"
$filePeace = "Peace.exe"
$leqPanelScript = "$toolsPath\DGX_LEQ_Panel.ps1"
$falcoscScript = "$toolsPath\EnableLoudness.ps1"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " INICIANDO INSTALACIÓN DEL MOTOR DGX AUDIOX..." -ForegroundColor White
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

# Crear carpetas locales si no existen
if (!(Test-Path $installersPath)) { New-Item -ItemType Directory -Path $installersPath | Out-Null }
if (!(Test-Path $toolsPath)) { New-Item -ItemType Directory -Path $toolsPath | Out-Null }

# Función maestra de descarga e instalación
function Install-DGXApp ($FileName, $SilentArgs, $IsExecutable) {
    $localFilePath = "$installersPath\$FileName"
    if (!(Test-Path $localFilePath)) {
        Write-Host "      [!] Descargando $FileName desde GitHub..." -ForegroundColor Yellow
        # URL apuntando a tu repositorio
        $url = "https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/installers/$FileName"
        try {
            Invoke-WebRequest -Uri $url -OutFile $localFilePath -ErrorAction Stop
        } catch {
            Write-Host "      [ERROR] No se pudo descargar $FileName. Revisa que esté subido en GitHub." -ForegroundColor Red
            return
        }
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
Write-Host "[1/6] Preparando Equalizer APO..." -ForegroundColor Yellow
Install-DGXApp -FileName $fileAPO -SilentArgs "/S" -IsExecutable $true
Write-Host ""

Write-Host "[2/6] Preparando Voicemeeter..." -ForegroundColor Yellow
Install-DGXApp -FileName $fileVM -SilentArgs "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART" -IsExecutable $true
Write-Host ""

Write-Host "[3/6] Preparando VB-Cable..." -ForegroundColor Yellow
Install-DGXApp -FileName $fileCable -SilentArgs "-i -h" -IsExecutable $true
Write-Host ""

Write-Host "[4/6] Copiando Peace GUI..." -ForegroundColor Yellow
Install-DGXApp -FileName $filePeace -SilentArgs "" -IsExecutable $false
$apoConfigPath = "C:\Program Files\EqualizerAPO\config"
if (Test-Path $apoConfigPath) {
    Copy-Item -Path "$installersPath\$filePeace" -Destination "$apoConfigPath\Peace.exe" -Force
    Write-Host "      [OK] Peace copiado al directorio raíz." -ForegroundColor Green
}
Write-Host ""

# ==========================================
# FASE 2: PREPARACIÓN DEL MOTOR LEQ
# ==========================================
Write-Host "[5/6] Descargando el Motor LEQ (EnableLoudness)..." -ForegroundColor Yellow
if (!(Test-Path $falcoscScript)) {
    # Aquí puedes usar tu propio enlace si subes el script de Falcosc a tu carpeta tools en GitHub
    $urlLEQ = "https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/tools/EnableLoudness.ps1"
    try {
        Invoke-WebRequest -Uri $urlLEQ -OutFile $falcoscScript -ErrorAction Stop
        Write-Host "      [OK] Motor LEQ descargado con éxito." -ForegroundColor Green
    } catch {
        Write-Host "      [!] Usando servidor de respaldo para el motor LEQ..." -ForegroundColor Yellow
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Falcosc/enable-loudness-equalisation/main/EnableLoudness.ps1" -OutFile $falcoscScript
        Write-Host "      [OK] Motor LEQ obtenido del servidor alterno." -ForegroundColor Green
    }
} else {
    Write-Host "      [OK] Motor LEQ ya existe localmente." -ForegroundColor Green
}

# ==========================================
# FASE 3: CREACIÓN AUTOMÁTICA DEL PANEL LEQ
# ==========================================
Write-Host ""
Write-Host "[6/6] Generando Interfaz Gráfica (LEQ Control Panel)..." -ForegroundColor DarkOrange

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
    [System.Windows.Forms.MessageBox]::Show("Optimizando audio... El proceso tomara unos segundos.", "DGXTune", 0, [System.Windows.Forms.MessageBoxIcon]::Information)
    
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $leqScript = "$scriptDir\EnableLoudness.ps1"
    
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

Set-Content -Path $leqPanelScript -Value $panelCode -Encoding UTF8
Write-Host "      [OK] Código de interfaz gráfica inyectado." -ForegroundColor Green

# Acceso Directo limpio sin consola negra
$WshShell = New-Object -comObject WScript.Shell
$DesktopPath = [Environment]::GetFolderPath("Desktop")
$Shortcut = $WshShell.CreateShortcut("$DesktopPath\DGX LEQ Panel.lnk")
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$leqPanelScript`""
$Shortcut.Description = "DGXTune - Control de Pasos"
$Shortcut.IconLocation = "powershell.exe,0"
$Shortcut.Save()
Write-Host "      [OK] Acceso directo creado en el escritorio." -ForegroundColor Green

Write-Host ""
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host " INSTALACIÓN COMPLETADA EXITOSAMENTE." -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
Write-Host ""

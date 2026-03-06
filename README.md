# DGX Tune AudioX

Competitive audio setup for PC gaming.

DGX Tune AudioX installs and configures a full competitive audio stack for Windows automatically.

Developed by **DarcorTweaks**.

---

# Features

Automatic installation of:

- VB Cable
- Voicemeeter
- Equalizer APO
- Peace Equalizer
- HeSuVi
- ReaPlugs

Automatic configuration:

- audio engine setup
- device detection
- audio routing
- competitive audio stack

---

# Requirements

Windows 10 or Windows 11  
PowerShell 5.1 or newer  
Administrator privileges  
Internet connection

---

# Installation

Open **PowerShell as Administrator** and run:

```powershell
irm https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/install.ps1 | iex
```

The installer will automatically download and install all required audio tools.

---

# What the installer does

The installer performs the following steps:

1. Cleans previous audio tool installations
2. Installs VB Cable
3. Installs Voicemeeter
4. Installs Equalizer APO
5. Installs Peace Equalizer
6. Installs HeSuVi
7. Installs ReaPlugs
8. Configures the DGX Audio Engine

---

# Repository Structure

```
DGXTune-AudioX
│
├ install.ps1
├ DGXInstaller.ps1
│
├ core
│   ├ audio_engine.ps1
│   ├ audio_cleanup.ps1
│   └ device_rename.ps1
│
├ tools
│   ├ install_vbcable.ps1
│   ├ install_voicemeeter.ps1
│   ├ install_equalizerapo.ps1
│   ├ install_peace.ps1
│   ├ install_hesuvi.ps1
│   └ install_reaplugs.ps1
│
├ library
│
└ hrir
```

---

# Audio Stack

DGX Tune AudioX installs the following competitive audio stack:

VB Cable → Virtual audio routing  
Voicemeeter → Audio mixer  
Equalizer APO → Audio processing engine  
Peace → EQ interface  
HeSuVi → Surround virtualization  
ReaPlugs → Compression / limiter processing

---

# License

This project is provided for educational and personal use.

Third-party software belongs to their respective developers.

---

# Author

DarcorTweaks

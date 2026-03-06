# DGX Tune AudioX

Competitive audio optimization toolkit for FPS gaming.

DGX Tune AudioX installs and configures a professional audio processing stack for games like:

* Call of Duty / Warzone
* Battlefield
* Apex Legends
* Valorant

The system uses:

* Equalizer APO
* HeSuVi
* ReaPlugs
* Voicemeeter
* VB-Audio Hi-Fi Cable
* LEQ Control Panel

to create a competitive audio chain optimized for footsteps and positional awareness.

---

## Requirements

* Windows 10 or Windows 11 (x64)
* PowerShell 5.1+
* Administrator privileges
* Internet connection

---

## Installation

Open **PowerShell as Administrator** and run:

```
irm https://raw.githubusercontent.com/DarcorTweaks/DGXTune-AudioX/main/install.ps1 | iex
```

This launches the DGX Tune AudioX installer.

---

## Installer Options

The installer provides the following options:

### Fresh Start

Removes previously installed audio tools to avoid conflicts.

### Install Audio Engine

Installs the full DGX audio stack:

* VB-Audio Hi-Fi Cable
* Voicemeeter
* Equalizer APO
* HeSuVi
* ReaPlugs

### Install LEQ Control Panel

Downloads and compiles the LEQ Control Panel from source.

### Diagnostics

Lists detected audio devices for troubleshooting.

---

## Audio Stack

```
Game
 ↓
Hi-Fi Cable
 ↓
Voicemeeter
 ↓
Equalizer APO
 ↓
HeSuVi
 ↓
ReaPlugs (compression / EQ / limiter)
 ↓
Headphones
```

---

## LEQ Control Panel

DGX Tune AudioX integrates the **LEQ Control Panel** which allows:

* Toggle Loudness Equalization instantly
* Adjust release time
* Manage audio devices
* Monitor device changes
* Perform registry health checks

Source:

https://github.com/ArtIsWar/LEQControlPanel

---

## Credits

Inspired by the work of:

ArtIsWar
Falcosc Loudness EQ project

---

## License

Scripts: GPL-3.0

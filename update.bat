@echo off
setlocal enabledelayedexpansion

if not defined INST_JAVA set "INST_JAVA=java"

set "TARGET_DIR="
if defined INST_MC_DIR if exist "%INST_MC_DIR%" set "TARGET_DIR=%INST_MC_DIR%"
if not defined TARGET_DIR if exist "%~dp0minecraft" set "TARGET_DIR=%~dp0minecraft"
if not defined TARGET_DIR set "TARGET_DIR=%~dp0"

cd /d "!TARGET_DIR!"

if not exist "packwiz-installer-bootstrap.jar" (
    echo [PionPack] Downloading packwiz-installer-bootstrap.jar...
    curl.exe -fL -s -S -o "packwiz-installer-bootstrap.jar" "https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v0.0.3/packwiz-installer-bootstrap.jar" 2>nul
    if not exist "packwiz-installer-bootstrap.jar" (
        powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v0.0.3/packwiz-installer-bootstrap.jar', 'packwiz-installer-bootstrap.jar')"
    )
)

if not exist "packwiz-installer.jar" (
    echo [PionPack] Downloading packwiz-installer.jar...
    curl.exe -fL -s -S -o "packwiz-installer.jar" "https://github.com/packwiz/packwiz-installer/releases/download/v0.5.14/packwiz-installer.jar" 2>nul
    if not exist "packwiz-installer.jar" (
        powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object Net.WebClient).DownloadFile('https://github.com/packwiz/packwiz-installer/releases/download/v0.5.14/packwiz-installer.jar', 'packwiz-installer.jar')"
    )
)

"!INST_JAVA!" -jar "packwiz-installer-bootstrap.jar" --bootstrap-main-jar "packwiz-installer.jar" --bootstrap-no-update -g https://raw.githubusercontent.com/Orstedra/PionPack/main/pack.toml

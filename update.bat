@echo off
setlocal

if not defined INST_JAVA set "INST_JAVA=java"
if not defined INST_MC_DIR set "INST_MC_DIR=%~dp0minecraft"
if not defined INST_DIR set "INST_DIR=%~dp0"

cd /d "%INST_MC_DIR%"

if not exist "packwiz-installer-bootstrap.jar" (
    echo Downloading packwiz-installer-bootstrap.jar...
    powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v0.0.3/packwiz-installer-bootstrap.jar' -OutFile 'packwiz-installer-bootstrap.jar'"
)

"%INST_JAVA%" -jar packwiz-installer-bootstrap.jar --bootstrap-no-update https://raw.githubusercontent.com/Orstedra/PionPack/main/pack.toml

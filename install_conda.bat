@echo off
setlocal enabledelayedexpansion

echo Miniconda not found
echo Downloading and installing...

:: Tải Miniconda về
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile 'MinicondaInstaller.exe'}"
if %errorlevel% neq 0 echo Error downloading Miniconda & echo Exiting & exit /b 1

:: Cài đặt Miniconda
start /wait MinicondaInstaller.exe /InstallationType=JustMe /AddToPath=1 /RegisterPython=0 /S
if %errorlevel% neq 0 echo Error installing Miniconda & echo Exiting & exit /b 1

del MinicondaInstaller.exe
echo Miniconda installed successfully.
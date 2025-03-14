@echo off
setlocal enabledelayedexpansion

:: Đặt tên môi trường
set CONDA_INSTALL_PATH=%USERPROFILE%\miniconda3


:: Tải Miniconda về
echo Downloading and installing...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile 'MinicondaInstaller.exe'}"
if %errorlevel% neq 0 echo Error downloading Miniconda. Exiting. & exit /b 1

:: Cài đặt Miniconda
start /wait MinicondaInstaller.exe /InstallationType=JustMe /AddToPath=1 /RegisterPython=0 /S
if %errorlevel% neq 0 echo Error installing Miniconda. Exiting. & exit /b 1

:: Cập nhật PATH tạm thời
set PATH=%CONDA_INSTALL_PATH%\Scripts;%CONDA_INSTALL_PATH%\Library\bin;%PATH%

:: Initialize conda
call conda init cmd.exe

:: Xóa file cài đặt
del MinicondaInstaller.exe
echo Miniconda installed successfully.
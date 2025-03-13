@echo off
setlocal enabledelayedexpansion

:: Đặt tên môi trường
set ENV_NAME=mttn
set CONDA_INSTALL_PATH=%USERPROFILE%\miniconda3

:: Kiểm tra xem Conda đã được cài đặt chưa
where conda >nul 2>nul
if %errorlevel% neq 0 (
    echo Miniconda not found. Downloading and installing...
    
    :: Tải Miniconda về
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile 'MinicondaInstaller.exe'}"
    if %errorlevel% neq 0 (
        echo Error downloading Miniconda. Exiting.
        exit /b 1
    )

    :: Cài đặt Miniconda
    start /wait MinicondaInstaller.exe /InstallationType=JustMe /AddToPath=1 /RegisterPython=0 /S
    if %errorlevel% neq 0 (
        echo Error installing Miniconda. Exiting.
        exit /b 1
    )
    del MinicondaInstaller.exe
    echo Miniconda installed successfully.

    :: Cập nhật PATH tạm thời
    set PATH=%CONDA_INSTALL_PATH%\Scripts;%CONDA_INSTALL_PATH%\Library\bin;%PATH%

    if %errorlevel% neq 0 (
        echo Error activating Conda. Exiting.
        exit /b 1
    )
) else (
    echo Miniconda is already installed.
)

:: Kiểm tra xem môi trường đã tồn tại chưa
conda env list | findstr /C:"%ENV_NAME%" >nul
if %errorlevel% neq 0 (
    echo Creating new Conda environment '%ENV_NAME%' with Python 3.10...
    conda create -n %ENV_NAME% python=3.10 -y
    if %errorlevel% neq 0 (
        echo Error creating Conda environment. Exiting.
        echo %errorlevel%
    )
) else (
    echo Conda environment '%ENV_NAME%' already exists.
)
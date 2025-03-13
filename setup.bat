@echo off
setlocal enabledelayedexpansion

:: Kiểm tra Miniconda đã cài chưa
where conda >nul 2>nul
if %errorlevel% neq 0 (
    echo Miniconda not found. Downloading and installing...
    
    :: Tải Miniconda installer
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile 'MinicondaInstaller.exe'}"
    
    :: Cài đặt Miniconda (yên lặng, tự động thêm vào PATH)
    start /wait MinicondaInstaller.exe /InstallationType=JustMe /AddToPath=1 /RegisterPython=0 /S
    del MinicondaInstaller.exe
    echo Miniconda installed successfully.
    
    :: Load lại biến môi trường
    set PATH=%USERPROFILE%\miniconda3\Scripts;%USERPROFILE%\miniconda3\Library\bin;%PATH%
) else (
    echo Miniconda is already installed.
)

:: Kiểm tra lại conda đã hoạt động chưa
where conda >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Conda installation failed.
    exit /b 1
)

:: Cập nhật Conda
echo Updating Conda...
conda update -n base -c defaults conda -y

:: Tạo môi trường Python 3.10 nếu chưa có
conda info --envs | findstr /C:"mttn" >nul
if %errorlevel% neq 0 (
    echo Creating new Conda environment 'mttn' with Python 3.10...
    conda create -n mttn python=3.10 -y
) else (
    echo Conda environment 'mttn' already exists.
)

:: Kích hoạt môi trường
echo Activating environment 'mttn'...
call conda activate mttn

:: Cài đặt thư viện học máy
echo Installing machine learning libraries...
conda install numpy pandas matplotlib scikit-learn pytorch torchvision torchaudio cpuonly tensorflow -c pytorch -c conda-forge -y

echo Setup complete! To activate the environment, use:
echo conda activate mttn

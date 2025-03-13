@echo off
setlocal enabledelayedexpansion

:: Kiểm tra Miniconda đã cài chưa
where conda >nul 2>nul
if %errorlevel% neq 0 (
    echo Miniconda not found. Downloading and installing...

    :: Tải Miniconda installer
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe' -OutFile 'MinicondaInstaller.exe'}"
    if %errorlevel% neq 0 (
        echo Error downloading Miniconda. Exiting.
        exit /b 1
    )

    :: Cài đặt Miniconda (yên lặng, tự động thêm vào PATH)
    start /wait MinicondaInstaller.exe /InstallationType=JustMe /AddToPath=1 /RegisterPython=0 /S
    if %errorlevel% neq 0 (
        echo Error installing Miniconda. Exiting.
        exit /b 1
    )
    del MinicondaInstaller.exe
    echo Miniconda installed successfully.

    :: Load lại biến môi trường
    set PATH=%USERPROFILE%\miniconda3\Scripts;%USERPROFILE%\miniconda3\Library\bin;%PATH%
    :: Load Conda vào CMD (đặc biệt quan trọng trên Windows)
    call "%USERPROFILE%\miniconda3\Scripts\activate.bat"
    if %errorlevel% neq 0 (
        echo Error activating Miniconda. Exiting.
        exit /b 1
    )
) else (
    echo Miniconda is already installed.
)

:: Cập nhật Conda
echo Updating Conda...
conda update -n base -c defaults conda -y
if %errorlevel% neq 0 (
    echo Error updating Conda. Continuing.
)

:: Kiểm tra xem môi trường "mttn" đã tồn tại chưa bằng lệnh chính xác hơn
conda env list | findstr /R "\bmttn\b" >nul
if %errorlevel% neq 0 (
    echo Creating new Conda environment 'mttn' with Python 3.10...
    conda create -n mttn python=3.10 -y
    if %errorlevel% neq 0 (
        echo Error creating Conda environment. Exiting.
        exit /b 1
    )
) else (
    echo Conda environment 'mttn' already exists.
)

:: Kích hoạt môi trường
echo Activating environment 'mttn'...
call conda activate mttn
if %errorlevel% neq 0 (
    echo Error activating environment. Exiting.
    exit /b 1
)

:: Cài đặt thư viện học máy
echo Installing machine learning libraries...
conda install numpy pandas matplotlib scikit-learn pytorch torchvision torchaudio cpuonly tensorflow -c pytorch -c conda-forge -y
if %errorlevel% neq 0 (
    echo Error installing libraries. Continuing.
)

echo Setup complete! To activate the environment, use:
echo conda activate mttn

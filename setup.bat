@echo off
setlocal enabledelayedexpansion

:: Kiểm tra Python đã cài chưa
where python >nul 2>nul
if %errorlevel% equ 0 (
    echo Python found. Checking version...
    
    :: Lấy phiên bản Python
    for /f "delims=" %%V in ('python -c "import sys; print(sys.version[:5])"') do set PYTHON_VERSION=%%V
    
    echo Detected Python version: %PYTHON_VERSION%
    
    :: Nếu không phải Python 3.10, gỡ cài đặt
    if not "%PYTHON_VERSION%"=="3.10." (
        echo Removing existing Python version...
        powershell -Command "Get-Package -Name *Python* | Uninstall-Package -Force"
    ) else (
        echo Python 3.10 is already installed.
        goto CREATE_ENV
    )
) else (
    echo No Python installation found.
)

:: Cài đặt Python 3.10
echo Downloading and installing Python 3.10...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe' -OutFile 'python_installer.exe'}"
start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
del python_installer.exe
echo Python 3.10 installed successfully.

:: Cập nhật đường dẫn
set PYTHON_310_PATH=C:\Python310\python.exe
set PATH=C:\Python310\Scripts\;C:\Python310\;%PATH%

:: Kiểm tra cài đặt thành công chưa
if not exist "%PYTHON_310_PATH%" (
    echo Error: Python 3.10 installation failed.
    exit /b 1
)

:CREATE_ENV
echo Installing pip...
"%PYTHON_310_PATH%" -m ensurepip --default-pip
"%PYTHON_310_PATH%" -m pip install --upgrade pip

echo Creating virtual environment 'mttn'...
"%PYTHON_310_PATH%" -m venv mttn

:: Kích hoạt môi trường ảo
call mttn\Scripts\activate

echo Installing machine learning libraries...
pip install numpy pandas matplotlib scikit-learn torch torchvision torchaudio tensorflow notebook

echo Setup complete! To activate the environment, use:
echo call mttn\Scripts\activate

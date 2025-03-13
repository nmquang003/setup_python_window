@echo off
setlocal enabledelayedexpansion

echo Checking for Python 3.10 installation...

:: Kiểm tra Python 3.10 đã cài chưa
where python310 >nul 2>nul
if %errorlevel% neq 0 (
    echo Python 3.10 not found. Downloading and installing...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe' -OutFile 'python_installer.exe'}"
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python_installer.exe
    echo Python 3.10 installed successfully.
) else (
    echo Python 3.10 is already installed.
)

:: Định vị Python 3.10
set PYTHON_310_PATH=C:\Python310\python.exe

:: Kiểm tra xem Python 3.10 có tồn tại không
if not exist "%PYTHON_310_PATH%" (
    echo Error: Python 3.10 installation not found. Please check installation.
    exit /b 1
)

:: Cập nhật PATH để ưu tiên Python 3.10
set PATH=C:\Python310\Scripts\;C:\Python310\;%PATH%

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

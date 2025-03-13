@echo off
setlocal enabledelayedexpansion

echo Checking for Python installation...
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python not found. Downloading and installing Python...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.10.11/python-3.10.11-amd64.exe' -OutFile 'python_installer.exe'}"
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
    del python_installer.exe
    echo Python installed successfully.
) else (
    echo Python is already installed.
)

:: Refresh the environment variables
set PATH=%PATH%;C:\Python310\Scripts\;C:\Python310\

echo Installing pip...
python -m ensurepip --default-pip
python -m pip install --upgrade pip

echo Creating virtual environment...
python -m venv mttn
call mttn\Scripts\activate

echo Installing machine learning libraries...
pip install numpy pandas matplotlib scikit-learn torch torchvision torchaudio tensorflow notebook

echo Setup complete! To activate the environment, use:
echo call mttn\Scripts\activate

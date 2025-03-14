# setup_python_window
setup python environment for ML on window

Open cmd with Administrator mode and run this command: ```setup.bat & install_lib.bat```

Or if you have not cloned this repo yet, you can run:
```
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/nmquang003/setup_python_window/archive/refs/heads/main.zip' -OutFile 'setup_python_window.zip'}" & ^
powershell -Command "& {Expand-Archive -Path 'setup_python_window.zip' -DestinationPath '.' -Force}" & ^
cd setup_python_window-main & ^
setup.bat & ^
start cmd /k install_lib.bat
```

# setup_python_window
setup python environment for ML on window

Open cmd with Administrator mode and run this command: 
```
setup.bat & start cmd /k install_lib.bat
```

Or if you have not cloned this repo yet, you can run:
```
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/nmquang003/setup_python_window/archive/refs/heads/main.zip' -OutFile 'setup_python_window.zip'}" & ^
powershell -Command "& {Expand-Archive -Path 'setup_python_window.zip' -DestinationPath '.' -Force}" & ^
cd setup_python_window-main & ^
setup.bat & ^
start cmd /k "install_lib.bat & conda run -n base python check_env_lib.py"
```

Check the environment use:
```
conda run -n base python check_env_lib.py
```

Or if you have not cloned this repo yet, to download dataset, you can run:
```
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/nmquang003/setup_python_window/archive/refs/heads/main.zip' -OutFile 'setup_python_window.zip'}" & ^
powershell -Command "& {Expand-Archive -Path 'setup_python_window.zip' -DestinationPath '.' -Force}" & ^
cd setup_python_window-main & ^
down_load_data.bat"
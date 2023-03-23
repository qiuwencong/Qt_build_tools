@echo off
setlocal

cd %QTBUILDDIR% ||  exit /b %errorlevel%

echo Building Qt...
start /W /BELOWNORMAL "Building Qt..." jom
IF %errorlevel% NEQ 0 exit /b %errorlevel%
echo Installing Qt...
start /W /BELOWNORMAL "Installing Qt..." jom install
IF %errorlevel% NEQ 0 exit /b %errorlevel%

echo Qt sucessfully installed please wait for clean
rd /s /q %QTBUILDDIR%


echo Copy OpenSSL, MySQL...
powershell.exe %TOOLSDIR%\script\cleanqt.ps1 %VCPKG_InstalledDir% %MySqlInstallDir% %QTINSTALLDIR%

endlocal

@echo off
setlocal
echo %QTBUILDDIR%
cd %QTBUILDDIR% ||  exit /b %errorlevel%

echo Building Qt...
start /W /BELOWNORMAL /b "Building Qt..." cmake --build .
IF %errorlevel% NEQ 0 exit /b %errorlevel% 
echo Installing Qt...
start /W /BELOWNORMAL "Installing Qt..." cmake --install . --config Release
IF %errorlevel% NEQ 0 exit /b %errorlevel% 
echo Copy MySQL...
powershell.exe %TOOLSDIR%\cleanqt.ps1 %VCPKG_InstalledDir% %MySqlInstallDir% %QTINSTALLDIR%
rd /s /q %QTBUILDDIR%	
endlocal

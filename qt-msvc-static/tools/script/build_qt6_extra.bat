@echo off
setlocal EnableDelayedExpansion

set EXTPATH=%SRCDIR%\%MODULENAME%-everywhere-src-%QTVER%
set QCONFIGMODULES=%QTINSTALLDIR%\bin\qt-configure-module.bat

IF NOT "%MODULENAME%" == "" (

    echo PATH: %EXTPATH%
	set URL=https://mirrors.sjtug.sjtu.edu.cn/qt/%QTRELEASE%_releases/qt/%QTMVER%/%QTVER%/submodules/%MODULENAME%-everywhere-src-%QTVER%.zip
    
	cd %SRCDIR%
	IF not exist %MODULENAME%-everywhere-src-%QTVER%.zip (	
    echo Downloading !URL!
    curl %CURLOPTS% !URL!
	)

    rd %EXTPATH% /s /q
    7z %ZOPTS% %MODULENAME%-everywhere-src-%QTVER%.zip || exit /b %errorlevel%
    cd ..

    cd %EXTPATH% ||  exit /b %errorlevel%

    echo Configuring %MODULENAME%...
    start /W "Configuring %MODULENAME%" %QCONFIGMODULES% %EXTPATH% || exit /b %errorlevel%
	IF %errorlevel% NEQ 0 exit /b %errorlevel%
	
	echo Building %MODULENAME%...
    start /W /BELOWNORMAL "Building %MODULENAME%..." cmake --build . || exit /b %errorlevel%
    IF %errorlevel% NEQ 0 exit /b %errorlevel%

    echo Installing %MODULENAME%...
    start /W /BELOWNORMAL "Installing %MODULENAME%..." cmake --install .
    IF %errorlevel% NEQ 0 exit /b %errorlevel%
	rd /s /q %EXTPATH%
    echo %MODULENAME% installed
) ELSE (
    echo Missing extension name!
)

endlocal

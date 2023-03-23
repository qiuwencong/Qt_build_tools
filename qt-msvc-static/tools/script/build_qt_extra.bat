@echo off
setlocal EnableDelayedExpansion

set EXTPATH=%SRCDIR%\%MODULENAME%-everywhere-src-%QTVER%
set QMAKE=%QTINSTALLDIR%\bin\qmake.exe

IF NOT "%MODULENAME%" == "" (

    echo PATH: %EXTPATH%
    echo QMAKE: %QMAKE%

    set URL=https://mirrors.sjtug.sjtu.edu.cn/qt/%QTRELEASE%_releases/qt/%QTMVER%/%QTVER%/submodules/%MODULENAME%-everywhere-opensource-src-%QTVER%.zip

    cd %SRCDIR%
    echo Downloading !URL!
    curl %CURLOPTS% !URL!

    rd %EXTPATH% /s /q
    7z %ZOPTS% %MODULENAME%-everywhere-opensource-src-%QTVER%.zip || exit /b %errorlevel%
    cd ..

    cd %EXTPATH% ||  exit /b %errorlevel%

    echo Configuring %MODULENAME%...
    start /W "Configuring %MODULENAME%" %QMAKE% || exit /b %errorlevel%
    IF %errorlevel% NEQ 0 exit /b %errorlevel%

    echo Building %MODULENAME%...
    start /W /BELOWNORMAL "Building %MODULENAME%..." jom clean release
    IF %errorlevel% NEQ 0 exit /b %errorlevel%

    echo Installing %MODULENAME%...
    start /W /BELOWNORMAL "Installing %MODULENAME%..." jom install
	cd %SRCDIR%
    IF %errorlevel% NEQ 0 exit /b %errorlevel%
	rd %EXTPATH% /s /q 
    echo %MODULENAME% installed
) ELSE (
    echo Missing extension name!
)

endlocal

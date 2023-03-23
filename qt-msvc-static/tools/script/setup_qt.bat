@echo off
setlocal


IF exist %QTDIR% (
    cd %QTDIR%
) ELSE ( 
    echo Could not find Qt sources in %QTDIR%
    exit /b 1
)

if defined MySqlInstallDir (
	echo %MySqlInstallDir%
) ELSE (
	SET /P MySqlInstallDir=MySql install path:
)
SET qtBuildMySqlIncludePath=%MySqlInstallDir%\include
SET qtBuildMySqlLibPath=%MySqlInstallDir%\lib

IF exist %QTBUILDDIR% (
    echo Cleaning old Qt build dir
    rd /s /q %QTBUILDDIR%
)

md %QTBUILDDIR%
cd %QTBUILDDIR%  ||  exit /b %errorlevel%
SET CONFIGOPTION=-prefix %QTINSTALLDIR% -platform %mkspecs% ^
-opensource -release -confirm-license -opengl desktop -%qtBuildType% -optimize-size -mp -silent ^
-qt-sqlite -sql-sqlite -sql-odbc -nomake examples -nomake tests OPENSSL_PREFIX=%VCPKG_InstalledDir% ^
-I %VCPKG_InstalledDir%\include -L %VCPKG_InstalledDir%\lib MYSQL_PREFIX=%MySqlInstallDir% %EXTRABUILDOPTIONS%

echo Configuring Qt ... %CONFIGOPTION%
start /W /BELOWNORMAL "Configuring Qt..." %QTDIR%\configure.bat  %CONFIGOPTION% ^&^& exit

IF %errorlevel% NEQ 0 exit /b %errorlevel%

echo Configuration complete
echo Will install to %QTINSTALLDIR%
exit /b 
endlocal


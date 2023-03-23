@echo off
setlocal



IF exist %QTDIR% (
    cd %QTDIR%
) ELSE ( 
    echo Could not find Qt sources in %QTDIR%
    exit /b 1
)

IF exist %QTBUILDDIR% (
    echo Cleaning old Qt build dir
    rd /s /q %QTBUILDDIR%
)

md %QTBUILDDIR%
cd %QTBUILDDIR%  ||  exit /b %errorlevel%

echo Configuring Qt...
SET ConfigOption=-prefix %QTINSTALLDIR% -platform win32-msvc -opensource -release -%qtBuildType% -confirm-license ^
-opengl desktop -optimize-size -no-dbus -no-icu -no-fontconfig -qt-sqlite -sql-sqlite -sql-odbc ^
-nomake examples -nomake tests  %EXTRABUILDOPTIONS% -openssl-linked -I %VCPKG_InstalledDir%\include ^
-L %VCPKG_InstalledDir%\lib -- -DOPENSSL_ROOT_DIR="%VCPKG_InstalledDir%" -DOPENSSL_INCLUDE_DIR="%VCPKG_InstalledDir%/include" ^
-DMySQL_INCLUDE_DIR="%MySqlInstallDir%/include" -DMySQL_LIBRARY="%MySqlInstallDir%/lib/libmysql.lib "

start /W /BELOWNORMAL "Configuring Qt..." %QTDIR%\configure.bat  %ConfigOption% ^&^& exit

IF %errorlevel% NEQ 0 exit /b %errorlevel%

echo Configuration complete
echo Will install to %QTINSTALLDIR%

endlocal



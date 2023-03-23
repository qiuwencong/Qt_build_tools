@echo off
cls
title qt easy build tools

cls
color 0A
setlocal
call tools\script\options_qt6.bat
set choice=%1
:cho




echo.
echo                 ==============================================
echo                 please select the options then press ENDER key
echo                 ==============================================
echo.
echo 			Available commands:
echo.
echo              1.download: Download and extracts required sources
echo.
echo              2.vcpkg [name]: install vcpkg packages you need
echo.
echo              3.setup : Setup Qt
echo.
echo              4.Build Qt
echo.
echo              5.clean : clean Qt
echo.
echo              6.extra [name]: Download and build qt extension ^(you need to specify the name^)
echo.
echo.
echo.
echo.
SET /p choice= please select:
echo choice: "%choice%"


echo.

IF NOT "%choice%"=="" (
    
		if /i "%choice%"=="1" call tools\script\download.bat
		if /i "%choice%"=="2" (
		    set /p PKGNAME=3rdParty packages name:
			call tools\script\vcpkg_install.bat			
		)
		if /i "%choice%"=="3" call tools\script\setup_qt6.bat
		if /i "%choice%"=="4" call tools\script\build_qt6.bat
		if /i "%choice%"=="5" (
		    echo Cleaning old Qt build dir
			rd /s /q %QTBUILDDIR%
			rd /s /q %SSLBUILDDIR%\build
			rd /s /q %MySqlSrcDir%\build
		    echo Copy OpenSSL, MySQL...
			powershell.exe tools\cleanqt.ps1 %SSLINSTALLDIR% %MySqlInstallDir% %QTINSTALLDIR%
		)
		if /i "%choice%"=="6" (
		    set /p MODULENAME=extra module name:
			call tools\script\build_qt6_extra.bat
		)
		
		if /i "%choice%"=="Q" goto endd		

)
goto cho

:endd
endlocal

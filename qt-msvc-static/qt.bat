@echo off
cls
title qt easy build tools

cls
color 0A
setlocal
call tools\script\options.bat
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
		if /i "%choice%"=="3" call tools\script\setup_qt.bat
		if /i "%choice%"=="4" call tools\script\build_qt.bat
		if /i "%choice%"=="5" (
		    echo Cleaning old Qt build dir
			rd /s /q %QTBUILDDIR%
			rd /s /q %SSLBUILDDIR%\build
			rd /s /q %MySqlSrcDir%\build
		    ::echo Copy  MySQL...
			::powershell.exe tools\cleanqt.ps1 %VCPKG_InstalledDir% %MySqlInstallDir% %QTINSTALLDIR%
		)
		if /i "%choice%"=="6" (
		    set /p MODULENAME=extra module name:
			call tools\script\build_qt_extra.bat
		)
		
		if /i "%choice%"=="Q" goto endd
		if /i "%choice%"=="download" (
			call tools\script\download.bat
		)
		if /i "%choice%"=="setup" (
			call tools\script\setup_qt.bat
		)
		
		if /i "%choice%"=="build" (
			call tools\script\build_qt.bat
		)
				
		if /i "%choice%"=="extra" (
		    set MODULENAME=%2
			call tools\script\build_qt_extra.bat
		)
		if /i "%choice%"=="clean" (
			echo Cleaning old Qt build dir
			rd /s /q %QTBUILDDIR%
		    :: echo Copy OpenSSL, MySQL...
			:: powershell.exe tools\cleanqt.ps1 %VCPKG_InstalledDir% %MySqlInstallDir% %QTINSTALLDIR%
		)

)
goto cho

:endd
endlocal

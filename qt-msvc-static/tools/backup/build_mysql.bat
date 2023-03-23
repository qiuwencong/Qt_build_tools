@echo off
setlocal


set WARCH=Win32


IF %VSCMD_ARG_TGT_ARCH% == x64 set WARCH=x64

echo Configuring MySql %MySqlVer% for %WARCH%...

IF exist %MySqlSrcDir% (
	echo MySqlSrcDir : %MySqlSrcDir%
	pause
	cd %MySqlSrcDir%
	rd build /s /q
	md build
	cd build
	cmake.exe .. -DCMAKE_INSTALL_PREFIX=%MySqlInstallDir% -DBUILD_SHARED_LIBS=OFF -DLINK_STATIC_RUNTIME_LIBRARIES=1 -DDOWNLOAD_BOOST=1 -DWITH_BOOST="C:\Boost" -DWITH_SSL="%SSLINSTALLDIR%" -G "Visual Studio 14 2015" -A %WARCH%
	pause
) ELSE (

	echo Could not find mysql sources in %MySqlSrcDir%
	exit /b 1
)

endlocal

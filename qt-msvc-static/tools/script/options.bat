@echo off
SET MSVCVER=2019
SET QTMVER=5.15
SET QTVER=5.15.8
SET SSLVER=1.1.1n
SET MySqlVer=6.1.11


SET EXTRABUILDOPTIONS=-system-libpng -system-libjpeg -system-zlib -system-freetype -openssl-linked 
SET STARTDIR=%CD%
SET SRCDIR=D:\Qt\src
SET BUILDDIR=%SRCDIR%\build
SET TOOLSDIR=%STARTDIR%\tools\
SET PREFIX=D:/Qt/installed
SET VCPKG_ROOT=D:\Qt\Tools\vcpkg-tools\vcpkg-2022.03.09
SET qtBuildType=static

REM DO NOT EDIT BELOW THIS LINE
IF  NOT "%VSCMD_ARG_TGT_ARCH%"=="" goto Start

SET /P VSCMD_ARG_TGT_ARCH=Qt build bits(x86/x64):
:Start

echo Qt build type (shared/static):%qtBuildType%
echo Qt build bits (x86/x64):%VSCMD_ARG_TGT_ARCH%
::-vcvars_ver=14.0
if %MSVCVER% equ 2019 (
	CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" %VSCMD_ARG_TGT_ARCH% 
 ) ELSE ( CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" %VSCMD_ARG_TGT_ARCH% )
SET QTINSTALLDIR=%PREFIX%/%QTVER%/msvc%MSVCVER%-%VSCMD_ARG_TGT_ARCH%
SET VCPKG_Triplets=%VSCMD_ARG_TGT_ARCH%-windows

if "%qtBuildType%" equ "static" (
	SET VCPKG_Triplets=%VSCMD_ARG_TGT_ARCH%-windows-static-md
	SET QTINSTALLDIR=%PREFIX%/%QTVER%/msvc%MSVCVER%-%VSCMD_ARG_TGT_ARCH%-%qtBuildType%
 )
 SET VCPKG_InstalledDir=%PREFIX%/vcpkg-installed/%VCPKG_Triplets%

echo QTINSTALLDIR  %QTINSTALLDIR%
SET QTRELEASE=official
for %%A in (alpha beta rc) DO (echo.%QTVER% | find /I "%%A">Nul && SET QTRELEASE=development)

SET QTURL=https://mirrors.sjtug.sjtu.edu.cn/qt/%QTRELEASE%_releases/qt/%QTMVER%/%QTVER%/submodules/qtbase-everywhere-opensource-src-%QTVER%.zip
SET QTDIR=%SRCDIR%\qtbase-everywhere-src-%QTVER%
SET QTBUILDDIR=%QTDIR%\build
SET QTBASEFILE=qtbase-everywhere-opensource-src-%QTVER%.zip

SET SSLURL=https://www.openssl.org/source/openssl-%SSLVER%.tar.gz
SET SSLBUILDDIR=%SRCDIR%\openssl-%SSLVER%
SET SSLINSTALLDIR=%VCPKG_InstalledDir% 

if "%MSVCVER%" neq "2015" (
	SET SSLINSTALLDIR=%PREFIX%/openssl-%SSLVER%/msvc%MSVCVER%-%VSCMD_ARG_TGT_ARCH%-%qtBuildType%
)

SET MySqlSrcDir=%SRCDIR%\mysql-connector-c-%MySqlVer%-src
if "%VSCMD_ARG_TGT_ARCH%" equ "x86" (
	SET MySqlInstallDir=%PREFIX%/LibMySql/win32
) else (
	SET MySqlInstallDir=%PREFIX%/LibMySql/win64
)
SET CURLOPTS=-L -C - -O
SET ZOPTS=x -aos -y
SET mkspecs=win32-msvc
SET PATH=D:\home\python\Miniconda2\envs\py38;%STARTDIR%\tools\gnuwin32\bin;%STARTDIR%\tools\jom;%STARTDIR%\tools\nasm;%VCPKG_InstalledDir%\bin;%QTINSTALLDIR%\bin;%PATH%

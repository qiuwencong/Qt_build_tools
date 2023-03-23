@echo off
setlocal
%VCPKG_ROOT%\vcpkg.exe search %PKGNAME%
echo %VCPKG_ROOT%\vcpkg.exe install %PKGNAME%:%VCPKG_Triplets% --x-install-root=%PREFIX%/vcpkg-installed --clean-after-build 
start /W /BELOWNORMAL "Building %PKGNAME%..." %VCPKG_ROOT%\vcpkg.exe install %PKGNAME%:%VCPKG_Triplets% --x-install-root=%PREFIX%/vcpkg-installed --clean-after-build 
IF %errorlevel% NEQ 0 exit /b %errorlevel%
echo %PKGNAME% sucessfully installed
IF %errorlevel% NEQ 0 exit /b %errorlevel%
endlocal



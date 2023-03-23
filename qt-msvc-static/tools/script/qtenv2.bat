@echo off
echo Setting up environment for Qt usage...
set PATH= C:\Qt\Tools\CMake_64\bin;D:\Qt\Tools\jom;D:\Qt\Tools\Strawberry\perl\bin;D:\home\python\Miniconda2\envs\py38;%PATH%;%cd%

echo Remember to call vcvarsall.bat to complete environment setup!
REM CALL "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
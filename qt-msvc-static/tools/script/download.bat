setlocal

cd %SRCDIR% ||  exit /b %errorlevel%

IF not exist %QTBASEFILE% (
echo Downloading %QTURL% 
curl %CURLOPTS%  %QTURL% 
)
7z %ZOPTS% %QTBASEFILE% || exit /b %errorlevel%

IF not exist openssl-%SSLVER%.tar.gz (
echo Downloading %SSLURL%
curl %CURLOPTS% %SSLURL%
)
7z %ZOPTS% openssl-%SSLVER%.tar.gz ||  exit /b %errorlevel%
7z %ZOPTS% openssl-%SSLVER%.tar ||  exit /b %errorlevel%

cd ..

endlocal

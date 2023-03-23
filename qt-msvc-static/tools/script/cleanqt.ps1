[CmdletBinding()]
param($vcpkg_install_dir,$mysql_install_folder,$prefix_folder)

function Main
{ 
	cp "$mysql_install_folder\lib\*.dll" "$prefix_folder\bin\"
	cp "$mysql_install_folder\lib\*.lib" "$prefix_folder\lib\"

	$mysql_lib_folder_esc = "$mysql_install_folder\lib\" -replace '\\','/'
	Write-Output $mysql_lib_folder_esc
	gci -r -include "*.prl" $prefix_folder | foreach-object { $a = $_.fullname; (get-content $a) -replace '\\{1,}','/' | set-content $a }
	gci -r -include "*.prl" $prefix_folder | foreach-object { $a = $_.fullname; (get-content $a) -replace ($mysql_lib_folder_esc,'$$$$[QT_INSTALL_LIBS]/') | set-content $a }
	gci -r -include "*.prl" $prefix_folder | foreach-object { $a = $_.fullname; (get-content $a) -replace 'freetype.lib ','freetype.lib bz2.lib brotlidec-static.lib brotlicommon-static.lib ' | set-content $a }
	gci -r -include "*.prl" $prefix_folder | foreach-object { $a = $_.fullname; (get-content $a) -replace 'freetype.lib;','freetype.lib;bz2.lib;brotlidec-static.lib;brotlicommon-static.lib;' | set-content $a }

}

#-----------------------------------------------------------------------------
# Execute main code.
#-----------------------------------------------------------------------------

. Main
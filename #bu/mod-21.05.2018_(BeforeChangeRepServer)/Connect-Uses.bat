::Connect-Uses
::Autor: Carlos Lujan
::Version: 1.0
::Ejemplo: ["Z:;\\Servidor\recurso compartido","..."]

@echo off
call:Main %* & goto:EOF

:Main
	::connect-uses 
	for %%i in (%*) do (
		for /f "tokens=1,2 delims=;" %%b in (%%i) do (
			net use %%b "%%c" /yes>nul 2>&1
	))
	::Echo
	echo %~n0
goto:EOF
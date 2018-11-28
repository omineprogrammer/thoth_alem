::Install-SharedPrinter
::Autor: Carlos Lujan
::Version: 1.0
::Argumentos de Ejecucion: ["\\Servidor\impresora compartida","..."]

@echo off
call:Main %* & goto:EOF

:Main
	::install-printers
	for %%i in (%*) do (
		rundll32 printui.dll,PrintUIEntry /Gw /in /n "%%i"
	)
	::Echo
	echo %~n0
goto:EOF
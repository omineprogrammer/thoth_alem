::Sync-DateTime
::Autor: Carlos Lujan
::Version: 1.0
::Argumentos de Ejecucion: ["\\Server"]

@echo off
call:Main %* & goto:EOF

:Main
	::sync from server
	Net time "%*" /set /yes>nul 2>&1
	::Echo
	echo %~n0
goto:EOF
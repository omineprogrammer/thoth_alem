::Purge-Uses
::Autor: Carlos Lujan
::Version: 1.0
::Argumentos de Ejecucion: []

@echo off
call:Main %* & goto:EOF

:Main
	::purge-uses
	net use * /d /y>nul 2>&1
	::Echo
	echo %~n0
goto:EOF
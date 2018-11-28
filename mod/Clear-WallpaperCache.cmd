::Clear-WallpaperCache
::Autor: Carlos Lujan
::Version: 1.0
::Argumentos de Ejecucion: 

@echo off
call:Main %* & goto:EOF

:Main
	::Clear-WallpaperCache
	del /q /f /s %userprofile%\AppData\Roaming\Microsoft\Windows\Themes\* >nul 2>&1
goto:EOF
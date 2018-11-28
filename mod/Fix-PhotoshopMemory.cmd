::Fix-PhotoshopMemory
::Autor: Carlos Lujan
::Version: 1.0
::Fecha: 28.11.2018
::Argumentos de Ejecucion: 

@echo off
call:Main %* & goto:EOF

:Main
	::vars
	set regpath=HKCU:\Software\Adobe\Photoshop\120.0
	set property=OverridePhysicalMemoryMB

	::set reg record
	powershell -Command "& {$_regpath = '%regpath%'; $_propertyname = '%property%'; $_reg = $(Get-ItemProperty -Path $_regpath -Name $_propertyname -ErrorAction SilentlyContinue); $_memory = $(Get-CimInstance win32_ComputerSystem | foreach {[Math]::Round($_.TotalPhysicalMemory /1MB)}); if (-not $_reg -or ($_reg.%property% -lt $_memory) ) { $null = $(New-ItemProperty $_regpath -Name $_propertyname -PropertyType DWORD -Value $_memory -ErrorAction SilentlyContinue); Write-Host 'Phothoshop Memory Fixed with:' $_memory 'MB' -ForegroundColor Red -BackgroundColor DarkYellow }}"
	::Echo
	echo %~n0
goto:EOF
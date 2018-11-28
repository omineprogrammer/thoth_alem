::Auto-Login
::Autor: Carlos Lujan
::Version: 1.0
::Argumentos de Ejecucion: ["DOMAIN" "username" "password"]

@echo off
call:Main %* & goto:EOF

:Main
	::paramt
	set _domain=%1
	set _username=%2
	set _password=%3
	::unpacked paramt		
	set _domain=%_domain:"=%
	set _username=%_username:"=%
	set _password=%_password:"=%
	
	::add to registry
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultDomainName /d %_domain% >nul 2>&1
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultUserName /d %_username% >nul 2>&1
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v DefaultPassword /d %_password% >nul 2>&1
	REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /f /v AutoAdminLogon /d 1 >nul 2>&1
	
	::Echo
	echo %~n0
goto:EOF
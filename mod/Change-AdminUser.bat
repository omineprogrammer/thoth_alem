::Autor: Carlos Lujan
::descripcion: script instalacion fs-agent

@echo off
call:Main & goto:EOF

:Main
	::vars
	setlocal enableextensions enabledelayedexpansion	
	set pw_name="a00aN1u23u-i039tro-g12a304aa923213ue-n123o321a31ua213"
	set pw_numb="0236344234234021593624364111235470143346215302394825344"

	for /f "usebackq tokens=*" %%a in (`type "%_err%"`) do (

	)
	set installer="\\colaleman.ds-bq.local\apps\Freshservice_Discovery_Agent\psexec.exe"
	set passwd=@rg0n18
	
	::verify
	if exist "%programfiles(x86)%\Freshdesk\Freshservice Discovery Agent\bin\FSDiscovery.exe" (
		echo FS-Agent exist
		timeout /t 5 >nul 2>&1
	) else (
		echo install 
		%installer% -u ds-bq\administrador -p %passwd% -accepteula msiexec.exe /i %installer% /qn
		echo FS-Agent installed [%ERRORLEVEL%]
		timeout /t 5 >nul 2>&1
	)
	
goto:EOF
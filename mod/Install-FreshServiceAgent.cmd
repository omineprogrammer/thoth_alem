::THOTH
::version: 1.0
::fecha: 05.07.2018
::Autor: Carlos Lujan
::descripcion: script instalacion fs-agent

@echo off
call:Main & goto:EOF

:Main
	::vars
	set script="\\colaleman.ds-bq.local\apps\Freshservice_Discovery_Agent\InstallFSWinAgent.vbs"
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

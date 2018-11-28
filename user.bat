@echo off

::global var
set workdir=\\ds-bq.local\NETLOGON

call:Main & goto:EOF

:Main
	::Sync-DateTime
	call %workdir%\mod\Sync-DateTime "\\172.18.99.203"
	
	::Install-SharedPrinter
	call %workdir%\mod\Install-SharedPrinter "\\172.18.99.202\FotocopiadoraSalaProfesores"
	
	::Up-AudioSrv
	call %workdir%\mod\Up-AudioSrv
	
	::Purge-Uses
	call %workdir%\mod\Purge-Uses
	
	::Connect-Uses
	call %workdir%\mod\Connect-Uses "O:;\\172.18.99.203\Instaladores"
	call %workdir%\mod\Connect-Uses "N:;\\172.18.99.203\Sistemas"
	::Connect-Reps
	call %workdir%\mod\Connect-Uses "U:;\\colaleman.ds-bq.local\Apps"
	call %workdir%\mod\Connect-Uses "V:;\\colaleman.ds-bq.local\Images"
	call %workdir%\mod\Connect-Uses "W:;\\colaleman.ds-bq.local\Doc"
	call %workdir%\mod\Connect-Uses "X:;\\colaleman.ds-bq.local\OSRep"
	call %workdir%\mod\Connect-Uses "Y:;\\colaleman.ds-bq.local\Deploy"
	call %workdir%\mod\Connect-Uses "Z:;\\colaleman.ds-bq.local\Scripts"

	::Get-ComputerInfo
	call %workdir%\mod\Get-ComputerInfo.cmd
goto:EOF
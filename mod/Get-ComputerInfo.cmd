::THOTH
::version: 1.3.0.4
::fecha: 05.08.2018
::Autor: Carlos Lujan
::descripcion: script avanzado para auditoria

@echo off
call:Main & goto:EOF

:Main
	::Kronos
	call:Get-Kronos kronos
	call:Get-KronosStr kronosstr
	::vars
	setlocal enableextensions enabledelayedexpansion
	set out_file=%temp%\out.csv
	set tmp_file=%temp%\tmp.txt
	set report_name=%COMPUTERNAME%_%kronosstr%.csv
	::arch var verify
	if exist "%programfiles(x86)%" (
		set search="%programfiles(x86)%\HitmanPro.Alert\hmpalert.exe"
	) else (
		set search="%programfiles%\HitmanPro.Alert\hmpalert.exe"
	)

	::Thoth SMB Server Repository
	set server=\\172.18.99.203\THOTH

	set local=%APPDATA%\Thoth
	set grant=administrador:(F),DS-BQ\administrador:(F),DS-BQ\sistemas:(F)
	set remove=DS-BQ\administradores,Authenticated Users,Usuarios autentificados,BUILTIN\Usuarios,Usuarios,%USERDOMAIN%\%USERNAME%,%USERNAME%
	::depure files
	del /f /q "%out_file%">nul 2>&1
	del /f /q "%tmp_file%">nul 2>&1
	
	::Python
	::call:Find-AppFolder return "%kronos%" FindAppFolder "C:\Python*"
	::echo %return%>>"%out_file%" 2>nul
	
	::IntercepX
	call:Find-AppFolder return "%kronos%" FindAppFolder %search%
	echo %return%>>"%out_file%" 2>nul
	
	::Get-WMICasCSV
	call:Get-WMICasCSV %tmp_file% "%kronos%" BaseBoard "Get Manufacturer,Model,Product,SerialNumber,Version"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" BIOS "Get Manufacturer,SerialNumber,SMBIOSBIOSVersion"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" CDROM "Get Drive,Manufacturer,Name"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" ComputerSystem "Get Manufacturer,Model,NumberOfProcessors,NumberOfLogicalProcessors,SystemType,TotalPhysicalMemory,UserName"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" CPU "Get DeviceID,ExtClock,L2CacheSize,L3CacheSize,Manufacturer,MaxClockSpeed,Name,NumberOfCores,NumberOfLogicalProcessors,ProcessorId,SocketDesignation"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" CSProduct "Get IdentifyingNumber,Name,SKUNumber,UUID,Vendor"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" DiskDrive "Get DeviceID,InterfaceType,Model,SerialNumber,Size"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" IDEController "Get DeviceID,Manufacturer,Name"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" LogicalDisk "Get DeviceID,FileSystem,FreeSpace,Size,VolumeSerialNumber"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" MemoryChip "Get BankLabel,Capacity,DeviceLocator,Manufacturer,PartNumber,SerialNumber,Speed,Tag"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" NETLogin "Get BadPasswordCount,Caption,FullName,LastLogon,MaximumStorage,Name,NumberOfLogons,ScriptPath,UserId"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" NETUse "Get LocalName,Persistent,RemotePath,Status,UserName"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" NIC "Where PhysicalAdapter='True' Get DeviceID,MACAddress,Manufacturer,Name,PhysicalAdapter,Speed"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" NICConfig "Where IPEnabled=TRUE get IPAddress,DefaultIPGateway,Description,DNSServerSearchOrder,IPSubnet,MACAddress"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" OS "Get BuildNumber,Caption,InstallDate,NumberOfUsers,OSArchitecture,SerialNumber,Version"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" Partition "Get Bootable,DeviceID,Size,StartingOffset,Type"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" Printer "Get DeviceID,DriverName,Location,PortName,PrintJobDataType,Shared,ShareName"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" PrinterConfig "Get Color,Copies,Duplex,Name,Orientation,PaperSize,XResolution,YResolution"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" Product "Get Name,Vendor,Version"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" SCSIController "Get DeviceID,Manufacturer,Name"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" Share "Get Description,Name,Path"
	type "%tmp_file%">>"%out_file%"
	
	::call:Get-WMICasCSV %tmp_file% "%kronos%" SoftwareFeature "Get Caption,ProductName,Vendor,Version"
	::type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" SoundDev "Get Manufacturer,Name"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" StartUp "Get Command,Location,Name"
	type "%tmp_file%">>"%out_file%"
	
	::call:Get-WMICasCSV %tmp_file% "%kronos%" SysDriver "Get Name,PathName,ServiceType,StartMode"
	::type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" SystemSlot "Get SlotDesignation,MaxDataWidth"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" TapeDrive "Get Manufacturer,MediaType,Name"
	type "%tmp_file%">>"%out_file%"
	
	call:Get-WMICasCSV %tmp_file% "%kronos%" Volume "Get BlockSize,Capacity,Compressed,DeviceID,FileSystem,FreeSpace,Label,SerialNumber,SystemVolume"
	type "%tmp_file%">>"%out_file%"
	
	::Format-CSVExcel
	call:Format-CSVExcel "%tmp_file%" "%out_file%"
	copy /v /y "%tmp_file%" "%out_file%">nul 2>&1
	::Send-SMBServer
	call:Send-SMBServer "%out_file%" "%report_name%" "%server%" "%local%" "%grant%" "%remove%"
	::Finally
	call:Finally
	::Echo
	echo %~n0
goto:EOF


::Modules
:Find-AppFolder
	::paramt
	set _time=%2
	set _class=%3
	set _search=%4
	::unpacked paramt
	set _time=%_time:"=%
	set _class=%_class:"=%
	set _search=%_search:"=%
	::process
	if exist "%_search%" (
		set %1=%_time%,%_class%,%computername%,"%_search%",Found
	) else (
		set %1=%_time%,%_class%,%computername%,"%_search%",No Found
	)
goto:EOF

:Get-WMICasCSV
	::paramt
	set _out=%1
	set _time=%2
	set _class=%3
	set _query=%4
	::unpacked paramt		
	set _out=%_out:"=%
	set _time=%_time:"=%
	set _class=%_class:"=%
	set _query=%_query:"=%
	::vars
	set _tmp=%temp%\_tmp.txt
	set _err=%temp%\_err.txt
	set _sw=True
	set _sw2=True
	::depure files
	del /f /q "%_out%">nul 2>&1
	del /f /q "%_tmp%">nul 2>&1
	del /f /q "%_err%">nul 2>&1
	::process
	for /f "usebackq tokens=*" %%a in (`dir /b "%windir%\System32\wbem\*-*"`) do (
		if exist "%windir%\System32\wbem\%%a\csv.xsl" (
			wmic %_class% %_query% /format:"%windir%\System32\wbem\%%a\csv.xsl">"%_tmp%" 2>%_err%
			::save no found
			for /f "usebackq tokens=*" %%a in (`type "%_err%"`) do (
				echo %COMPUTERNAME%,%_query:,= %,No Found>"%_tmp%" 2>nul
				::switch no found
				set _sw2=False
			)
			::switch not legacy
			set _sw=False
	))
	if %_sw% == True (
		wmic %_class% %_query% /format:csv>"%_tmp%" 2>%_err%
		::save no found
			for /f "usebackq tokens=*" %%a in (`type "%_err%"`) do (
				echo %COMPUTERNAME%,%_query:,= %,No Found>"%_tmp%" 2>nul
				::switch no found
				set _sw2=False
	))
	::return file
	if %_sw2% == True (
		for /f "usebackq tokens=* skip=2" %%a in (`type "%_tmp%"`) do (
			echo %_time%,%_class%,%%a>>"%_out%" 2>nul
	)) else (
		for /f "usebackq tokens=*" %%a in (`type "%_tmp%"`) do (
			echo %_time%,%_class%,%%a>>"%_out%" 2>nul
	))
	::finally
	del /f /q "%_tmp%">nul 2>&1
goto:EOF

:Format-CSVExcel
	::paramt
	set _out=%1
	set _in=%2
	::unpacked paramt		
	set _out=%_out:"=%
	set _in=%_in:"=%
	::vars
	set _tmp=%temp%\_tmp.txt
	::depure files
	del /f /q "%_out%">nul 2>&1
	::process
	for /f "usebackq tokens=* delims=," %%a in (`type %_in%`) do (
		set _line=%%a
		set _line=!_line:;=$!
		set _line=!_line:,=;!
		set _line=!_line:$=,!
		echo !_line!>>"%_out%"
	)
goto:EOF

:Send-SMBServer
	::paramt
	set _file=%1
	set _filename=%2
	set _server=%3
	set _local=%4
	set _grant=%5
	set _remove=%6
	::unpacked paramt		
	set _file=%_file:"=%
	set _filename=%_filename:"=%
	set _server=%_server:"=%
	set _local=%_local:"=%
	set _grant=%_grant:"=%
	set _remove=%_remove:"=%
	::protect quotes
	set _grant="%_grant%"
	set _remove="%_remove%"
	set _grant=%_grant:,=","%
	set _remove=%_remove:,=","%
	::process
	if exist "%server%" (
		::send
		copy /v /y "%_file%" "%_server%\%_filename%">nul 2>&1
		::acl
		icacls "%_server%\%_filename%" /inheritance:d>nul 2>&1
		for %%a in (%_grant%) do (
			icacls "%_server%\%_filename%" /grant %%a>nul 2>&1
		)
		for %%a in (%_remove%) do (
			icacls "%_server%\%_filename%" /remove %%a>nul 2>&1
	)) else (
		::send
		mkdir "%_local%">nul 2>&1
		copy /v /y "%_file%" "%_local%\%_filename%">nul 2>&1
		::acl
		icacls "%_local%\%_filename%" /inheritance:d>nul 2>&1
		for %%a in (%_grant%) do (
			icacls "%_local%\%_filename%" /grant %%a>nul 2>&1
		)
		for %%a in (%_remove%) do (
			icacls "%_local%\%_filename%" /remove %%a>nul 2>&1
	))
goto:EOF

:Get-Kronos
	set _var=%TIME:~0,-3%
	set %1=%DATE:~-10% %_var: =0%
goto:EOF

:Get-KronosStr
	set _var=%TIME:~0,-3%
	set _var=%DATE:~-10% %_var: =0%
	set _var=%_var:/=%
	set _var=%_var::=%
	set %1=%_var: =%
goto:EOF

:Finally
	::type "%out_file%"
	del /f /q "%out_file%">nul 2>&1
	del /f /q "%tmp_file%">nul 2>&1
goto:EOF

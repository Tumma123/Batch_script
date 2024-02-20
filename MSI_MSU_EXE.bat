@echo off
setlocal enabledelayedexpansion

REM file and folders path
set /p filename=Enter file name: 
set "sourcePath=C:\Users\raja.tumma\Downloads\"
set "remotePath=C:\temp\"
set "psexecPath=C:\Users\raja.tumma\Downloads\PSTools\psexec"
set "serverList=D:\server_list.txt"

:START
for %%J in ("%sourcePath%%filename%")do (
	echo I am in for %%J
	::   set "fileExtension=%%~xJ"
	set "fileExtension=%%~xJ"
	echo check1 !fileExtension!
)





for /F "tokens=*" %%1 in (%serverList%) do ( 
    wmic /node:"%%1" computersystem get username /value

    REM Copy the file to the remote machine MicrosoftEdgeEnterpriseX64.msi
    xcopy /y "%sourcePath%%filename%" "\\%%1\C$\temp\"

    echo Installing the file %filename% on %%1...

    REM Check the file extension and install accordingly
    if /I "!fileExtension!"==".msi" (
        REM For MSI files
        "%psexecPath%" \\%%1 powershell -Command "Start-Process msiexec.exe -Wait -ArgumentList '/i %remotePath%%filename% /qn /norestart'"
    ) else if /I "!fileExtension!"==".exe" (
        REM For EXE files
        "%psexecPath%" \\%%1 powershell -Command "Start-Process %remotePath%%filename% -Wait -ArgumentList '/s /v /qn /norestart'"
    ) else if /I "!fileExtension!"==".msu" (
        REM For MSU files
        "%psexecPath%" \\%%1 powershell -Command "Start-Process wusa.exe -Wait -ArgumentList '%remotePath%%filename% /quiet /norestart'"
    ) else (
        echo Unsupported file extension: "%%~x1" for file %filename% on %%1
    )
)
pause

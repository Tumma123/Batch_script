@echo off


set PowerShellCommand="Start-Process msiexec.exe -Wait -ArgumentList 'C:\temp\MicrosoftEdgeEnterpriseX64.msi'"

for /F "tokens=*" %%R in (D:\server_list.txt) do (
echo Running PowerShell command on %%R...

REM Use PsExec to execute PowerShell command on the remote machine
 C:\Users\raja.tumma\Downloads\PSTools\psexec \\%%R powershell -Command %PowerShellCommand%

echo PowerShell command on %RemoteMachine% completed.

)
pause

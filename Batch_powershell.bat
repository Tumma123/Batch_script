@echo off

set RemoteMachine=MAASCCMSS01P
set PowerShellCommand="(systeminfo | Select-String 'Total Physical Memory:').ToString().Split(':')[1].Trim()"

echo Running PowerShell command on %RemoteMachine%...

REM Use PsExec to execute PowerShell command on the remote machine
 C:\Users\raja.tumma\Downloads\PSTools\psexec \\%RemoteMachine% powershell -Command %PowerShellCommand%

echo PowerShell command on %RemoteMachine% completed.
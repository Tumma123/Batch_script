@echo off

set RemoteMachine=MAASCCMSS01P
set PowerShellScriptPath=C:\testing.ps1

echo Running PowerShell script on %RemoteMachine%...

REM Use PsExec to execute the PowerShell script on the remote machine
 C:\Users\raja.tumma\Downloads\PSTools\psexec \\%RemoteMachine% powershell -File %PowerShellScriptPath%

echo PowerShell script on %RemoteMachine% completed.
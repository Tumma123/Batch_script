@echo off
set MSU_FILE=C:\windows10.0-kb5034129-x64_15b9faad91f6b35ead3fbfb0fdc00f86244adc7f.msu
set LOG_FILE=C:\wusa_install.log
:START
for /F "tokens=*" %%1 in (D:\server_list.txt) do ( 
	wmic /node:"%CNAME%" computersystem get username /value
    xcopy /y "C:\Users\raja.tumma\Downloads\windows10.0-kb5034129-x64_15b9faad91f6b35ead3fbfb0fdc00f86244adc7f*" "\\%%1\C$\"
	
	
)
echo installing the MSU files 	


:: Replace 'server\share' with the actual UNC path to your MSU file
:: Replace 'Windows10.0-kb5033373-x64_f4d44e665cf4786af6838b4dff2928ac801fa672.msu' with the actual MSU file name

:: Loop through a list of remote servers

for /F "tokens=*" %%S in (D:\server_list.txt) do (
    echo Installing MSU on %%S...
    
    :: Run PsExec to execute the command on the remote server
    C:\Users\raja.tumma\Downloads\PSTools\psexec \\%%S -h -s C:\Windows\System32\cmd.exe /c "C:\Windows\System32\wusa.exe %MSU_FILE% /quiet /norestart /log:%LOG_FILE%"
    
    echo Installation on %%S completed.
    echo -------------------------------------------
)


pause

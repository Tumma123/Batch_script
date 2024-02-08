
You can use this batch file Get_Folder_Size.bat

 @echo off
 Title Script For Getting Folder Sizes
 echo Getting folder sizes for you...
 setlocal disabledelayedexpansion
 Set "VBS=%Temp%\ConvertSize.vbs"
 set "folder=%~1"
 if not defined folder set "folder=%cd%"
 @for /d %%a in ("%folder%\*") do (
     set "size=0"
     @for /f "tokens=3,5" %%b in (
         'dir /-c /a /w /s "%%~fa\*" 2^>nul ^| findstr /b /c:"  "'
     ) do (
         if "%%~c"=="" set "size=%%~b"
     )
     setlocal enabledelayedexpansion
     call :ConvertBytes !size! unit 
     echo(%%~nxa ==^> !unit!
     endlocal 
 )
 endlocal
 pause
 exit /b
 ::-------------------------------------------------------
 :ConvertBytes <Size> <Unit>
 (
     echo wscript.echo Convert("%~1"^)
     echo 'Function to format a number into typical size scales
     echo Function Convert(iSize^)
     echo    aLabel = Array("bytes", "KB", "MB", "GB", "TB"^)
     echo    For i = 0 to 4
     echo        If iSize ^> 1024 Then
     echo            iSize = iSize / 1024
     echo        Else
     echo            Exit For
     echo        End If
     echo    Next
     echo    Convert = Round(iSize,2^) ^& " " ^& aLabel(i^)
     echo End Function
 )>"%VBS%"
 for /f "delims=" %%a in ('Cscript //NoLogo "%VBS%"') do ( set "%2=%%a" )
 Exit /b
 ::-------------------------------------------------------
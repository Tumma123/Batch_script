
$arguments = "/i `"$webDeployInstallerFilePath`" /quiet"
Start-Process msiexec.exe -ArgumentList $arguments -Wait

foreach($_msiFiles in 
($_msiFiles = Get-ChildItem $_Source -Recurse | Where{$_.Extension -eq ".msi"} |
 Where-Object {!($_.psiscontainter)} | Select-Object -ExpandProperty FullName)) 
{
    msiexec /i $_msiFiles /passive
}
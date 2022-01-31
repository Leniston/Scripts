Set-ExecutionPolicy RemoteSigned (SELECT A)

$UserCredential = Get-Credential (LOG IN)

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

Import-PSSession $Session -DisableNameChecking

set-unifiedGroup -Identity "XXX" -PrimarySMTPAddress XXX@GIS.IE (CHANGE AS NECESSARY - example below)


set-unifiedGroup -Identity "Your group name here" -PrimarySMTPAddress Bill@microsoft.com (CHANGE AS NECESSARY)

## Log into O365 ## 

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential youremail@domain.com -Authentication Basic -AllowRedirection
Import-PSSession $Session -AllowClobber



## This command will export audit logs for the Sharepoint site ##

Search-UnifiedAuditLog -StartDate 5/8/2019 -EndDate 6/8/2019 -ObjectIDs "https://sharepoint.com/SitePages/Home.aspx" | export-csv -path c:\users\AuditLogs.csv

Connect-MsolService




$Result=@() 
$users = Get-MsolUser -All
$users | ForEach-Object {
$user = $_
$mfaStatus = $_.StrongAuthenticationRequirements.State 
$methodTypes = $_.StrongAuthenticationMethods 
 
if ($mfaStatus -ne $null -or $methodTypes -ne $null)
{
if($mfaStatus -eq $null)
{ 
$mfaStatus='Enabled (Conditional Access)'
}
$authMethods = $methodTypes.MethodType
$defaultAuthMethod = ($methodTypes | Where{$_.IsDefault -eq "True"}).MethodType 
$verifyEmail = $user.StrongAuthenticationUserDetails.Email 
$phoneNumber = $user.StrongAuthenticationUserDetails.PhoneNumber
$alternativePhoneNumber = $user.StrongAuthenticationUserDetails.AlternativePhoneNumber
}
Else
{
$mfaStatus = "Disabled"
$defaultAuthMethod = $null
$verifyEmail = $null
$phoneNumber = $null
$alternativePhoneNumber = $null
}
    
$Result += New-Object PSObject -property @{ 
UserName = $user.DisplayName
UserPrincipalName = $user.UserPrincipalName
MFAStatus = $mfaStatus
AuthenticationMethods = $authMethods
DefaultAuthMethod = $defaultAuthMethod
MFAEmail = $verifyEmail
PhoneNumber = $phoneNumber
AlternativePhoneNumber = $alternativePhoneNumber
}
}
$Result | Select UserName,MFAStatus,MFAEmail,PhoneNumber,AlternativePhoneNumber | Export-Csv C:\Users\PATH\Emails.csv


$Result | Where {$_.MFAStatus -ne "Disabled"} 
| Export-Csv C:\Users\PATH\Emails.csv

//List all MFA enabled users without Phone Number
$Result | Where {$_.MFAStatus -ne "Disabled" -and $_.PhoneNumber -eq $null}

//List all MFA enabled users without Alternative Authentication Phone Number
$Result | Where {$_.MFAStatus -ne "Disabled" -and $_.AlternativePhoneNumber -eq $null}

Export-Csv C:\Users\PATH\Emails.csv


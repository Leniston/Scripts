Before proceed run the following command to connect Azure AD powershell module. 
1	Connect-MsolService
The below command list all MFA enabled users (Enabled either via Conditional Access or using MFA Portal). 
1	Get-MsolUser -All | Where {$_.StrongAuthenticationMethods -ne $null -or $_.StrongAuthenticationRequirements.State -ne $nul}
List All Office 365 Users with MFA Status and MFA Details:
The following command retrieves all the Azure AD users and their MFA details. 
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40	$Result=@() 
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
$Result | Select UserName,MFAStatus,MFAEmail,PhoneNumber,AlternativePhoneNumber
List all MFA enabled users
1	$Result | Where {$_.MFAStatus -ne "Disabled"}
List all MFA enabled users without Phone Number
1	$Result | Where {$_.MFAStatus -ne "Disabled" -and $_.PhoneNumber -eq $null}
List all MFA enabled users without Alternative Authentication Phone Number
1	$Result | Where {$_.MFAStatus -ne "Disabled" -and $_.AlternativePhoneNumber -eq $null}
Export 365 users MFA status to CSV file
1	$Result | Export-CSV "C:\\O365-Users-MFA-Details.csv" -NoTypeInformation -Encoding UTF8

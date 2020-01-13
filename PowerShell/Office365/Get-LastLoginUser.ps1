$Users = Get-MsolUser -EnabledFilter All -MaxResults 5000 | Where-Object {$_.IsLicensed -eq $true}
$licensetype = Get-MsolAccountSku | Where {$_.ConsumedUnits -ge 1}
$data = Get-Date 2019-10-01

$ResultItem = @()

foreach ($User in $Users) {
    $UserLastLogon = Get-Mailbox -Identity $User.UserPrincipalName| Get-MailboxStatistics | Where-Object {$_.LastLogonTime.ToString("dd/MM/yyyy") -lt ($data.ToString("dd/MM/yyyy"))}
    
    if(!$UserLastLogon.LastLogonTime){
        Write-Host $User.UserPrincipalName
    }
    else {
        
                $ResultItem += New-Object PSObject -Property @{ 
                    DisplayName = $UserLastLogon.DisplayName 
                    UserPrincipalName = $User.UserPrincipalName
                    Marca =  $User.Office
                    LastLogon = $UserLastLogon.LastLogonTime.ToString("dd/MM/yyyy")
                }
                Write-Host $User.UserPrincipalName $UserLastLogon.LastLogonTime
        
    }
}

$ResultItem| Export-Csv -Encoding UTF8 -Delimiter ";" LastLogin.csv -NoTypeInformation -Append -Force
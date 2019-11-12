. ".\Connect-O365.ps1"
. ".\Get-O365Domains.ps1"
. ".\Get-O365Users.ps1"
. ".\Connect-Exchange.ps1" # Function for manipulate distribution groups is unavailable with Connect-MsolService

# Lists all domains in tenant
$domains = Get-O365Domains

foreach ($domain in $domains) {
    Write-Host "Dominio: $($domain.Name)"
    # Export all active users from domain to O365ActiveUsers-[Domain]-yyyyMMdd.csv
    $Users = Get-O365Users -Domain $domain.Name -Export

    foreach ($User in $Users) {
        $MailboxStats = Get-MailboxStatistics -Identity $User.UserPrincipalName | Select-Object ItemCount, TotalItemSize
        Write-Host "$($User.UserPrincipalName) : $($MailboxStats.TotalItemSize)"
    }
}

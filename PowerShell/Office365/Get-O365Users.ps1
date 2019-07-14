Function Get-O365Users {
    Param (
        [String] $Email = '',
        [String] $Domain = '',
        [String] $a = '',
        [Switch] $DeletedOnly,
        [Switch] $DisabledOnly
    )
    If ($DeletedOnly) {
        $Users = Get-MsolUser `
            -ReturnDeletedUsers

    }
    If ($DisabledOnly) {
        $Users = Get-MsolUser `
        -EnabledFilter DisabledOnly
    }
    If ($Users -eq $null) {
        $Users = Get-MsolUser `
            -UserPrincipalName $Email `
            -DomainName $Domain
    }
    # Else {
            #     $Users = Get-MsolUser `
            #         -EnabledFilter EnabledOnly
            #         Get-MsolUser
            #         [-ReturnDeletedUsers]
            #         [-City <String>]
            #         [-Country <String>]
            #         [-Department <String>]
            #         [-DomainName <String>]
            #         [-EnabledFilter <UserEnabledFilter>]
            #         [-State <String>]
            #         [-Synchronized]
            #         [-Title <String>]
            #         [-HasErrorsOnly]
            #         [-LicenseReconciliationNeededOnly]
            #         [-UnlicensedUsersOnly]
            #         [-UsageLocation <String>]
            #         [-SearchString <String>]
            #         [-MaxResults <Int32>]
            #         [-TenantId <Guid>]
            #         [<CommonParameters>]
            # }
            Return $Users | Sort-Object -Property DisplayName
        }


. .\Connect-O365.ps1
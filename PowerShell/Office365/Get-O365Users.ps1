function Get-O365Users {
    Param
    (
        [PSDefaultValue(Help = 'opty.com.br')]
        [String] $Domain = 'opty.com.br',
        [String] $Department = '',
        [String] $Title = '',
        [String] $City = '',
        [String] $State = '',
        [switch] $Export
    )
    Write-Host "Processamento iniciado às " (Get-Date)
    $CSVFilename = "O365ActiveUsers-" + (Get-Date -Format "yyyyMMddhhmm") + ".csv"
    #Connect-MsolService
    $Users = Get-MsolUser -DomainName $Domain -Department $Department -Title $Title -City $City -State $State -EnabledFilter EnabledOnly -All | `
        Sort-Object -Property DisplayName
    If ($Export) {
        $Users | Export-Csv -Path $CSVFilename -Encoding UTF8 -Delimiter ";" -NoTypeInformation
        Write-Host "Arquivo gerado: $CSVFilename"
    }
    Return $Users
}

#. .\Connect-O365.ps1
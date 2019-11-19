function Create-LocalAdministrator {
    param (
        [ValidateScript( {
                if (Test-Connection -ComputerName $_ -Quiet -Count 1) {
                    $true
                }
                else {
                    throw "O computador $($_) não está disponível."
                }
            })]
        [string[]]$ComputerName,
        
        [switch]$whatIf = $False
    )
    
    Write-Host "Conectando ao computador $ComputerName ..." -ForegroundColor Yellow
    $RemoteUser = Read-Host "Informe seu usuário:"	
    $RemotePwd = Read-Host -assecurestring "Informe sua senha:"

    if ($whatIf) {

        $RemoteCredential = New-Object System.Management.Automation.PSCredential($RemoteUser, $RemotePwd)
        $ComputerShell = New-PSSession -ComputerName $ComputerName -Credential $RemoteCredential
 
        Invoke-Command -Session $ComputerShell -ScriptBlock { 
            New-LocalUser -Name CSI.Admin -Password  (ConvertTo-SecureString -String 'pwd@0pt1' -AsPlainText -Force) -PasswordNeverExpires 
            Get-LocalUser -Name 'CSI.Admin' | Set-LocalUser -FullName 'Administrador Local CSI'
            Get-LocalUser -Name 'CSI.Admin' | Add-LocalGroupMember -Group 'Administradores'
        }
    }
}

Create-LocalAdministrator -ComputerName TI -whatIf $True
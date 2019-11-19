New-LocalUser -Name CSI.Admin -Password  (ConvertTo-SecureString -String 'pwd@0pt1' -AsPlainText -Force) -PasswordNeverExpires 
Get-LocalUser -Name 'CSI.Admin' | Set-LocalUser -FullName 'Administrador Local CSI'
Get-LocalUser -Name 'CSI.Admin' | Add-LocalGroupMember -Group 'Administradores'
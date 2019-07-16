<#
 .SYNOPSIS
    Obtem os tickets das ligações telefônicas da plataforma Nexcore NCall
 .DESCRIPTION
    Conecta ao FTP da Nexcore e faz o download dos arquivos das ligações telefônicas.
    Deve ser agendado para execução diária, após 07:30
    Este script faz parte do fluxo de dados que alimenta o Azure SQL Server a partir de pipeline no Azure Data Factory
 .EXAMPLE
    .\Get-PhoneCallsTickets.ps1
#>

function Connect-FTPServer {
    # Conecta ao servidor FTP utilizando a biblioteca do WinSCP
    # Requer a biblioteca do WinSCP
    try {
        Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"
        # Exemplo do arquivo SessionProperties.ps1
        #
        # @{
        #   Protocol = [WinSCP.Protocol]::Ftp
        #   HostName = "ip_servidor"
        #   UserName = "meu_usuario"
        #   Password = 'minha_senha'
        # }
        $SessionProperties = (Get-Content $PSScriptRoot\SessionProperties.ps1 | Out-String)
        $SessionOptions = New-Object WinSCP.SessionOptions -Property (Invoke-Expression $SessionProperties)
    }
    catch {
        Write-Host "Error: $($_.Exception.Message)"
        exit 1
    }
    Return $SessionOptions
}

try
{
    $localPath = "C:\Nexcore"
    $destinationPath = "C:\Nexcore\Atualizado"
    Remove-Item C:\Nexcore\Atualizado\*.*

    Connect-FTPServer
    $partialFileNames = @("BilheteLigacoes", "AgentesPorHora", "AgentesPorDia", "FilasPorHora")

    foreach ($partialFileName in $partialFileNames) {
        Write-Host "Vou processar $partialFileName"
        $session = New-Object WinSCP.Session
        Get-NexcoreFiles  $sessionOptions  $localPath  $session $partialFileName
        Move-LastNexcoreFile $localPath  $destinationPath $partialFileName
    }


}
catch
{
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}

# Load WinSCP .NET assembly
function Get-NexcoreFiles {
    param (
        $sessionOptions,
        $localPath,
        $session,
        $partialFileName
    )
    try {
        # Connect
        $session.Open($sessionOptions)

        # Recuperar todos os diretorios a partir do root
        # $localPath = "C:\Nexcore\Atualizado\"
        $remotePath = "/"
        $mask = "*.csv"

        # Enumerate files and directories to download
        $fileInfos =
            $session.EnumerateRemoteFiles(
                $remotePath, "*$($partialFileName)*",
                ([WinSCP.EnumerationOptions]::EnumerateDirectories -bor
                    [WinSCP.EnumerationOptions]::AllDirectories))

        # Iterate over directories
        foreach ($fileInfo in $fileInfos)
        {
            $localFilePath =
                [WinSCP.RemotePath]::TranslateRemotePathToLocal(
                    $fileInfo.FullName, $remotePath, $localPath)

            if ($fileInfo.IsDirectory)
            {
                # Create local subdirectory, if it does not exist yet
                if (!(Test-Path $localFilePath))
                {
                    New-Item $localFilePath -ItemType directory | Out-Null
                }
            }

            Write-Host "Checking file $($fileInfo.FullName)..."
            if ( ($fileInfo.LastWriteTime -ge $(Get-Date -Hour 0 -Minute 0 -Second 0)) -and ($fileInfo.FullName -like "*$($partialFileName)*" ))
            {
                Write-Host "Downloading file $($fileInfo.FullName)..."
                # Download file
                $remoteFilePath = [WinSCP.RemotePath]::EscapeFileMask($fileInfo.FullName)
                $transferResult = $session.GetFiles($remoteFilePath, $localFilePath)

                # Did the download succeeded?
                if (!$transferResult.IsSuccess)
                {
                    # Print error (but continue with other files)
                    Write-Host (
                        "Error downloading file $($fileInfo.FullName): " +
                        "$($transferResult.Failures[0].Message)")
                }
            }
        }

    }
    catch {
       Write-Verbose $_.Exception.Message
       Write-Output "1"
    }
    finally {
        # Disconnect, clean up
        $session.Dispose()
    }
}

function Move-LastNexcoreFile {
    param (
        $localPath,
        $destinationPath,
        $partialFileName
    )
    $filePattern = ($localPath + "\*" + $partialFileName + "*.csv")
    Get-ChildItem -Path $filePattern -File -Recurse |
    Where-Object {$_.LastWriteTime -ge $(Get-Date -Hour 0 -Minute 0 -Second 0)} |
    ForEach-Object { Move-Item -Path $_.FullName -Destination ($destinationPath + "\$($partialFileName)" + $(Split-Path -Path $_.DirectoryName -Leaf) + ".csv")}
    # ForEach-Object {  }
}



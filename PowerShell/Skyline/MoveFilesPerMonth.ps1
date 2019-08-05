$files = Get-ChildItem -Path $root -Recurse
#Decobrir Região

#Centro-Oeste
#Sul
#Sudeste
#Nordeste

#Decobrir Unidade

#Descobrir Conta Corrente

#Descobrir Mês do Arquivo
$root = ''


foreach ($file in $files){
    $Region = "CENTRO OESTE"
    $unity = "HOB"
    $Banco = "BANCO DO BRASIL"
    $ContaCorrente = "215000X"
    $dirName = ("$root" + "\" + "$Region" + "\" + "$unity" + "\" + "$Banco" + "\" + "$ContaCorrente" + "\" + "$Month")

    if (!(Test-Path $dirName)) {
        New-Item -Path $root -Name $dirName -ItemType Directory
    }

    Move-Item -Path $file.FullName -Destination $dirName
}



#Centro Oeste
#   Taguatinga
#       Banco do Brasil
#           16015-6
#               Jan
#       Santander
#           13000702-9
#               Jan
#       23770-09(Bradesco)
#           Jan
#   HOB
#   ContactGel
#   Allvisiong
#   INOB
#   ClinicaOftalmo
--Consulta para verificar as contas e as coligações
--select * from gcc_colig
---------------------------------------------------------------------------------
 
update ipg
set IPG_GCC_COD_COLIG = 'DHI' --Conta Pagante
where ipg.ipg_cpg_serie in (120, 1120, 119, 1119)
and ipg.ipg_cpg_num =
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = '1') --Código de Origem
 
---------------------------------------------------------------------------------
 
update ipg
set IPG_GCC_COD_COLIG = '4' --Conta Pagante
where ipg.ipg_cpg_serie in (120, 1120, 119, 1119)
and ipg.ipg_cpg_num = 
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = '16') --Código de Origem
 
---------------------------------------------------------------------------------
 
update ipg
set IPG_GCC_COD_COLIG = 'DHI' --Conta Pagante
where ipg.ipg_cpg_serie in (120, 1120, 119, 1119)
and ipg.ipg_cpg_num = 
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = '3') --Código de Origem
 
---------------------------------------------------------------------------------
 
update ipg
set IPG_GCC_COD_COLIG = '4' --Conta Pagante
where ipg.ipg_cpg_serie in (120, 1120, 119, 1119)
and ipg.ipg_cpg_num = 
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = '4') --Código de Origem
 
---------------------------------------------------------------------------------
 
update ipg
set IPG_GCC_COD_COLIG = 'DHI' --Conta Pagante
where ipg.ipg_cpg_serie in (120, 1120, 119, 1119)
and ipg.ipg_cpg_num = 
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = '9') --Código de Origem

---------------------------------------------------------------------------------

update ipg
set IPG_GCC_COD_COLIG = 'DHI' --Conta Pagante
where ipg.ipg_cpg_serie in (120, 1120, 119, 1119)
and ipg.ipg_cpg_num = 
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = 'DH4') --Código de Origem
 
---------------------------------------------------------------------------------
 
update ipg
set IPG_GCC_COD_COLIG = 'DHI' --Conta Pagante
where ipg.ipg_cpg_serie in (120, 1120, 119, 1119)
and ipg.ipg_cpg_num = 
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = 'DHI') --Código de Origem

---------------------------------------------------------------------------------
/*
SELECT IPG_GCC_COD_COLIG = 'DHI' --Conta Pagante
    , ipg.ipg_cpg_serie
    , ipg.ipg_cpg_num
    , cpg.cpg_num

FROM ipg
    , cpg
WHERE ipg.ipg_cpg_serie in (119, 1119)
    and convert(varchar(10), IPG_DT_PGTO, 103) = convert(varchar(10), getdate(), 103)
    and ipg.ipg_cpg_num = 
        (select cpg_num
        from cpg
        where cpg.cpg_serie = ipg_cpg_serie
            and cpg.cpg_num = ipg_cpg_num
            and cpg_gcc_cod = 'DHI') --Código de Origem



SELECT IPG_GCC_COD_COLIG = 'DHI' --Conta Pagante
where ipg.ipg_cpg_serie in (119, 1119)
and convert(varchar(10), IPG_DT_PGTO, 103) = convert(varchar(10), getdate(), 103)
and ipg.ipg_cpg_num = 
(select cpg_num
from cpg
where cpg.cpg_serie = ipg_cpg_serie
and cpg.cpg_num = ipg_cpg_num
and cpg_gcc_cod = 'DHI') --Código de Origem
*/
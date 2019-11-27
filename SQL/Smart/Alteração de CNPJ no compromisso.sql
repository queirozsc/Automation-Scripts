--Alteração de CNPJ na tela de Compromissos a Pagar na Tesouraria
update cpg 
set cpg_cic_rg = '12019360000114'
where cpg_num = 8958
and cpg_serie = 119


update cpg 
set CPG_EMP_COD = '1270'
where cpg_num = 8958
and cpg_serie = 119
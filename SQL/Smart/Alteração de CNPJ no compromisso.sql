--Alteração de CNPJ na tela de Compromissos a Pagar na Tesouraria
update cpg 
set cpg_cic_rg = '47960950110067'
where cpg_num = 4889
and cpg_serie = 119


update cpg 
set CPG_EMP_COD = '3527'
where cpg_num = 4889
and cpg_serie = 119

SELECT * FROM cpg WHERE cpg_num = 4889 AND cpg_serie = 119

SELECT * FROM emp WHERE emp_cgc = '47960950110067'
SELECT lct_lote  
FROM lct 
WHERE lct_cpg_num IN (12694,12692,12791)

-----------------------------------------------------

SELECT distinct lct_lote 
FROM LCT
WHERE lct_cpg_num IN (12694,12692,12791)

-----------------------------------------------------

DELETE 
FROM LCT
WHERE lct_cpg_num IN (12694,12692,12791)

-----------------------------------------------------

SELECT ipg.ipg_cpg_num
FROM ipg
    LEFT JOIN bcp ON ipg.ipg_bcp_serie = bcp.bcp_serie AND ipg.ipg_bcp_num = bcp.bcp_num, cpg
    LEFT JOIN tpg ON cpg.cpg_tpg_cod = tpg.tpg_cod, gcc
WHERE 1 = 1
    AND (cpg.cpg_serie = ipg.ipg_cpg_serie)
    AND (cpg.cpg_num = ipg.ipg_cpg_num)
    AND (gcc.gcc_cod = cpg.cpg_gcc_cod)
    AND ((ipg.ipg_status IN ('R', 'P'))
    AND (ipg.ipg_dt_pgto >= '2019-09-01 00:00:00.000')
    AND (ipg.ipg_dt_pgto <= '2019-09-20 23:59:59.000')
    AND (cpg.cpg_tipo_compromisso LIKE 'G')
    AND (cpg.cpg_fis_jur LIKE '%')
    AND (cpg.cpg_credor LIKE '%')
    AND (cpg.cpg_gcc_cod LIKE '9' OR (ipg.ipg_gcc_cod_colig = '9'))
    AND (cpg.cpg_serie_darf IS NULL)
    AND (cpg.cpg_num_darf IS NULL))
    AND (ipg_status <> 'P')

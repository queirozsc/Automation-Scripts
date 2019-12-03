-- Consulta para verificar compromissos que não contabilizaram

SELECT * 
FROM    cpg, ipg
        --WHERE cpg_num = '14769' 
        --and cpg_serie = '119'
WHERE   cpg_num = ipg_cpg_num
        AND cpg_serie = ipg_cpg_serie
        AND cpg_dt_reg between '2019-10-01 00:00:00.000' AND '2019-11-27 00:00:00.000'
        --and cpg_num = 3423
        AND cpg_tipo_compromisso not in ('I')
        AND ipg_status not in ('C')
        AND cpg_num not in

        (SELECT DISTINCT lct_cpg_num FROM lct 
        --WHERE lct_cpg_num = '14116' 
        --AND lct_cpg_serie = '119'
        --and LCT_DTHR between '2019-10-01 00:00:00.000' and '2019-10-31 00:00:00.000'
        --and LCT_LOTE = 88992
        WHERE lct_cpg_num IS NOT NULL)


SELECT * FROM LCT WHERE lct_cpg_serie = '1119' AND lct_cpg_num = '3239'



select top 10 * from cpg where CPG_EXPORT_CONTAB like 'S'
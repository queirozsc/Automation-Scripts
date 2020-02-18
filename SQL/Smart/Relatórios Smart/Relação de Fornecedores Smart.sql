SELECT  emp.emp_cgc as 'CPF_CNPJ'
        , emp.emp_nome_fantasia as 'NOME_PESSOA'
        , CASE WHEN (emp.emp_fis_jur = 'J' OR (LEN(emp.emp_cgc) = 14)) THEN 'Jurídica'
               WHEN (emp.emp_fis_jur = 'F' OR (LEN(emp.emp_cgc) = 11)) THEN 'Física'
          END AS 'TIPO_PESSOA'
        , 'Itaigara' as EMPRESA
FROM emp emp
WHERE emp.emp_status NOT IN ('I','S')
    AND emp.emp_cgc IN (SELECT emp.emp_cgc FROM emp emp GROUP BY emp.emp_cgc HAVING COUNT(1) > 1)
ORDER BY emp.emp_cgc



SELECT  emp.emp_cgc as 'CNPJ_CPF'
        , fne.FNE_NOME_FANTASIA as 'NOME_PESSOA'
        , CASE WHEN (emp.emp_fis_jur = 'J' OR (LEN(emp.emp_cgc) = 14)) THEN 'Jurídica'
               WHEN (emp.emp_fis_jur = 'F' OR (LEN(emp.emp_cgc) = 11)) THEN 'Física'
          END AS 'TIPO_PESSOA'
        , CASE WHEN fne.FNE_TIPO = 'FO' THEN 'Fornecedor'
               WHEN fne.FNE_TIPO = 'FT' THEN 'Forn_Transportador'
               WHEN fne.FNE_TIPO = 'TR' THEN 'Transportador'
               WHEN fne.FNE_TIPO = 'FF' THEN 'Forn_Fabricante'  
          END AS 'TIPO'
        , CASE WHEN fne.FNE_STATUS = 'A' THEN 'Ativo'
               WHEN fne.FNE_STATUS = 'I' THEN 'Inativo'
          END AS 'STATUS'
        , 'Itaigara' as EMPRESA
FROM    fne
        LEFT JOIN emp
            ON fne.FNE_COD = emp.emp_fne_cod
WHERE   (fne.FNE_DEL_LOGICA IS NULL OR (fne.FNE_DEL_LOGICA = 'N'))
        AND emp.emp_cgc IN ((SELECT emp.emp_cgc FROM emp emp GROUP BY emp.emp_cgc HAVING COUNT(1) > 1) OR 
        AND fne.FNE_NOME_FANTASIA in (SELECT fne.FNE_NOME_FANTASIA FROM FNE fne GROUP BY fne.FNE_NOME_FANTASIA HAVING COUNT(1) > 1)
ORDER BY 1 ASC



SELECT fne.FNE_NOME_FANTASIA, COUNT(1) as quantidade 
FROM   FNE fne
GROUP BY FNE_NOME_FANTASIA HAVING COUNT(1) > 1
OR
SELECT emp.emp_cgc
FROM emp emp
GROUP BY emp.emp_cgc HAVING COUNT(1) > 1


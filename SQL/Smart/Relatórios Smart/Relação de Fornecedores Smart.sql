---------------------------RELAÇÃO DE FORNECEDORES SMART---------------------------

--Fornecedores Itaigara
SELECT  emp_cgc as 'CPF_CNPJ'
        , emp_nome_fantasia as 'NOME_PESSOA'
        , CASE WHEN (emp_fis_jur = 'J' OR (LEN(emp_cgc) = 14)) THEN 'Jurídica'
               WHEN (emp_fis_jur = 'F' OR (LEN(emp_cgc) = 11)) THEN 'Física'
          END AS 'TIPO_PESSOA'
        , 'Itaigara' as EMPRESA
FROM emp
WHERE emp_status NOT IN ('I','S')
ORDER BY 2
-----------------------------------------------------------------------------------
--Fornecedores Itabuna
SELECT  emp_cgc as 'CPF_CNPJ'
        , emp_nome_fantasia as 'NOME_PESSOA'
        , CASE WHEN (emp_fis_jur = 'J' OR (LEN(emp_cgc) = 14)) THEN 'Jurídica'
               WHEN (emp_fis_jur = 'F' OR (LEN(emp_cgc) = 11)) THEN 'Física'
          END AS 'TIPO_PESSOA'
        , 'Itabuna' as EMPRESA
FROM emp
WHERE emp_status NOT IN ('I','S')
ORDER BY 2
-----------------------------------------------------------------------------------
--Fornecedores IOF
SELECT  emp_cgc as 'CPF_CNPJ'
        , emp_nome_fantasia as 'NOME_PESSOA'
        , CASE WHEN (emp_fis_jur = 'J' OR (LEN(emp_cgc) = 14)) THEN 'Jurídica'
               WHEN (emp_fis_jur = 'F' OR (LEN(emp_cgc) = 11)) THEN 'Física'
          END AS 'TIPO_PESSOA'
        , 'IOF' as EMPRESA
FROM emp
WHERE emp_status NOT IN ('I','S')
ORDER BY 2
-----------------------------------------------------------------------------------
--Fornecedores HOSL
SELECT  emp_cgc as 'CPF_CNPJ'
        , emp_nome_fantasia as 'NOME_PESSOA'
        , CASE WHEN (emp_fis_jur = 'J' OR (LEN(emp_cgc) = 14)) THEN 'Jurídica'
               WHEN (emp_fis_jur = 'F' OR (LEN(emp_cgc) = 11)) THEN 'Física'
          END AS 'TIPO_PESSOA'
        , 'HOSL' as EMPRESA
FROM emp
WHERE emp_status NOT IN ('I','S')
ORDER BY 2
-----------------------------------------------------------------------------------
--Fornecedores Oftalmoclin
SELECT  emp_cgc as 'CPF_CNPJ'
        , emp_nome_fantasia as 'NOME_PESSOA'
        , CASE WHEN (emp_fis_jur = 'J' OR (LEN(emp_cgc) = 14)) THEN 'Jurídica'
               WHEN (emp_fis_jur = 'F' OR (LEN(emp_cgc) = 11)) THEN 'Física'
          END AS 'TIPO_PESSOA'
        , 'Oftalmoclin' as EMPRESA
FROM emp
WHERE emp_status NOT IN ('I','S')
ORDER BY 2
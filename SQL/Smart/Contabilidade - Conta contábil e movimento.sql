-- Consulta para verificar as movimentações realizadas com conta corrente selecionada
SELECT mcc_cct_cod, * 
FROM mcc 
WHERE mcc_ccr = '20002' 
    AND mcc_tipo = 'P' 
    AND mcc_cct_cod is not null
    AND mcc_cct_cod = 280

-- Consulta para verificar as movimentações sem conta corrente
SELECT mcc_cct_cod, * 
FROM mcc
WHERE mcc_ccr = '20002' 
    AND mcc_tipo = 'P' 
    AND mcc_cct_cod is null

-- Consulta para verificar todos os movimentos relacionados a conta corrente selecionada
SELECT mcc_cct_cod, * 
FROM mcc
WHERE mcc_cct_cod = 1

-- Update para alterar as movimentações e deixar sem conta corrente
UPDATE mcc
SET mcc_cct_cod = null
WHERE mcc_ccr = '20002' 
    AND mcc_tipo = 'P' 
    AND mcc_cct_cod is not null
    AND mcc_cct_cod = 280

-- Delete da conta contábil
DELETE 
FROM cct 
WHERE cct_cod = 1

-- Consulta para verificar as movimentações realizadas com conta corrente selecionada
SELECT mcc_cct_cod, * 
FROM mcc 
WHERE mcc_ccr = '88260' 
    AND mcc_tipo = 'P' 
    AND mcc_cct_cod is not null

-- Consulta para verificar as movimentações sem conta corrente
SELECT mcc_cct_cod, * 
FROM mcc
WHERE mcc_ccr = '88260' 
    AND mcc_tipo = 'P' 
    AND mcc_cct_cod is null

-- Consulta para verificar todos os movimentos relacionados a conta corrente selecionada
SELECT mcc_cct_cod, * 
FROM mcc 
WHERE mcc_cct_cod = 281

-- Update para alterar as movimentações e deixar sem conta corrente
UPDATE mcc
SET mcc_cct_cod = null
WHERE mcc_ccr = '88260' 
    AND mcc_tipo = 'P' 
    AND mcc_cct_cod is not null

-- Delete da conta contábil
DELETE 
FROM cct 
WHERE cct_cod = 281
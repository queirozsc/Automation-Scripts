--Consulta para selecionar os lançamento que será alterado o status, seja para cancelado ou ativo
SELECT * 
FROM LCT
WHERE LCT_LOTE = 37433
    AND LCT_SEQ IN (6)

--Update para mudança de status do lançamento, seja para cancelado ou ativo
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 37433
    AND LCT_SEQ IN (6)

--Consulta para descobrir o nnúmero do lote
SELECT * FROM LCT WHERE lct_cpg_num = 783 AND lct_cpg_serie = 120

----------------------------------------------------------------------------------------------------------------
--Oftalmoclin

UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 23248
    AND LCT_SEQ IN (6)

UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 24794
    AND LCT_SEQ IN (3)

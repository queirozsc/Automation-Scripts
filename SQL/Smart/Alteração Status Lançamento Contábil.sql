--Consulta para selecionar os lançamento que será alterado o status, seja para cancelado ou ativo
SELECT * 
FROM LCT
WHERE LCT_LOTE = 84004
    AND LCT_SEQ IN (3)

--Update para mudança de status do lançamento, seja para cancelado ou ativo
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 84004
    AND LCT_SEQ IN (3)
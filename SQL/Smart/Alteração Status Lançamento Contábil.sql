--Consulta para selecionar os lançamento que será alterado o status, seja para cancelado ou ativo
SELECT * 
FROM LCT
WHERE LCT_LOTE = 85328
    AND LCT_SEQ IN (4,5)

--Update para mudança de status do lançamento, seja para cancelado ou ativo
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 85328
    AND LCT_SEQ IN (4,5)
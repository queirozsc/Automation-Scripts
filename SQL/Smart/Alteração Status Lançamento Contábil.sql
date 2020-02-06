--Consulta para selecionar os lançamento que será alterado o status, seja para cancelado ou ativo
SELECT * 
FROM LCT
WHERE LCT_LOTE = 114372
    AND LCT_SEQ IN (3)

--Update para mudança de status do lançamento, seja para cancelado ou ativo
UPDATE LCT
SET LCT_DEL_LOGICA = 'N'
WHERE LCT_LOTE = 84004
    AND LCT_SEQ IN (3)

--Consulta para descobrir o nnúmero do lote
SELECT * FROM LCT WHERE lct_cpg_num = 1175 AND lct_cpg_serie = 120
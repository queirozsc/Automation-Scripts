--Consulta para selecionar os lançamento que será alterado o status, seja para cancelado ou ativo
SELECT * 
FROM LCT
WHERE LCT_LOTE = 102363
    AND LCT_SEQ IN (3)

--Update para mudança de status do lançamento, seja para cancelado ou ativo
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 102363
    AND LCT_SEQ IN (6)

--Consulta para descobrir o nnúmero do lote
SELECT * FROM LCT WHERE lct_cpg_num = 17361 AND lct_cpg_serie = 119

------------------------------------------------------------------------------------------
--Compromissos com falha HOSL

--Compromisso: 119.11524
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 83232
    AND LCT_SEQ IN (3)

--Compromisso: 119.11391
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 83164
    AND LCT_SEQ IN (3)

--Compromisso: 119.10884
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 80976
    AND LCT_SEQ IN (6)
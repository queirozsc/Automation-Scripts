--Consulta para selecionar os lançamento que será alterado o status, seja para cancelado ou ativo
SELECT * 
FROM LCT
WHERE LCT_LOTE = 83666
    AND LCT_SEQ IN (1,2,3,5,6)

--Update para mudança de status do lançamento, seja para cancelado ou ativo
UPDATE LCT
SET LCT_DEL_LOGICA = 'S'
WHERE LCT_LOTE = 83666
    AND LCT_SEQ IN (7)

--Consulta para descobrir o nnúmero do lote
SELECT * FROM LCT WHERE lct_cpg_num = 11673 AND lct_cpg_serie = 119

--119.10891 HOSL LCT 81172
--119.11673 HOSL LCT 83999
--119.3808 OFTALMOLCIN

DELETE 
FROM LCT
WHERE LCT_LOTE = 30787
    AND LCT_SEQ IN (1,2,3,5,6)
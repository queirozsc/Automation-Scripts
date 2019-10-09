--Alteração de status de compromisso:
UPDATE IPG
SET IPG_STATUS = 'C'
WHERE IPG_CPG_NUM = 8866

--Consulta do título:
SELECT * FROM IPG WHERE IPG_CPG_NUM = 8866
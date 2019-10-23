--Coluna faltando no banco
SELECT fic_rev_fne_cod_old, * FROM fic

--Comando para inserir a coluna
ALTER TABLE fic ADD fic_rev_fne_cod_old VARCHAR(20) NULL

--Comando para remover a coluna
ALTER TABLE fic DROP COLUMN fic_rev_fne_cod_old
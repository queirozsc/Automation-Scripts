--Coluna faltando no banco
SELECT cct_sped_nat_rec_pis_confins, * FROM cct

--Comando para inserir a coluna
ALTER TABLE cct ADD cct_sped_nat_rec_pis_confins int NULL

--Comando para remover a coluna
ALTER TABLE cct DROP COLUMN cct_sped_nat_rec_pis_confins
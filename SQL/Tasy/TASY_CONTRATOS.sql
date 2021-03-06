SELECT A. CD_CGC_CONTRATADO CNPJ
    , A.NR_SEQUENCIA SEQUENCIA
    , UPPER(A.DS_TITULO_CONTRATO) TITULO
    , UPPER(A.DS_OBJETO_CONTRATO) OBJETO
    , A.DT_INICIO INICIO
    , A.DT_FIM FIM
    , A.QT_DIAS_RESCISAO DIAS_RESCISAO
    , A.VL_TOTAL_CONTRATO VALOR_TOTAL
    , UPPER(B.DS_RAZAO_SOCIAL) RAZAO_SOCIAL
    , UPPER(B.NM_FANTASIA) NOME_FANTASIA
    , UPPER(C.NM_FANTASIA_ESTAB) ESTABELECIMENTO
    , UPPER(D.NM_PESSOA_FISICA) RESPONSAVEL
    , E.VL_PAGTO VALOR_ITEM
    , UPPER(F.DS_MATERIAL) MATERIAL
    , UPPER(DS_CENTRO_CUSTO) CENTRO_CUSTO
FROM CONTRATO A
    INNER JOIN PESSOA_JURIDICA B
        ON A.CD_CGC_CONTRATADO = B.CD_CGC
    INNER JOIN ESTABELECIMENTO C
        ON A.CD_ESTABELECIMENTO = C.CD_ESTABELECIMENTO
    INNER JOIN PESSOA_FISICA D
        ON A.CD_PESSOA_RESP = D.CD_PESSOA_FISICA
    INNER JOIN CONTRATO_REGRA_NF E
        ON A.NR_SEQUENCIA = E.NR_SEQ_CONTRATO
    INNER JOIN MATERIAL F
        ON E.CD_MATERIAL = F.CD_MATERIAL
    INNER JOIN CENTRO_CUSTO G
        ON E.CD_CENTRO_CUSTO = G.CD_CENTRO_CUSTO
WHERE A.IE_SITUACAO  = 'A'
--AND A.NR_SEQUENCIA = 527
AND E.CD_MATERIAL IN (75969, 76092, 76202, 76205, 76209, 76210, 76346, 76366, 76685)

SELECT *
FROM CONTRATO
WHERE NR_SEQUENCIA = 527

SELECT *
FROM CONTRATO_REGRA_NF
WHERE CD_MATERIAL IN (76346, 75969, 76092, 76205, 76209, 76366)

SELECT *
FROM PESSOA_JURIDICA
WHERE CD_CGC = '05330384000124'

SELECT *
FROM ESTABELECIMENTO

SELECT *
FROM PESSOA_FISICA
WHERE CD_PESSOA_FISICA = 504090

SELECT *
FROM MATERIAL
WHERE CD_MATERIAL = 76346

SELECT *
FROM CENTRO_CUSTO
WHERE CD_CENTRO_CUSTO = 1803
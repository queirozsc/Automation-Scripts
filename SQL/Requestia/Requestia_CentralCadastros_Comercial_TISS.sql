--Insert de informações na tabela REQ_WKF_ATUALIZACAOTISS
/*
SELECT R.REQUEST CHAMADO
    , R.MARCA
    , R.SIGLA_UNIDADE SIGLA
    , R.UNIDADE_ATENDIMENTO UNIDADE
    , CONVERT(VARCHAR(10), R.ABERTURA, 103) ABERTURA
    , UPPER(R.CLIENT) SOLICITANTE
    , UPPER(R.PROCESS) PROCESSO
    , UPPER(R.RSTATUS) SITUACAO
    , UPPER(R.CURRANAL) ANALISTA
    , FORMAT(R.[%_SLA], 'P') SLA
    , CONVERT(VARCHAR(10), R.ULTIMA_ACAO, 103) ULTIMA_ACAO
    , UPPER(A1.QANSWER) CONVENIO
    , CONVERT(VARCHAR(10), CONVERT(DATE, A2.QANSWER, 111), 103) SOLICITACAO
    , UPPER(A3.QANSWER) DESCRICAO
    , UPPER(A4.QANSWER) SISTEMA
INTO REQ_WKF_ATUALIZACAOTISS
FROM REQUESTIA_REQUESTS R
    LEFT JOIN REQUESTIA_QANSWER A1
        ON R.QSESSIONFORM = A1.QSESSION AND A1.QUESTION = 'CAD_Atualiza_TISS_RazSoc' 
        OR A1.QUESTION = 'CAD_CONVENIO_TASY'
        OR A1.QUESTION = 'CAD_CONVENIO_SMART'
    LEFT JOIN REQUESTIA_QANSWER A2
        ON R.QSESSIONFORM = A2.QSESSION AND A2.QUESTION = 'CAD_CLIENTE_DataSolici'
    LEFT JOIN REQUESTIA_QANSWER A3
        ON R.QSESSIONFORM = A3.QSESSION AND A3.QUESTION = 'CAD_Atualizacao_TISS_Desc'
    LEFT JOIN REQUESTIA_QANSWER A4
        ON R.QSESSIONFORM = A4.QSESSION AND A4.QUESTION = 'CAD_PAD_Sistema'
WHERE R.CATEGORY = 'Central de Cadastros'
AND R.PRODUCT = 'Cadastro Comercial'
AND R.PROCESS LIKE '%TISS%'
*/
--CREATE TABLE REQ_WKF_ATUALIZACAOTISS
--Drop Table REQ_WKF_ATUALIZACAOTISS
/*
DROP TABLE REQ_WKF_ATUALIZACAOTISS
SELECT * 
FROM REQ_WKF_ATUALIZACAOTISS
ORDER BY 1 DESC
*/

--SELECTS
/*
SELECT TOP 100 * FROM REQUESTIA_QSESSION
SELECT TOP 100 * FROM REQUESTIA_QTABLEANSWER
SELECT TOP 100 * FROM REQUESTIA_REQUESTS
SELECT TOP 100 * FROM REQUESTIA_QANSWER
*/

SELECT ROW_NUMBER() OVER (ORDER BY A.REQUEST DESC) ITEM,
    A.request as CHAMADO,
    A.REQLOCATION AS LOCALIZACAO,
    A.UNIDADE_HIERARQUIA,
    A.UNIDADE_ATENDIMENTO AS UNIDADE,
    CONVERT(VARCHAR(10), A.ABERTURA, 103) AS ABERTURA,
    A.CLIENT AS SOLICITANTE,
    A.PROCESS AS PROCESSO,
    A.status as SITUACAO,
    A.curranal as ANALISTA, 
    A.TEMPO_RESOLUCAO AS SLA,
    CONVERT(VARCHAR(10), A.ULTIMA_ACAO, 103) AS ULTIMA_ACAO,
    A1.QANSWER AS CONVENIO,
    CONVERT(VARCHAR(10), CONVERT(DATE, A2.QANSWER, 111), 103) SOLICITACAO,
    UPPER(A3.QANSWER) DESCRICAO,
    UPPER(A4.QANSWER) SISTEMA
FROM requestia_requests A
    LEFT JOIN REQUESTIA_QANSWER A1 
        ON ((A1.QSESSION = A.QSESSIONFORM AND A1.QUESTION = 'CAD_CONVENIO_TASY') 
        OR ( A1.QSESSION = A.QSESSIONFORM AND A1.QUESTION = 'CAD_CONVENIO_SMART')
        OR ( A1.QSESSION = A.QSESSIONFORM AND A1.QUESTION = 'CAD_Atualiza_TISS_RazSoc'))
        AND QANSWER IS NOT NULL
    LEFT JOIN REQUESTIA_QANSWER A2
        ON A.QSESSIONFORM = A2.QSESSION AND A2.QUESTION = 'CAD_CLIENTE_DataSolici'
    LEFT JOIN REQUESTIA_QANSWER A3
        ON A.QSESSIONFORM = A3.QSESSION AND A3.QUESTION = 'CAD_Atualizacao_TISS_Desc'
    LEFT JOIN REQUESTIA_QANSWER A4
        ON A.QSESSIONFORM = A4.QSESSION AND A4.QUESTION = 'CAD_PAD_Sistema'
WHERE A.product = 'Cadastro Comercial'
ORDER BY A.REQUEST DESC
/* TABLES */
DROP TABLE Procedimentos.dbo.REQUESTIA_REQUESTS
GO
CREATE TABLE Procedimentos.dbo.REQUESTIA_REQUESTS
(
    REQUEST VARCHAR(20)
    ,  CLIENT VARCHAR(50)
    , ORIGANAL VARCHAR(100)
    , CURRANAL VARCHAR(100)
    , GROUPANAL VARCHAR(10)
    , LASTANAL VARCHAR(100)
    , LASTANLGRP VARCHAR(10)
    , ORIGGROUP VARCHAR(100)
    , CURRGROUP VARCHAR(100)
    , LASTGROUP VARCHAR(100)
    , CATEGORY VARCHAR(255)
    , PRODUCT VARCHAR(255)
    , PROCESS VARCHAR(255)
    , RSTATUS VARCHAR(100)
    , RPRIORITY VARCHAR(100)
    , REQTYPE VARCHAR(100)
    , REQSOURCE VARCHAR(100)
    , REQLOCATION VARCHAR(100)
    , ORGUNIT VARCHAR(100)
    , ORGUNIT_ROOT VARCHAR(100)
    , ABSTRACT VARCHAR(255)
    , DESCRIPT VARCHAR(255)
    , OPENDATE VARCHAR(20)
    , CLOSEDATE VARCHAR(20)
    , CLOSED VARCHAR(10)
    , LASTACTION VARCHAR(20)
    , LASTANALYST VARCHAR(20)
    , LASTSTATUS VARCHAR(20)
    , LASTPRIORITY VARCHAR(20)
    , LASTREOPEN VARCHAR(20)
    , LASTACTIONATEND VARCHAR(20)
    , LASTACTTYPE VARCHAR(20)
    , RESPDATE VARCHAR(20)
    , RESPTIME VARCHAR(20)
    , RESLTIME VARCHAR(20)
    , RESPMINS VARCHAR(10)
    , RESLMINS VARCHAR(10)
    , RESPREMAINS VARCHAR(10)
    , RESLREMAINS VARCHAR(10)
    , RESPMODE VARCHAR(10)
    , RESLMODE VARCHAR(10)
    , NOCOMPUTE VARCHAR(10)
    , APROVANLTYPE VARCHAR(10)
    , APROVCLITYPE VARCHAR(10)
    , MLEVELAPROV VARCHAR(100)
    , CLIENTAPROV VARCHAR(100)
    , PACKAGE VARCHAR(255)
    , WORKFLOW VARCHAR(255)
    , LASTSEVENT VARCHAR(100)
    , REQWORKFLOW VARCHAR(20)
    , ORIGCATEGORY VARCHAR(255)
    , ORIGPRODUCT VARCHAR(255)
    , ORIGPROCESS VARCHAR(255)
    , TOTALATTACH VARCHAR(10)
    , TOTALATTACHACT VARCHAR(10)
    , INSERTDATE VARCHAR(20)
    , QFORM VARCHAR(100)
    , QSURVEY VARCHAR(255)
    , QSESSIONFORM VARCHAR(10)
    , QSESSIONSURVEY VARCHAR(10)
    , REQUESTFLAGS VARCHAR(10)
    , V_ASSOCIATION VARCHAR(10)
    , V_HAS_APPROVER VARCHAR(10)
    , LASTSEQUENCE VARCHAR(10)
    , LASTRECALCDATE VARCHAR(20)
    , LASTAPPROVCNTX VARCHAR(100)
    , LASTAPPROVUSER VARCHAR(100)
    , LASTAPPROVCODE VARCHAR(100)
    , CURRAPPROVCODE VARCHAR(100)
    , ORIGNOCOMPUTE VARCHAR(100)
    , ORIGRSTATUS VARCHAR(100)
    , ORIGRPRIORITY VARCHAR(100)
    , [ABERTURA] DATETIME
    , [RESOLUCAO] DATETIME
    , [ULTIMA ACAO] DATETIME
    , [ULTIMO ANALISTA] DATETIME
    , [REABERTURA] DATETIME
    , [% SLA] FLOAT
    , [TEMPO SOLUCAO (H)] FLOAT
    , [SITUACAO] VARCHAR(20)
    , [SITUACAO SLA] VARCHAR(20)
    , [UNIDADE ATENDIMENTO] VARCHAR(MAX)
    , [MARCA] VARCHAR(10)
    , [SIGLA UNIDADE] VARCHAR(10)
    , [TEMPO ULTIMA ACAO (H)] FLOAT
    , [TEMPO ULTIMO ANALISTA (H)] FLOAT
    , [NIVEL] VARCHAR(5)
)
GO
DROP TABLE Procedimentos.dbo.REQUESTIA_QSESSION
GO
CREATE TABLE Procedimentos.dbo.REQUESTIA_QSESSION
(
    QSESSION VARCHAR(20)
    ,  QSESSIONTITLE VARCHAR(20)
    , QCLIENT VARCHAR(50)
    , QFORM VARCHAR(100)
    , QVERSION VARCHAR(20)
    , QSTATUS VARCHAR(10)
    , QANSWERDATE VARCHAR(20)
    , QEXPDATE VARCHAR(20)
    , QAPPLICATION VARCHAR(10)
    , QSURVEYTYPE VARCHAR(10)
    , REQLOCATION VARCHAR(10)
)
GO
DROP TABLE Procedimentos.dbo.REQUESTIA_QANSWER
GO
CREATE TABLE Procedimentos.dbo.REQUESTIA_QANSWER
(
    QSESSION VARCHAR(20)
    ,  QUESTION VARCHAR(MAX)
    , QANSWER VARCHAR(MAX)
    , QANSWERED VARCHAR(10)
    , QANSWERDATE VARCHAR(20)
    , QSHOW VARCHAR(10)
    , QORDER VARCHAR(10)
    , QUPDATED VARCHAR(10)
)
GO
CREATE TABLE Procedimentos.dbo.REQUESTIA_QTABLEANSWER
(
    QSESSION VARCHAR(20)
    ,  TABLE_NAME VARCHAR(100)
    , TABLE_ROWID VARCHAR(40)
    , TABLE_ROWNUM VARCHAR(5)
    , COLUMN_NAME VARCHAR(100)
    , COLUMN_VALUE VARCHAR(MAX)
    , COLUMN_POSITION VARCHAR(5)
    , COLUMN_ANSWERED VARCHAR(5)
    , COLUMN_ANSWERDATE VARCHAR(20)
    , COLUMN_UPDATED VARCHAR(5)
    , COLUMN_VISIBLE VARCHAR(5)
)
GO

/* INDICES */
CREATE INDEX IDX_CLOSED ON dbo.REQUESTIA_REQUESTS (CLOSED)
GO
CREATE INDEX IDX_PERCSLA ON dbo.REQUESTIA_REQUESTS ([% SLA])
GO
CREATE INDEX IDX_QSESSION ON dbo.REQUESTIA_REQUESTS (QSESSIONFORM)
GO
CREATE INDEX IDX_GROUPANAL ON dbo.REQUESTIA_REQUESTS (GROUPANAL)
GO
CREATE INDEX IDX_CPP ON dbo.REQUESTIA_REQUESTS (CATEGORY ASC, PRODUCT ASC, PROCESS ASC)
GO
CREATE INDEX IDX_QSESSION ON REQUESTIA_QANSWER (QSESSION)
GO
CREATE INDEX IDX_QSESSION ON REQUESTIA_QTABLEANSWER (QSESSION)
GO
CREATE INDEX IDX_CNPJ ON REQUESTIA_QANSWER (QSESSION ASC, QUESTION ASC)
GO

/* FUNCTIONS */
DROP FUNCTION dbo.fn_CONVERTSTR2DATETIME
GO
CREATE FUNCTION dbo.fn_CONVERTSTR2DATETIME (@STRDATE VARCHAR(19))
RETURNS DATETIME
AS
    BEGIN
        DECLARE @RESULT DATETIME

        SET @RESULT = SUBSTRING(@STRDATE, 1, 4) + '-' + SUBSTRING(@STRDATE, 5, 2) + '-' + SUBSTRING(@STRDATE, 7, 2) + 'T' + SUBSTRING(@STRDATE, 9, 2) + ':' + SUBSTRING(@STRDATE, 11, 2) + ':' + SUBSTRING(@STRDATE, 13, 2)
        RETURN @RESULT
    END
GO
DROP FUNCTION dbo.fn_GETTOTALWORKINGHOURS
GO
CREATE FUNCTION dbo.fn_GETTOTALWORKINGHOURS (@DATEFROM DATETIME, @DATETO DATETIME)
RETURNS DECIMAL(18,2)
AS
    BEGIN
        DECLARE @TOTALWORKDAYS INT, @TOTALTIMEDIFF DECIMAL(18, 2)

        -- CALCULATE DIFFERENCE IN DAYS
        SET @TOTALWORKDAYS = DATEDIFF(DAY, @DATEFROM, @DATETO)
                            - (DATEDIFF(WEEK, @DATEFROM, @DATETO) * 2)
                            - CASE WHEN DATENAME(WEEKDAY, @DATEFROM) = 'Sunday' THEN 1 ELSE 0 END
                            + CASE WHEN DATENAME(WEEKDAY, @DATETO) = 'Saturday' THEN 1 ELSE 0 END;
        -- CALCULATE DIFFERENCE IN HOURS
        SET @TOTALTIMEDIFF = ( SELECT DATEDIFF(SECOND, (SELECT CONVERT(TIME, @DATEFROM)), (SELECT CONVERT(TIME, @DATETO)) ) / 3600.0);

        -- NOTE: CONSIDERING 09 BUSSINESS HOURS PER DAY
        RETURN  (SELECT(@TOTALWORKDAYS * 9.00) + @TOTALTIMEDIFF)
    END
GO


/* PROCEDURES */
DROP PROCEDURE dbo.sp_TRUNCATEREQUESTS
GO
CREATE PROCEDURE dbo.sp_TRUNCATEREQUESTS
AS
    DECLARE @dayName VARCHAR(9);
    SET @dayName = DATENAME(DW, GETDATE())
    
    TRUNCATE TABLE dbo.REQUESTIA_REQUESTS;
    TRUNCATE TABLE dbo.REQUESTIA_QSESSION;
    TRUNCATE TABLE dbo.REQUESTIA_QANSWER;
    TRUNCATE TABLE dbo.REQUESTIA_QTABLEANSWER;

    -- MICROSOFT FLOW RUNS ONLY ON MONDAYS THEN SKIP EXECUTION ON ANOTHER DAYS
    IF(@dayName = 'Sunday') 
        DROP TABLE dbo.REQ_WKF_CAPEXNFD; -- AUTO CREATED BY sp_EXTRACTCAPEXREQUESTS
        DROP TABLE REQ_WKF_ATUALIZACAOTISS;
GO
DROP PROCEDURE dbo.sp_CALCULATEREQUESTS
GO
CREATE PROCEDURE dbo.sp_CALCULATEREQUESTS
AS
    /* DATETIME CONVERSIONS */
    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [ABERTURA] = dbo.fn_CONVERTSTR2DATETIME(OPENDATE)
    , [RESOLUCAO] = dbo.fn_CONVERTSTR2DATETIME(CLOSEDATE)
    , [ULTIMA ACAO] = dbo.fn_CONVERTSTR2DATETIME(LASTACTION)
    , [ULTIMO ANALISTA] = dbo.fn_CONVERTSTR2DATETIME(LASTANALYST)
    , [REABERTURA] = dbo.fn_CONVERTSTR2DATETIME(LASTREOPEN)
    , [% SLA] = CASE
                    WHEN CONVERT(FLOAT, [RESLMINS]) = 0 THEN 0
                    WHEN CONVERT(FLOAT, [RESLREMAINS]) < CONVERT(FLOAT, [RESLMINS]) THEN (CONVERT(FLOAT, [RESLMINS]) - CONVERT(FLOAT, [RESLREMAINS])) / CONVERT(FLOAT, [RESLMINS])
                    ELSE 1
                END
    , [TEMPO SOLUCAO (H)] = CASE
                                WHEN [CLOSED] = '1' THEN dbo.fn_GETTOTALWORKINGHOURS( dbo.fn_CONVERTSTR2DATETIME(OPENDATE), dbo.fn_CONVERTSTR2DATETIME(CLOSEDATE) )
                                ELSE dbo.fn_GETTOTALWORKINGHOURS( dbo.fn_CONVERTSTR2DATETIME(OPENDATE), GETDATE() )
                            END
    , [TEMPO ULTIMA ACAO (H)] = CASE
                                WHEN [CLOSED] = '1' THEN dbo.fn_GETTOTALWORKINGHOURS( dbo.fn_CONVERTSTR2DATETIME(LASTACTION), dbo.fn_CONVERTSTR2DATETIME(CLOSEDATE) )
                                ELSE dbo.fn_GETTOTALWORKINGHOURS( dbo.fn_CONVERTSTR2DATETIME(LASTACTION), GETDATE() )
                            END
    , [TEMPO ULTIMO ANALISTA (H)] = CASE
                                WHEN [CLOSED] = '1' THEN dbo.fn_GETTOTALWORKINGHOURS( dbo.fn_CONVERTSTR2DATETIME(LASTANALYST), dbo.fn_CONVERTSTR2DATETIME(CLOSEDATE) )
                                ELSE dbo.fn_GETTOTALWORKINGHOURS( dbo.fn_CONVERTSTR2DATETIME(LASTANALYST), GETDATE() )
                            END;
    --, [TEMPO SOLUCAO (H)] = CASE
                                --WHEN [CLOSED] = '1' THEN (CONVERT(FLOAT, [RESLMINS]) - CONVERT(FLOAT, [RESLREMAINS])) / 60
                                --ELSE 0
                            --END;
    /* DEFAULT STATUS*/
    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [SITUACAO] = 'ABERTO'
        , [SITUACAO SLA] = 'NO PRAZO'
        , [NIVEL] = 'N1';

    /* TICKET STATUS */
    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [SITUACAO] = 'FECHADO'
    WHERE [CLOSED] = '1';

    /* SLA STATUS */
    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [SITUACAO SLA] = 'VENCIDO'
    WHERE [% SLA] >= 1;

    /* LEVEL: ASSIGNED TICKETS */
    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [NIVEL] = 'N2'
    WHERE GROUPANAL = 0
    AND (CURRANAL LIKE '%allan.pacheco%'
        OR CURRANAL LIKE '%anderson.santos%'
        OR CURRANAL LIKE '%carlos.pinheiro%'
        OR CURRANAL LIKE '%Willian Cruz%'
        OR CURRANAL LIKE '%sergio.queiroz%');

    /* LEVEL: UNASSIGNED TICKETS */
    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [NIVEL] = 'N2'
    WHERE GROUPANAL = 0
    AND (LASTANAL LIKE '%allan.pacheco%'
        OR LASTANAL LIKE '%anderson.santos%'
        OR LASTANAL LIKE '%carlos.pinheiro%'
        OR LASTANAL LIKE '%Willian Cruz%'
        OR LASTANAL LIKE '%sergio.queiroz%'
        OR CURRANAL = 'TI');

    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [NIVEL] = 'N2'
    WHERE GROUPANAL = 1
    AND (CURRANAL = 'Fila de Espera'
        OR CURRANAL = 'Central de Atendimento'
        OR CURRANAL = 'TI')
    AND (LASTANAL LIKE '%allan.pacheco%'
        OR LASTANAL LIKE '%anderson.santos%'
        OR LASTANAL LIKE '%carlos.pinheiro%'
        OR LASTANAL LIKE '%Willian Cruz%'
        OR LASTANAL LIKE '%sergio.queiroz%'
        OR LASTANAL = 'Fila de Espera'
        OR LASTANAL = 'TI');

GO
DROP PROCEDURE dbo.sp_UPDATEREQUESTCLIENT
GO
CREATE PROCEDURE dbo.sp_UPDATEREQUESTCLIENT
AS
    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET [UNIDADE ATENDIMENTO] = UPPER(A.QANSWER)
    FROM Procedimentos.dbo.REQUESTIA_REQUESTS R
        JOIN Procedimentos.dbo.REQUESTIA_QANSWER A
            ON R.QSESSIONFORM = A.QSESSION
    WHERE A.QSESSION = R.QSESSIONFORM
        AND A.QUESTION = 'GER_CONSUL_EMPCNPJ';

    DELETE REQUESTIA_REQUESTS
    WHERE [UNIDADE ATENDIMENTO] IS NULL;

    UPDATE Procedimentos.dbo.REQUESTIA_REQUESTS
    SET MARCA = CASE
            WHEN [UNIDADE ATENDIMENTO] LIKE '%32.745.032/%' THEN 'JGS'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0005-90%' THEN 'HLD'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0006-70%' THEN 'CSI'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/%' THEN 'HOB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.750.846/%' THEN 'HOSAG'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%01.162.143/%' THEN 'LIO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%03.516.553/%' THEN 'LIO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%04.998.429/%' THEN 'VISAO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%05.942.307/%' THEN 'DH'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%10.526.385/%' THEN 'LIO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/%' THEN 'HOSL'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/%' THEN 'DH'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/%' THEN 'IOF'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%61.367.520/%' THEN 'HCLOE'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.363.702/%' THEN 'INOB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%03.752.982/%' THEN 'IOV'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%CSI%' THEN 'CSI'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%HOLDING%' THEN 'HLD'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%HOG%' THEN 'HOG'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%TAGUATINGA%' THEN 'HOB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%SOBRADINHO%' THEN 'DRVIS'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%LENTES DE CONTATO%' THEN 'LIO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%IPC%' THEN 'LIO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%MICROCIRURGIA%' THEN 'LIO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%LASER OCULAR%' THEN 'LIO'
            ELSE 'N/D'
        END
    , [SIGLA UNIDADE] = CASE
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.363.702/0001-30%' THEN 'SHLS'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.363.702/0002-10%' THEN 'CRS'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0001-66%' THEN 'L2'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0003-28%' THEN 'HEP'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0005-90%' THEN 'HLD'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0006-70%' THEN 'CSI'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.659.756%' THEN 'HOB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%00.750.846/0001-49%' THEN 'ATI'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%01.162.143/%' THEN 'CGL'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%04.998.429/%' THEN 'IRI'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%03.516.553/%' THEN 'TPZ'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%03.752.982/%' THEN 'IOV'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%10.526.385/%' THEN 'ALL'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0001-60%' THEN 'GRU'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0002-41%' THEN 'JAT'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0003-22%' THEN 'PAT'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0005-94%' THEN 'FUN'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0001-46%' THEN 'ITB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0002-27%' THEN 'BSD'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0003-08%' THEN 'HBA'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0004-99%' THEN 'EUN'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%19.413.985/%' THEN 'CBSB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%22.932.773/%' THEN 'SLA'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%22.932.716/%' THEN 'SLA'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%23.670.693/%' THEN 'CBRA'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%25.165.237/%' THEN 'DH'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/0001-35%' THEN 'RVE'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/0004-88%' THEN 'MPZ'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/0005-69%' THEN 'OND'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%61.367.520/0001-21%' THEN 'ITP'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%61.367.520/0005-55%' THEN 'TTP'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(ITAIGARA)%' THEN 'ITG'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(BOULEVARD)%' THEN 'BSD'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(HBA)%' THEN 'HBA'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(ITABUNA)%' THEN 'ITB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%EUNAPOLIS%' THEN 'EUN'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(MORUMBI)%' THEN 'MOR'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(HARMONY)%' THEN 'HNY'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(SHOPPING PÁTIO)%' THEN 'PAT'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(PARQUE SHOPPING)%' THEN 'PQE'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(FUNAV)%' THEN 'FUN'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(TAGUATINGA)%' THEN 'TAG'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%HÉLIO PRATES%' THEN 'HEP'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%HOB TAGUATINGA%' THEN 'TAG'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%HOG%' THEN 'GAM'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%(SOBRADINHO)%' THEN 'SOB'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%JARAGUÁ DO SUL%' THEN 'JGS'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%SILVA CUNHA%' THEN 'SIC'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%IPC%' THEN 'IPC'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%LASER OCULAR%' THEN 'LAO'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%CENTRO DE DIAGNOSE%' THEN 'DIAG'
            WHEN [UNIDADE ATENDIMENTO] LIKE '%CSI%' THEN 'CSI'
            ELSE 'N/D'
        END
    FROM REQUESTIA_REQUESTS
GO
DROP PROCEDURE dbo.sp_EXTRACTCAPEXREQUESTS
GO
CREATE PROCEDURE dbo.sp_EXTRACTCAPEXREQUESTS
AS
    DECLARE @dayName VARCHAR(9);
    SET @dayName = DATENAME(DW, GETDATE())

    -- MICROSOFT FLOW RUNS ONLY ON MONDAYS THEN SKIP EXECUTION ON ANOTHER DAYS
    IF(@dayName = 'Sunday') 
        SELECT R.REQUEST CHAMADO
            , CONVERT(VARCHAR(10), R.ABERTURA, 103) ABERTURA
            , UPPER(R.RSTATUS) STATUS
            , UPPER(R.CLIENT) SOLICITANTE
            , UPPER(R.CURRANAL) ANALISTA
            , R.MARCA MARCA
            , R.[UNIDADE ATENDIMENTO] UNIDADE
            , R.[SIGLA UNIDADE] SIGLA
            , A1.QANSWER PROJETO
            , A2.QANSWER FORNECEDOR
            , A3.QANSWER OBSERVACAO
            , A4.QANSWER VALOR
            , CONVERT(VARCHAR(10), CONVERT(DATE, A5.QANSWER, 111), 103) EMISSAO
            , A6.QANSWER NF
        INTO dbo.REQ_WKF_CAPEXNFD
        FROM REQUESTIA_REQUESTS R
            LEFT JOIN REQUESTIA_QANSWER A1
                ON R.QSESSIONFORM = A1.QSESSION AND A1.QUESTION = 'CAP_CAPEX_CC'
            LEFT JOIN REQUESTIA_QANSWER A2
                ON R.QSESSIONFORM = A2.QSESSION AND A2.QUESTION = 'CONTAS_PGTO_Forn'
            LEFT JOIN REQUESTIA_QANSWER A3
                ON R.QSESSIONFORM = A3.QSESSION AND A3.QUESTION = 'CONTAS_PGTO_Observacao'
            LEFT JOIN REQUESTIA_QANSWER A4
                ON R.QSESSIONFORM = A4.QSESSION AND A4.QUESTION = 'CONTAS_PGTO_Valor'
            LEFT JOIN REQUESTIA_QANSWER A5
                ON R.QSESSIONFORM = A5.QSESSION AND A5.QUESTION = 'CONTAS_PGTO_DataEmis'
            LEFT JOIN REQUESTIA_QANSWER A6
                ON R.QSESSIONFORM = A6.QSESSION AND A6.QUESTION = 'CONTAS_PGTO_NDocumento'
        WHERE R.CATEGORY = 'Contas a Pagar'
            AND R.PRODUCT = 'Solicitação de CAPEX'
            AND R.PROCESS = 'Registro de NFDs'
            AND R.RSTATUS NOT LIKE '%Cancel%'
GO
DROP PROCEDURE dbo.sp_EXTRACTTISSREQUESTS
GO
CREATE PROCEDURE dbo.sp_EXTRACTTISSREQUESTS
AS
    DECLARE @dayName VARCHAR(9);
    SET @dayName = DATENAME(DW, GETDATE())

    -- MICROSOFT FLOW RUNS ONLY ON MONDAYS THEN SKIP EXECUTION ON ANOTHER DAYS
    IF(@dayName = 'Sunday') 
        SELECT R.REQUEST CHAMADO
            , R.MARCA
            , R.[SIGLA UNIDADE] SIGLA
            , R.[UNIDADE ATENDIMENTO] UNIDADE
            , CONVERT(VARCHAR(10), R.ABERTURA, 103) ABERTURA
            , UPPER(R.CLIENT) SOLICITANTE
            , UPPER(R.PROCESS) PROCESSO
            , UPPER(R.RSTATUS) SITUACAO
            , UPPER(R.CURRANAL) ANALISTA
            , FORMAT(R.[% SLA], 'P') SLA
            , CONVERT(VARCHAR(10), R.[ULTIMA ACAO], 103) ULTIMA_ACAO
            , UPPER(A1.QANSWER) CONVENIO
            , CONVERT(VARCHAR(10), CONVERT(DATE, A2.QANSWER, 111), 103) SOLICITACAO
            , UPPER(A3.QANSWER) DESCRICAO
            , UPPER(A4.QANSWER) SISTEMA
        INTO REQ_WKF_ATUALIZACAOTISS
        FROM REQUESTIA_REQUESTS R
            LEFT JOIN REQUESTIA_QANSWER A1
                ON R.QSESSIONFORM = A1.QSESSION AND A1.QUESTION = 'CAD_Atualiza_TISS_RazSoc'
            LEFT JOIN REQUESTIA_QANSWER A2
                ON R.QSESSIONFORM = A2.QSESSION AND A2.QUESTION = 'CAD_CLIENTE_DataSolici'
            LEFT JOIN REQUESTIA_QANSWER A3
                ON R.QSESSIONFORM = A3.QSESSION AND A3.QUESTION = 'CAD_Atualizacao_TISS_Desc'
            LEFT JOIN REQUESTIA_QANSWER A4
                ON R.QSESSIONFORM = A4.QSESSION AND A4.QUESTION = 'CAD_PAD_Sistema'
        WHERE R.CATEGORY = 'Central de Cadastros'
            AND R.PRODUCT = 'Cadastro Comercial'
            AND R.PROCESS LIKE '%TISS%'
GO

SELECT MIN([DATA ABERTURA]), MAX([DATA ABERTURA]), COUNT(1) FROM REQUESTIA_REQUESTS
SELECT MIN(QSESSIONTITLE), MAX(QSESSIONTITLE), COUNT(1) FROM REQUESTIA_QSESSION
SELECT MAX(QUESTION), MAX(QANSWER), COUNT(1) FROM REQUESTIA_QANSWER

SELECT CLIENT, COUNT(1)
FROM REQUESTIA_REQUESTS
WHERE GROUPANAL = 0
GROUP BY CLIENT
ORDER BY 2 DESC

SELECT OPENDATE, COUNT(1)
FROM REQUESTIA_REQUESTS
GROUP BY OPENDATE
ORDER BY 2 DESC

SELECT TOP 20 OPENDATE, [DATA ABERTURA]
    , CLOSEDATE, [DATA RESOLUÇÃO]
    , LASTACTION, [DATA ÚLTIMA AÇÃO]
    , LASTANALYST, [DATA ÚLTIMO ANALISTA]
    , LASTREOPEN, [DATA ÚLTIMA REABERTURA]
    , RESLMINS, RESLREMAINS, [% SLA], [TEMPO SOLUÇÃO (H)]
    , [SITUAÇÃO], [SITUAÇÃO SLA]
    , [UNIDADE ATENDIMENTO]
FROM REQUESTIA_REQUESTS

SELECT DISTINCT [UNIDADE ATENDIMENTO]
    , CASE
        WHEN [UNIDADE ATENDIMENTO] LIKE '%32.745.032/%' THEN 'JGS'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0005-90%' THEN 'HLD'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0006-70%' THEN 'CSI'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/%' THEN 'HOB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.750.846/%' THEN 'HOSAG'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%01.162.143/%' THEN 'LIO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%03.516.553/%' THEN 'LIO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%04.998.429/%' THEN 'VISAO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%05.942.307/%' THEN 'DH'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%10.526.385/%' THEN 'LIO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/%' THEN 'HOSL'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/%' THEN 'DH'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/%' THEN 'IOF'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%61.367.520/%' THEN 'HCLOE'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.363.702/%' THEN 'INOB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%03.752.982/%' THEN 'IOV'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%CSI%' THEN 'CSI'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%HOLDING%' THEN 'HLD'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%HOG%' THEN 'HOG'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%TAGUATINGA%' THEN 'HOB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%SOBRADINHO%' THEN 'DRVIS'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%LENTES DE CONTATO%' THEN 'LIO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%IPC%' THEN 'LIO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%MICROCIRURGIA%' THEN 'LIO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%LASER OCULAR%' THEN 'LIO'
        ELSE 'N/D'
    END MARCA
    , CASE
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.363.702/0001-30%' THEN 'SHLS'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.363.702/0002-10%' THEN 'CRS'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0001-66%' THEN 'HEP'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0005-90%' THEN 'HLD'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.649.756/0006-70%' THEN 'CSI'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.659.756%' THEN 'HOB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%00.750.846/0001-49%' THEN 'ATI'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%01.162.143/%' THEN 'CGL'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%04.998.429/%' THEN 'IRI'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%03.516.553/%' THEN 'TPZ'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%03.752.982/%' THEN 'IOV'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%10.526.385/%' THEN 'ALL'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0001-60%' THEN 'GRU'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0002-41%' THEN 'JAT'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0003-22%' THEN 'PAT'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%12.305.371/0005-94%' THEN 'FUN'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0001-46%' THEN 'ITB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0002-27%' THEN 'BSD'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0003-08%' THEN 'HBA'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%13.188.370/0004-99%' THEN 'EUN'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%19.413.985/%' THEN 'CBSB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%22.932.773/%' THEN 'SLA'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%22.932.716/%' THEN 'SLA'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%23.670.693/%' THEN 'CBRA'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%25.165.237/%' THEN 'DH'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/0001-35%' THEN 'RVE'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/0004-88%' THEN 'MPZ'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%40.514.432/0005-69%' THEN 'OND'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%61.367.520/0001-21%' THEN 'ITP'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%61.367.520/0005-55%' THEN 'TTP'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(ITAIGARA)%' THEN 'ITG'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(BOULEVARD)%' THEN 'BSD'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(HBA)%' THEN 'HBA'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(ITABUNA)%' THEN 'ITB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%EUNAPOLIS%' THEN 'EUN'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(MORUMBI)%' THEN 'MOR'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(HARMONY)%' THEN 'HNY'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(SHOPPING PÁTIO)%' THEN 'PAT'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(PARQUE SHOPPING)%' THEN 'PQE'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(FUNAV)%' THEN 'FUN'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(TAGUATINGA)%' THEN 'TAG'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%HÉLIO PRATES%' THEN 'HEP'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%HOB TAGUATINGA%' THEN 'TAG'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%HOG%' THEN 'GAM'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%(SOBRADINHO)%' THEN 'SOB'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%JARAGUÁ DO SUL%' THEN 'JGS'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%SILVA CUNHA%' THEN 'SIC'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%IPC%' THEN 'IPC'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%LASER OCULAR%' THEN 'LAO'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%CENTRO DE DIAGNOSE%' THEN 'DIAG'
        WHEN [UNIDADE ATENDIMENTO] LIKE '%CSI%' THEN 'CSI'
        ELSE 'N/D'
    END [SIGLA UNIDADE]
FROM REQUESTIA_REQUESTS
ORDER BY MARCA, [SIGLA UNIDADE]

/* ASSIGNED TICKETS */
SELECT CURRANAL
    , LASTANAL
    , NIVEL
FROM REQUESTIA_REQUESTS
WHERE GROUPANAL = 0
--AND MARCA = 'HOB'
AND CATEGORY = 'Tecnologia da Informacao'
AND SITUACAO = 'ABERTO'
ORDER BY 1

ORDER BY 1

/* UNASSIGNED TICKETS */
SELECT CURRANAL
    , LASTANAL
    , NIVEL
FROM REQUESTIA_REQUESTS
WHERE GROUPANAL = 1
AND CATEGORY = 'Tecnologia da Informacao'
AND SITUACAO = 'ABERTO'
ORDER BY 2

DELETE REQUESTIA_REQUESTS
WHERE [UNIDADE ATENDIMENTO] IS NULL

SELECT *
FROM REQUESTIA_QANSWER
WHERE QSESSION = 55137
AND QUESTION = 'GER_CONSUL_EMPCNPJ'

SELECT *
FROM REQUESTIA_REQUESTS
WHERE QSESSIONFORM = 55137

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = GETDATE()
SET @EndDate = GETDATE()


SELECT
    DATEDIFF(dd, @StartDate, @EndDate) ,
    (DATEDIFF(wk, @StartDate, @EndDate) * 2),
    DATENAME(dw, @StartDate),
    DATENAME(dw, @EndDate),
   (DATEDIFF(dd, @StartDate, @EndDate) + 1)
  -(DATEDIFF(wk, @StartDate, @EndDate) * 2)
  -(CASE WHEN DATENAME(dw, @StartDate) = 'Sunday' THEN 1 ELSE 0 END)
  -(CASE WHEN DATENAME(dw, @EndDate) = 'Saturday' THEN 1 ELSE 0 END)
GO

SELECT dbo.WorkTime(GETDATE()-1, GETDATE())

SELECT GETDATE()

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
SET @StartDate = '2019-08-19 17:00:00.000';
SET @EndDate = '2019-08-20 18:00:00.00';
SELECT [dbo].[fn_GetTotalWorkingHours](@StartDate, @EndDate)







IF (EXISTS (SELECT *
                 FROM INFORMATION_SCHEMA.TABLES
                 WHERE TABLE_SCHEMA = 'Procedimentos'
                 AND  TABLE_NAME = 'Requestia_REQUESTS'))
BEGIN
    DROP TABLE Procedimentos.dbo.REQUESTIA_REQUESTS
END


GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [DATA ABERTURA] DATETIME
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [DATA RESOLUÇÃO] DATETIME
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [DATA ÚLTIMA AÇÃO] DATETIME
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [DATA ÚLTIMO ANALISTA] DATETIME
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [DATA ÚLTIMA REABERTURA] DATETIME
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [% SLA] FLOAT
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [TEMPO SOLUÇÃO (H)] FLOAT
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [SITUAÇÃO] VARCHAR(20)
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [SITUAÇÃO SLA] VARCHAR(20)
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [UNIDADE ATENDIMENTO] VARCHAR(MAX)
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [MARCA] VARCHAR(10)
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [SIGLA UNIDADE] VARCHAR(10)
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [TEMPO ULTIMA ACAO (H)] FLOAT
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [TEMPO ULTIMO ANALISTA (H)] FLOAT
GO
ALTER TABLE Procedimentos.dbo.REQUESTIA_REQUESTS ADD [NIVEL] VARCHAR(5)



SELECT *
FROM REQUESTIA_REQUESTS R
WHERE R.REQUEST = 'CSI046512'

SELECT DATEPART(DW, GETDATE())
SELECT DATENAME(DW, GETDATE())



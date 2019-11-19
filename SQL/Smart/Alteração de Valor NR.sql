SELECT top 50 NFS_VALOR, *
FROM NFS
WHERE (NFS_STATUS <> 'C')
    AND (NFS.NFS_TIPO <> 'NC')
    AND (NFS.NFS_DT_VCTO >= '2019-01-01 00:00:00.000')
    AND (NFS.NFS_DT_VCTO <= '2019-09-30 23:59:59.000')
    --AND (NFS.NFS_NUMERO = 10512)
------------------------------------------------------------
SELECT nfs_valor, *
FROM nfs
WHERE ((nfs.nfs_tipo = 'NR')
        AND (((nfs.nfs_numero = 10657))))
------------------------------------------------------------
UPDATE NFS
SET NFS_VALOR = 2359.46
WHERE ((nfs.nfs_tipo = 'NR')
        AND (((nfs.nfs_numero = 10657))))
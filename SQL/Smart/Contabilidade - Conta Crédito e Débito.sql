select LCT_CCT_COD_CRE, LCT_CCT_COD_DEB , LCT_LOTE
from lct

UPDATE LCT
SET LCT_CCT_COD_CRE = '10040'

WHERE LCT_CCT_COD_DEB IN ('12120', '12130', '12140')
--IS NOT NULL 
--WHERE  LCT_CCT_COD_DEB <> '10040'
AND LCT_CCT_COD_CRE = '0'
--AND LCT_LOTE = ''
--AND LCT_LOTE NOT IN ('11233','12671')
AND lct_gcc_cod = '9'
--SELECT *FROM gcc_colig
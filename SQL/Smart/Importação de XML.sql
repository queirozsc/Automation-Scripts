SELECT emp_cr_modelo_import, * 
FROM emp 
WHERE emp_cod = '206'

UPDATE emp
SET emp_cr_modelo_import = 'TISS'
WHERE emp_cod = '206'
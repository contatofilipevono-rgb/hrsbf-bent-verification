from pathlib import Path
import subprocess,sys,time
root=Path(__file__).parent
steps=[['classifica_nucleos_minimos.py'],['verifica_catalogo_denso.py'],['verifica_reducao_hiperplanos.py'],['verifica_pareamento_ciclico.py'],['verifica_f4_simbolico.py','F4_2_L1'],['reproduz_certificados_sem_solver.py'],['verifica_f4_simbolico.py','F4_J2_L1']]
start=time.time()
for args in steps:
 print('VERIFICANDO:',args,flush=True)
 subprocess.run([sys.executable,str(root/args[0]),*args[1:]],cwd=root,check=True)
print('TODAS AS VERIFICACOES PASSARAM. A prova escrita de cobertura e as hipoteses nao sao substituidas por este programa. Segundos:',round(time.time()-start,2))

# Execute após a preparação: todas as 30 famílias, com cálculo de fibras compartilhado.
# Cada UNSAT exige DRAT-trim. SAT apenas satisfaz condições necessárias.
import random
sys.path.insert(0, str(project/'pesquisa_t32'))
from modelo_radicais_t32 import CNF, controls, directions, free_coordinates
from triagem_familias_t32 import model, coefficient_forms, family_fiber, linear_row
from verificar_fibras_exato import require

SUMMARY = json.loads((OUT/'resumo.json').read_text())
SUMMARY['completed'] = False
SUMMARY['batch_method'] = 'shared_original_coefficient_forms'
SUMMARY.pop('error', None)
records = {record['h']: record for record in SUMMARY['families']}
families = json.loads((project/'pesquisa_t32/familias_30_remanescentes.json').read_text())

def check_serialized_cnf(path, expected_variables, expected_clauses):
    """Reject incomplete or malformed DIMACS before accepting solver results."""
    header = None
    count = maximum = 0
    with path.open() as stream:
        for line in stream:
            if not line.strip() or line.startswith('c'):
                continue
            if line.startswith('p'):
                fields = line.split()
                require(header is None and fields[:2] == ['p', 'cnf'] and len(fields) == 4, 'Cabeçalho DIMACS inválido.')
                header = tuple(map(int, fields[2:]))
                continue
            require(header is not None, 'Cláusula antes do cabeçalho.')
            literals = list(map(int, line.split()))
            require(literals and literals[-1] == 0 and 0 not in literals[:-1], 'Cláusula DIMACS incompleta.')
            maximum = max(maximum, max(map(abs, literals[:-1]), default=0))
            count += 1
    require(header == (expected_variables, expected_clauses), 'Cabeçalho difere dos metadados.')
    require(count == expected_clauses and maximum <= expected_variables, 'CNF truncada ou contagem inválida.')
    return {'clauses_read': count, 'maximum_variable': maximum}

def save_batch():
    SUMMARY['families'] = [records[f['h']] for f in families if f['h'] in records]
    SUMMARY['verified_unsat_count'] = sum(r['status']=='UNSAT_PROOF_VERIFIED' for r in SUMMARY['families'])
    (OUT/'resumo.json').write_text(json.dumps(SUMMARY, indent=2))

def package_batch():
    save_batch()
    manifest = {p.name: sha(p) for p in OUT.iterdir() if p.is_file() and p.name != 'SHA256.json'}
    (OUT/'SHA256.json').write_text(json.dumps(manifest, indent=2))
    archive = pathlib.Path('/content/resultado_hrsbf_colab.zip')
    with zipfile.ZipFile(archive, 'w', zipfile.ZIP_DEFLATED) as bundle:
        for path in sorted(OUT.iterdir()):
            if path.is_file():
                bundle.write(path, path.name)
    print('ZIP:', archive, 'bytes:', archive.stat().st_size, flush=True)

def check_sat(cnf, info, text, prefix, h):
    assignment = {}
    for line in text.splitlines():
        if line.startswith('v '):
            for literal in map(int, line.split()[1:]):
                if literal:
                    require(abs(literal) not in assignment or assignment[abs(literal)]==(literal>0), 'Modelo contraditório.')
                    assignment[abs(literal)] = literal > 0
    count, pending = 0, []
    with cnf.open() as source:
        for line in source:
            if not line.strip() or line.startswith(('c', 'p')):
                continue
            for literal in map(int, line.split()):
                if literal:
                    pending.append(literal)
                else:
                    require(any(assignment.get(abs(v))==(v>0) for v in pending), 'Cláusula não satisfeita.')
                    pending = []
                    count += 1
    require(not pending and count==info['clauses'], 'Contagem incorreta.')
    require(all(i in assignment for i in range(1,121)), 'Modelo sem coordenadas livres.')
    x = sum(1<<(i-1) for i in range(1,121) if assignment[i])
    require(all(any(((int(mask,16)&x).bit_count()&1)^constant for mask,constant in f['affine_values']) for f in info['fibers']), 'Modelo viola radical.')
    _, _, lift = free_coordinates(int(h,16), hrows)
    c = lift(x)
    candidate = {'n':32, 'coordinate_base':0,
                 'sanf':[list(rep) for j,rep in enumerate(reps32) if c>>j&1],
                 'h':h, 'bentness_certified':False}
    prefix.with_suffix('.candidate.json').write_text(json.dumps(candidate,indent=2))

try:
    reps32, _, hrows, _ = model()
    orbit_dirs = directions()
    forms_by_z = {}
    print('Reconstruindo uma vez as 4.115 direções...', flush=True)
    for i,z in enumerate(orbit_dirs,1):
        forms_by_z[z] = coefficient_forms(reps32,z,hrows)
        if i%512==0:
            print('Direções reconstruídas:',i,flush=True)
    checked = controls()
    print('Fibras compartilhadas prontas; iniciando famílias.',flush=True)
    for family in families:
        h = family['h']; hvalue = int(h,16)
        prefix = OUT/('familia_'+h[2:])
        if records.get(h,{}).get('status')=='UNSAT_PROOF_VERIFIED':
            previous = json.loads(prefix.with_suffix('.json').read_text())
            check_serialized_cnf(prefix.with_suffix('.cnf'), previous['variables'], previous['clauses'])
            require(sha(prefix.with_suffix('.cnf'))==records[h]['cnf_sha256'],'CNF do certificado anterior mudou.')
            print(h,'já verificada; preservando prova.',flush=True)
            continue
        record = {'h':h,'status':'GENERATING','bentness_certified':False}
        records[h] = record
        save_batch()
        free, reduce_row, lift = free_coordinates(hvalue,hrows)
        rng = random.Random(20261007)
        for _ in range(100):
            row=rng.getrandbits(155); x=rng.getrandbits(120)
            reduced,constant=reduce_row(row)
            require(((row&lift(x)).bit_count()&1)==(((reduced&x).bit_count()&1)^constant),'Substituição inválida.')
        formula=CNF(120); normalized=[]; ranks={}
        for z in orbit_dirs:
            forms=forms_by_z[z]
            B,rank,basis=family_fiber(hvalue,hrows,forms)
            require(all((row&z).bit_count()%2==0 for row in B),'Meia rotação fora do radical.')
            require(linear_row(forms,z)==0,'Avaliação incorreta na meia rotação.')
            values=[reduce_row(linear_row(forms,r)) for r in basis]
            formula.balance(values)
            normalized.append({'z':z,'rank':rank,'radical_basis':basis,
                               'affine_values':[[hex(mask),constant] for mask,constant in values]})
            ranks[str(rank)]=ranks.get(str(rank),0)+1
        for _ in range(8):
            x=rng.getrandbits(120)
            expected=all(any(((int(mask,16)&x).bit_count()&1)^constant for mask,constant in f['affine_values']) for f in normalized)
            require(formula.evaluate(x)==expected,'Codificação CNF divergente.')
        cnf=prefix.with_suffix('.cnf'); proof=prefix.with_suffix('.drat')
        with cnf.open('w') as output:
            output.write('c Necessary fiber balance for fixed H='+h+'; not a bentness equivalence.\n')
            output.write('p cnf '+str(formula.variables)+' '+str(len(formula.clauses))+'\n')
            for clause in formula.clauses:
                output.write(' '.join(map(str,clause))+' 0\n')
        info={'h':h,'family_dimension':120,'free_original_orbit_indices':free,'fiber_orbits':4115,
              'polar_rank_counts':ranks,'variables':formula.variables,'clauses':len(formula.clauses),
              'cnf_sha256':sha(cnf),'toy_assignments_checked':checked,'free_coordinate_checks':100,
              'full_formula_assignments_checked':8,'bentness_certified':False,'fibers':normalized}
        info['serialized_cnf_check'] = check_serialized_cnf(cnf, info['variables'], info['clauses'])
        prefix.with_suffix('.json').write_text(json.dumps(info,indent=2))
        record.update({'cnf_sha256':info['cnf_sha256'],'variables':info['variables'],'clauses':info['clauses'],'status':'SOLVING'})
        save_batch()
        del formula
        result=run([solver,'--no-binary','-t',str(SOLVER_SECONDS),cnf,proof],prefix.with_suffix('.solver.log'),timeout=SOLVER_SECONDS+30)
        record['solver']=result
        text=prefix.with_suffix('.solver.log').read_text(errors='replace')
        if result['returncode']==20 and re.search(r'^s UNSATISFIABLE$',text,re.M):
            record['status']='UNSAT_UNCHECKED'
            checked_proof=run([checker,cnf,proof],prefix.with_suffix('.checker.log'),timeout=CHECKER_SECONDS)
            record['checker']=checked_proof
            checked_text=prefix.with_suffix('.checker.log').read_text(errors='replace')
            if checked_proof['returncode']==0 and not checked_proof['timed_out'] and re.search(r'^s VERIFIED\s*$',checked_text,re.M):
                record['status']='UNSAT_PROOF_VERIFIED'
        elif result['returncode']==10 and re.search(r'^s SATISFIABLE$',text,re.M):
            record['status']='SAT_MODEL_UNCHECKED'
            check_sat(cnf,info,text,prefix,h)
            record['status']='SAT_NECESSARY_CONDITIONS_ONLY'
        else:
            record['status']='UNKNOWN_OR_INTERRUPTED'
        if proof.exists():
            record['proof_sha256']=sha(proof)
        print(h,record['status'],flush=True)
        save_batch()
    SUMMARY['completed']=True
except Exception as error:
    SUMMARY['batch_error']=repr(error)
    print('Falha registrada:',repr(error),flush=True)
finally:
    package_batch()
    print('UNSAT com prova verificada:',SUMMARY.get('verified_unsat_count',0),'de 30',flush=True)

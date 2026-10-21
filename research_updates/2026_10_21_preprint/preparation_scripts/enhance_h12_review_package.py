from pathlib import Path
import json, hashlib, zipfile, shutil, re

out=Path.cwd()/'outputs/H12_preprint'
repo=Path('C:/Users/Valer/Documents/Codex/2026-10-16/https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed/outputs/hrsbf-bent-verification')
evidence=repo/'research_updates/2026_10_20_final_integration'
def sha(b): return hashlib.sha256(b).hexdigest()
report=json.loads((evidence/'run39520500414_attempt2_integration_report.json').read_text())
assert report['status']=='PASS_FINAL_KERNEL_INTEGRATION' and report['global_proof_complete'] is True
files={}
for m in report['new_modules']:
    name=m['module']
    for suffix,key in [('.lean','source_sha256'),('_build_FINAL.log','build_log_sha256'),('_kernel_FINAL.log','kernel_log_sha256')]:
        p=evidence/(name+suffix)
        if suffix=='.lean' and not p.exists(): p=evidence/'certified_final_sources'/(name+suffix)
        b=p.read_bytes()
        assert sha(b)==m[key],p.name
        files[p.name]=b
log=files['H12Final_build_FINAL.log'].decode()
names=['all_chart_refutations','no_bent_quartic','no_flat_quartic','walsh_witness']
for name in names:
    match=re.search(r"'H12Final\."+name+r"' depends on axioms: \[([^\]]+)\]",log)
    assert match and set(match.group(1).split(', '))=={'propext','Classical.choice','Quot.sound'}
assert 'sorryAx' not in log and 'ofReduceBool' not in log
for n in ['run39520500414_attempt2_integration_report.json','run39520500414_attempt2_AUDIT.json','FINAL_CONCRETE_ENCODING_AUDIT.json']:
    files[n]=(evidence/n).read_bytes()
files['README.md']=b'''# Preserved final integration records

These are records of the completed original Lean integration, not a new rebuild.
The two sources and four build/kernel logs have been compared byte for byte
with their SHA256 values in the original final integration report. The four
H12Final axiom reports contain only propext, Classical.choice and Quot.sound.
The complete source archive is supplied separately. Logs are evidence to inspect,
not an independent replacement for kernel verification or source review.
'''
files['MANIFEST_SHA256.json']=(json.dumps({n:sha(b) for n,b in files.items()},indent=2)+'\n').encode()
with zipfile.ZipFile(out/'H12_final_kernel_records.zip','w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
    for n,b in files.items(): z.writestr(n,b)
with zipfile.ZipFile(out/'H12_final_kernel_records.zip') as z: assert z.testzip() is None
(out/'FINAL_RECORDS_PACKAGE_AUDIT.json').write_text(json.dumps({'status':'PASS_EXACT_FINAL_SOURCE_AND_LOG_HASHES','original_run':39520500414,'attempt':2,'sources_and_logs_checked':6,'axiom_reports_checked':names,'allowed_axioms':['propext','Classical.choice','Quot.sound'],'new_lean_execution':False},indent=2)+'\n',encoding='utf-8')
(out/'MAPA_PARA_AVALIADOR.md').write_text('''# Roteiro de conferência para o avaliador

O artigo é a exposição principal. Este mapa localiza os pontos em que uma eventual falha seria decisiva e permite chegar às fontes sem ler milhares de arquivos gerados em sequência.

| Questão | Artigo | Material a conferir |
|---|---|---|
| A família é exatamente H(12,4)? | Proposição 2.1 e Apêndice A | Cobertura dos 495 suportes; ARTICLE_TRANSCRIPTION_AUDIT.json; H12Final e definição concreta de quarticFunction |
| BentAC significa bent no sentido de Walsh? | Lema 2.2 e Seção 5.2 | H12Fourier.lean, bent_iff_flat; H12Final.no_flat_quartic |
| Os filtros são necessários, não uma premissa adicional? | Lema 3.1 e (3.2) | Reconstrução dos 43 filtros no script audit_article_transcription.py; H12NumericFilters.all_filters_exact |
| As três relações decorrem dos filtros? | Lema 3.2 e Apêndice B | Expansão de todos os 22/1/24 produtos, conferida pelo script de transcrição |
| A restrição periódica cobre as possibilidades? | Lemas 3.3–3.4 | H12Descent.bent_rotational_descent; tabela completa dos 16 códigos e identidade (3.8) |
| As famílias cobrem toda candidata bent? | (3.9), Proposição 3.5 | H12ChartFilters.bent_root; verificação simbólica das três parametrizações |
| A recursão preserva as soluções? | Seção 4 | H12AffineFastState.Refutes e refutes_sound |
| As folhas rejeitam todas as observações possíveis? | Rejeição terminal | H12AffineFastState.leaf_sound; H12CertificateBridge.terminalCheck_sound e condição de suporte |
| As três instâncias estão efetivamente demonstradas? | Proposição 5.1 | H12CloudChart0/1/2.refutation e H12Final.all_chart_refutations |
| O teorema final tem hipótese oculta? | Seção 5.2 | H12Final.no_bent_quartic e seus relatórios de axiomas, incluídos em H12_final_kernel_records.zip |

## Ordem sugerida

1. Ler o enunciado e as Seções 2–5, verificando as implicações necessárias e a contradição final.
2. Conferir os apêndices matemáticos. A auditoria de transcrição refaz esses dados partindo do próprio Markdown, sem importar resultados dos filtros certificados.
3. Extrair o suplemento independente e executar `python verify.py`, sem -O. O checker Python usa quatro raízes; a prova Lean usa três após a exclusão analítica da quarta. Não somar suas contagens.
4. Examinar as fontes conceituais acima, os relatórios de axiomas e a composição final. Só então decidir se é necessária uma reconstrução integral do Lean.

O tempo de 139 segundos pertence ao replay independente observado em uma máquina. Não é promessa sobre reconstrução Lean ou tempo de revisão humana. O pacote formal conserva fontes exatas; a configuração Lake mínima de distribuição não foi reconstruída integralmente nesta preparação.

As auditorias são produzidas nesta pesquisa e não constituem revisão humana independente. Os logs preservados facilitam a inspeção, mas uma avaliação adversarial deve confrontar definições, implicações e fontes.
''',encoding='utf-8')
shutil.copyfile('work/audit_article_transcription.py',out/'audit_article_transcription.py')
readme=(out/'LEIA_PRIMEIRO.md').read_text(encoding='utf-8')
readme=readme.split('\n## Conferências adicionais')[0]
readme+='\n## Conferências adicionais\n\nMAPA_PARA_AVALIADOR.md relaciona as proposições às fontes conceituais. ARTICLE_TRANSCRIPTION_AUDIT.json registra a reconstrução das tabelas e identidades a partir do artigo. H12_final_kernel_records.zip inclui as duas fontes finais e os quatro logs com hashes iguais ao relatório original, além dos relatórios de escopo e auditoria. Nenhuma dessas verificações reiniciou o Lean.\n'
(out/'LEIA_PRIMEIRO.md').write_text(readme,encoding='utf-8')
handoff=(out/'HANDOFF_1356.md').read_text(encoding='utf-8')
handoff=handoff.split('\n## Rodada adicional com a cota restante')[0]
handoff+='\n## Rodada adicional com a cota restante\n\nA pedido do usuário, acrescentada reconstrução dos dados do artigo: 43 órbitas/495 suportes, 43 filtros, identidades 22/1/24, quatro códigos periódicos e três parametrizações. PASS_ARTICLE_DATA_RECONSTRUCTION. Acrescentados mapa para avaliador e H12_final_kernel_records.zip, com seis hashes exatos de fontes/logs finais e quatro relatórios de axiomas conferidos. O artigo e a prova matemática não foram alterados nessa rodada. Pacote essencial atualizado; usar o hash em PACKAGE_DELIVERY_AUDIT.json.\n'
(out/'HANDOFF_1356.md').write_text(handoff,encoding='utf-8')
manifest=json.loads((out/'REVIEW_PACKAGE_MANIFEST.json').read_text(encoding='utf-8'))
names=list(dict.fromkeys(list(manifest)+['H12_preprint.md','MAPA_PARA_AVALIADOR.md','ARTICLE_TRANSCRIPTION_AUDIT.json','audit_article_transcription.py','H12_final_kernel_records.zip','FINAL_RECORDS_PACKAGE_AUDIT.json','REVIEWER_DELIVERY_TESTS.json']))
manifest={n:{'bytes':(out/n).stat().st_size,'sha256':sha((out/n).read_bytes())} for n in names}
(out/'REVIEW_PACKAGE_MANIFEST.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
package=out/'H12_PACOTE_ANALISE_ADVERSARIAL.zip'
with zipfile.ZipFile(package,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
    for n in names+['REVIEW_PACKAGE_MANIFEST.json']: z.write(out/n,n)
with zipfile.ZipFile(package) as z:
    assert z.testzip() is None
    for n,m in manifest.items(): assert sha(z.read(n))==m['sha256']
(out/'PACKAGE_DELIVERY_AUDIT.json').write_text(json.dumps({'status':'PASS_REVIEW_PACKAGE_INTEGRITY','bytes':package.stat().st_size,'sha256':sha(package.read_bytes()),'member_count':len(names)+1,'full_lean_sources_separate':True,'external_review_completed':False,'figshare_published':False,'additional_article_data_check':'PASS_ARTICLE_DATA_RECONSTRUCTION','final_sources_and_logs':'PASS_EXACT_FINAL_SOURCE_AND_LOG_HASHES'},indent=2)+'\n',encoding='utf-8')
print('PASS_ENHANCED_REVIEW_PACKAGE',package.stat().st_size,sha(package.read_bytes()))

from pathlib import Path
import hashlib, json, zipfile

out = Path.cwd() / 'outputs/H12_preprint'
def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()
def write(name, text):
    (out/name).write_text(text, encoding='utf-8')

write('LEIA_PRIMEIRO.md', '''# Pacote para análise adversarial — H(12,4)

Versão preparada em 21/10/2026. Comece pelo artigo PDF e pelo PEDIDO_ANALISE_ADVERSARIAL.md. A finalidade desta entrega é obter uma avaliação externa crítica da matemática, da novidade e da apresentação.

O pacote essencial inclui artigo, fontes de redação, suplemento independente e relatórios. O arquivo H12_formal_sources.zip, de cerca de 49 MB, é fornecido separadamente: contém 2.093 fontes matemáticas Lean com hashes conferidos contra os registros certificados. O novo empacotamento Lake não foi reconstruído integralmente nesta preparação; a integração formal original já foi concluída e auditada.

O suplemento independente passou em 138,631 segundos na máquina de preparação. Para reproduzir, extraia H12_independent_verification.zip e execute `python verify.py`, sem a opção -O. O resultado esperado é PASS_COMPLETE_SYMBOLIC_COVER_AND_WALSH_REJECTIONS. Isso não substitui a reconstrução da prova Lean.

Escopo: inexistência de funções bent homogêneas quárticas simétricas por rotação em doze variáveis, com todos os 43 coeficientes livres. Não é um resultado para dezesseis variáveis ou dimensões gerais.

Os pareceres incluídos são autocríticas simuladas, não avaliação independente. A comparação bibliográfica dirigida não estabelece prioridade absoluta. A declaração de IA foi mantida na redação aprovada pelo autor.

O Figshare tem um rascunho separado, item 34737294, ainda não publicado. Este pacote não é uma submissão à revista. As declarações de financiamento e conflitos ainda devem ser confirmadas antes da submissão.
''')
write('HANDOFF_1356.md', '''# Retomada após renovação — 21/10/2026, 13h56 Brasília

O usuário ficará fora por cerca de duas horas e pediu um pacote utilizável antes de acabar a janela de créditos. Foi criada a automação única continuar-pacote-h12-ap-s-renova-o, ativa, para 13h56, após a renovação prevista às 13h55min48s. A antiga automação de Lean permanece pausada. Não reabrir cálculos concluídos.

## Entrega pronta

- H12_quartic_preprint_v1.pdf: artigo de 11 páginas, resumo de 160 palavras, seis referências e apêndices A/B/C.
- H12_PACOTE_ANALISE_ADVERSARIAL.zip: pacote essencial para enviar a um revisor externo; abrir LEIA_PRIMEIRO.md e PEDIDO_ANALISE_ADVERSARIAL.md.
- H12_formal_sources.zip: 2.093 fontes exatas, hashes certificados e imports conferidos, sem nova reconstrução integral do Lake mínimo.
- H12_independent_verification.zip: passou em 138,631 s, com 164.288 vetores nas folhas. Não repetir por rotina.
- PARECER_EDITORIAL_ADVERSARIAL.md e ANALISE_NOVIDADE_POLUJAN_TANG.md registram achados e limites. Não são pareceres independentes.

## Pendências concretas

1. Conferir o estado do Figshare antes de agir: rascunho 34737294, https://figshare.com/account/items/34737294/edit. Metadados salvos, nenhum arquivo enviado na última conferência. Enviar os quatro arquivos enumerados em DEPOSIT_METADATA.json; salvar e conferir tamanhos e nomes. Não criar outro item.
2. A publicação do preprint foi solicitada; autoria e CC BY 4.0 devem seguir V1. Se o ato final exigir nova aceitação juridicamente vinculante, preparar tudo e pedir a confirmação específica no momento, sem inventar declarações de financiamento/conflitos. Não dizer publicado sem DOI/página pública confirmados.
3. Colher a avaliação adversarial externa; incorporar apenas críticas fundamentadas. Manter a declaração de IA aprovada e não reescrever autoria como produção integral da IA.
4. Preparar a versão Springer e as declarações apenas depois da leitura final. Não submeter à revista automaticamente.

## Preservação e limites

Repositório: C:/Users/Valer/Documents/Codex/2026-10-16/https-chatgpt-com-s-cx-6ad2e1da63888191af8d539bda9b3bed/outputs/hrsbf-bent-verification.
Checkpoint editorial: research_updates/2026_10_21_preprint. Publicação dos checkpoints desta tarefa foi autorizada; stage somente essa pasta. Há milhares de arquivos Lean e alterações alheias no checkout: não incluir, apagar ou normalizar.

A prova final original está concluída: PASS_FINAL_KERNEL_INTEGRATION, H12Final.no_bent_quartic, fontes e axiomas auditados. Não retomar cartas, integração ou GPU. Nenhum merge do PR6 está autorizado.

Os dois PDFs novos foram examinados por texto e páginas visuais. Não foi identificado resultado que cubra H(12,4): a construção quártica de Polujan exige metade da dimensão ímpar; Tang usa 30·7^j ou 70t. Isso não prova prioridade exaustiva. Um exemplo rotacional bent de Polujan em dimensão 12 foi confirmado com termos de graus 2, 5 e 6; não é homogêneo quártico.

O artigo atual foi compilado e inspecionado visualmente; 15 equações numeradas permaneceram iguais na revisão editorial. Não executar prepare_h12_preprint.py inteiro: ele usa uma redação antiga e sobrescreveria a versão final.
''')
metadata=json.loads((out/'DEPOSIT_METADATA.json').read_text(encoding='utf-8'))
for entry in metadata['files']:
    p=out/entry['name']; entry.update(bytes=p.stat().st_size,sha256=digest(p))
metadata['review_package_status']='READY_FOR_EXTERNAL_ADVERSARIAL_REVIEW'
metadata['external_peer_review_completed']=False
(out/'DEPOSIT_METADATA.json').write_text(json.dumps(metadata,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
checks=json.loads((out/'FINAL_QUALITY_CHECKS.json').read_text(encoding='utf-8'))
checks['visual_review']='Latest contact sheet and full page 11 inspected; no clipping identified. Representative proof pages inspected before final prose changes; numbered equations unchanged.'
(out/'FINAL_QUALITY_CHECKS.json').write_text(json.dumps(checks,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
plan=(out/'PLANO_PUBLICACAO.md').read_text(encoding='utf-8')
plan=plan.replace('## 7. Depositar o preprint — em preparação','## 7. Depositar o preprint — rascunho criado, publicação pendente')
plan += '\n## Entrega para revisão — concluída\n\nPacote essencial fechado com PDF revisado, fontes, verificador e pedido adversarial. O Figshare permanece rascunho 34737294; não houve submissão à revista. Continuação única agendada para 13h56 de Brasília.\n'
write('PLANO_PUBLICACAO.md',plan)
names=['LEIA_PRIMEIRO.md','H12_quartic_preprint_v1.pdf','H12_preprint_source.zip','H12_independent_verification.zip','PEDIDO_ANALISE_ADVERSARIAL.md','PARECER_EDITORIAL_ADVERSARIAL.md','REVISAO_ADVERSARIAL.md','ANALISE_NOVIDADE_POLUJAN_TANG.md','LITERATURE_OVERLAP_AUDIT.json','REPLAY_VALIDATION.json','FINAL_QUALITY_CHECKS.json','FORMAL_SOURCE_ARCHIVE_AUDIT.json','DEPOSIT_METADATA.json']
manifest={n:{'bytes':(out/n).stat().st_size,'sha256':digest(out/n)} for n in names}
write('REVIEW_PACKAGE_MANIFEST.json',json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
package=out/'H12_PACOTE_ANALISE_ADVERSARIAL.zip'
with zipfile.ZipFile(package,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
    for n in names+['REVIEW_PACKAGE_MANIFEST.json']: z.write(out/n,n)
with zipfile.ZipFile(package) as z:
    assert z.testzip() is None
    for n,m in manifest.items(): assert hashlib.sha256(z.read(n)).hexdigest()==m['sha256']
write('PACKAGE_DELIVERY_AUDIT.json',json.dumps({'status':'PASS_REVIEW_PACKAGE_INTEGRITY','bytes':package.stat().st_size,'sha256':digest(package),'member_count':len(names)+1,'full_lean_sources_separate':True,'external_review_completed':False,'figshare_published':False},indent=2)+'\n')
print(json.dumps({'package':str(package),'bytes':package.stat().st_size,'sha256':digest(package)},indent=2))

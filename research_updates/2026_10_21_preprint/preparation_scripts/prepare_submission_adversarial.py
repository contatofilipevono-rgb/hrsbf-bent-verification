from pathlib import Path
import json,zipfile,hashlib,re

out=Path.cwd()/'outputs/H12_preprint'
sub=out/'materiais_submissao'
sub.mkdir(exist_ok=True)
def write(n,t): (sub/n).write_text(t.strip()+'\n',encoding='utf-8')
title='Nonexistence of homogeneous rotation symmetric bent functions of degree four in twelve variables'
write('CARTA_AO_EDITOR_EN.md',f'''Dear Editors,

Please consider the manuscript “{title}” for publication in Designs, Codes and Cryptography.

The manuscript establishes nonexistence for the complete space of homogeneous quartic rotation symmetric Boolean functions in twelve variables. This space has forty-three independent cyclic coefficients and therefore contains 2^43 coefficient choices. The argument combines restricted weight conditions and periodic autocorrelations with three finite affine refutations verified in Lean 4.35.0.

The result addresses a full parameter case of the homogeneous rotation symmetric bent function conjecture. Its contribution is the combination of an explicit structural reduction with a certificate whose coverage and rejection rules are proved sound. The manuscript distinguishes this result from earlier support-dependent nonexistence criteria and from constructions of rotation symmetric bent functions that do not belong to the homogeneous quartic space under consideration.

To support assessment of the computer-assisted argument, the manuscript presents the orbit basis, necessary conditions, affine parametrizations and refutation rules explicitly. Supplementary material provides a compact independent certificate checker, the mathematical Lean sources and the preserved verification records. The independent replay does not require repeating the original exhaustive search; it is distinguished from a full reconstruction of the formal proof.

A related preprint by the author, “Antipodal Necessity and the Cubic Case of the Homogeneous Rotation-Symmetric Bent Function Conjecture” (https://doi.org/10.6084/m9.figshare.34165260.v2), concerns antipodal necessity and the cubic case. The present manuscript treats the twelve-variable quartic case and is self-contained: its proof does not use the cubic result as a hypothesis.

The manuscript includes a declaration of AI-assisted tool use.

Thank you for considering the manuscript.

Sincerely,

Filipe Martins Vono
Centro Universitário de Belo Horizonte (UniBH), Belo Horizonte, Brazil
ORCID: https://orcid.org/0009-0009-4994-8533
contatofilipevono@gmail.com''')
write('CARTA_AO_EDITOR_PT.md',f'''Prezados Editores,

Submeto à apreciação de Designs, Codes and Cryptography o manuscrito “{title}”.

O manuscrito demonstra a inexistência de funções bent em todo o espaço de funções booleanas homogêneas quárticas simétricas por rotação em doze variáveis. Esse espaço possui quarenta e três coeficientes cíclicos independentes e, portanto, 2^43 escolhas de coeficientes. O argumento combina condições de peso restrito e autocorrelações periódicas com três refutações afins finitas verificadas em Lean 4.35.0.

O resultado trata um caso completo de parâmetros da conjectura sobre funções bent homogêneas simétricas por rotação. Sua contribuição combina uma redução estrutural explícita com um certificado cuja cobertura e cujas regras de rejeição têm correção demonstrada. O manuscrito distingue esse resultado de critérios anteriores de inexistência condicionados aos suportes e de construções de funções bent simétricas por rotação que não pertencem ao espaço homogêneo quártico considerado.

Para facilitar a avaliação da demonstração assistida por computador, o manuscrito apresenta explicitamente a base de órbitas, as condições necessárias, as parametrizações afins e as regras de refutação. O material suplementar fornece um verificador independente compacto, as fontes matemáticas Lean e os registros preservados da verificação. O replay independente dispensa repetir a busca exaustiva original e é distinguido da reconstrução completa da prova formal.

Um preprint relacionado do autor, “Antipodal Necessity and the Cubic Case of the Homogeneous Rotation-Symmetric Bent Function Conjecture” (https://doi.org/10.6084/m9.figshare.34165260.v2), trata da necessidade antipodal e do caso cúbico. O presente manuscrito trata do caso quártico em doze variáveis e é autossuficiente: sua prova não usa o resultado cúbico como hipótese.

O manuscrito inclui uma declaração do uso de ferramentas de IA como auxílio.

Agradeço a consideração do manuscrito.

Atenciosamente,

Filipe Martins Vono
Centro Universitário de Belo Horizonte (UniBH), Belo Horizonte, Brasil
ORCID: https://orcid.org/0009-0009-4994-8533
contatofilipevono@gmail.com''')
article=(out/'H12_preprint.md').read_text(encoding='utf-8')
abstract=article.split('## Abstract\n\n',1)[1].split('\n\n**Keywords:',1)[0]
ai=article.split('### 5.3 Use of AI-assisted tools\n\n',1)[1].split('\n\n## 6',1)[0]
write('RESUMO_E_DADOS_SUBMISSAO.md',f'''# Dados de submissão para conferência

Status: preparado para revisão; nenhum formulário da revista foi preenchido ou enviado.

**Title:** {title}

**Author and corresponding author:** Filipe Martins Vono

**Affiliation:** Centro Universitário de Belo Horizonte (UniBH), Belo Horizonte, Brazil

**ORCID:** 0009-0009-4994-8533

**Contact:** contatofilipevono@gmail.com

**Abstract — transcrição exata da versão do artigo incluída no pacote:**

{abstract}

**Keywords:** Boolean functions; bent functions; rotation symmetry; homogeneous functions; computer-assisted proof; Lean.

**Main result:** nonexistence in H(12,4), represented by all c : BitVec 43. The result does not assert H(16,4), arbitrary dimensions or nonexistence for all degree-at-most-four Boolean functions.

**Current preprint status:** Figshare item 34737294 is a private draft, with five files uploaded. There is no confirmed public DOI for this H12 preprint. Do not present its editor URL as a public citation.

**Related author preprint:** https://doi.org/10.6084/m9.figshare.34165260.v2

**Journal status:** not submitted by this workflow. Before an actual submission the author must confirm the current status of this manuscript and the editorial status of V1. No submission number has been invented.

**AI-assisted tools declaration — texto aprovado, sem alteração:**

{ai}

Dados do autor seguem o modo autorizado para V1. Conferir a exatidão atual antes de qualquer envio.''')
write('DISPONIBILIDADE_DADOS_EN.md','''# Data and code availability — proposed text

The mathematical sources, the independent certificate checker and the verification records supporting this result are available in the verification repository at https://github.com/contatofilipevono-rgb/hrsbf-bent-verification. A fixed preprint preparation package is preserved at https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/1e0e052/research_updates/2026_10_21_preprint. The completed formal integration records are identified at https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/9be0d98/research_updates/2026_10_20_final_integration. The independent checker and the complete mathematical Lean source archive are also supplied as supplementary files. Replaying the independent certificate is distinct from rebuilding the formal proof.

## Nota para preparação, fora do texto a submeter

Os links acima fixam commits já publicados. Não dependem de um DOI H12 ainda inexistente. Após publicar o preprint, acrescentar seu DOI real e conferir se os arquivos daquela versão correspondem aos citados. A disponibilidade das fontes exatas não significa que o empacotamento Lake mínimo tenha recebido uma nova reconstrução integral. Esse limite permanece declarado no artigo e na documentação.''')
write('DECLARACOES_PENDENTES.md',f'''# Declarações: o que está confirmado e o que falta

Este arquivo é de preparação e revisão. Não deve ser enviado à revista como se todas as declarações já estivessem completas.

## Uso de IA — texto aprovado

{ai}

Não substituir por uma declaração de auxílio apenas gramatical: isso não refletiria o uso descrito. Tampouco ampliar a declaração para atribuir a autoria integral às ferramentas.

## Financiamento — pendente de informação factual do autor

Ainda não há informação suficiente para declarar ausência ou presença de financiamento. Se o autor confirmar que não houve apoio financeiro relacionado a este estudo, pode-se utilizar: “The author received no financial support for this research.” Se houve apoio, informar entidade e identificação pertinentes. Não inserir automaticamente nenhuma das opções no artigo.

## Conflitos de interesse — pendente de confirmação do autor

Ainda não há confirmação factual de ausência ou presença de interesses financeiros e não financeiros relacionados ao trabalho. Somente se o autor confirmar ausência, pode-se utilizar: “The author declares no competing interests.” Se houver interesses a declarar, redigir a declaração correspondente. Não marcar ausência no formulário por inferência.

## Contribuições e aprovação — pendentes da declaração do autor

O manuscrito tem um único autor identificado. Isso não autoriza inventar uma descrição detalhada das atividades humanas. A declaração de contribuições no formulário deve ser conferida pelo autor e manter responsabilidade científica coerente com a declaração de IA. Ferramentas não são acrescentadas à lista de autores.

## Exclusividade e trabalhos relacionados — confirmar no momento do envio

Confirmar que o mesmo manuscrito não está sob avaliação simultânea em outro periódico. Confirmar o estado editorial do V1 e, se estiver em avaliação, informar periódico e número real na comunicação apropriada ao editor. Não tratar o depósito de preprint como submissão a periódico.

## Afiliação e autor correspondente

Identificação autorizada no mesmo modo de V1: Filipe Martins Vono, UniBH, Belo Horizonte, Brazil; ORCID 0009-0009-4994-8533; contatofilipevono@gmail.com. Confirmar que os dados permanecem atuais.

## Diretrizes consultadas

Designs, Codes and Cryptography: https://link.springer.com/journal/10623/submission-guidelines (consulta em 21/10/2026). As diretrizes pedem informações de contribuições e interesses na interface e declarações pertinentes no manuscrito; uso generativo de IA deve ser documentado em seção apropriada. Este arquivo organiza pendências, não substitui essas confirmações.''')
write('RELACAO_V1_H12_E_POSICIONAMENTO.md','''# Relação entre V1 e H12 e apresentação ao editor

| Aspecto | V1 identificado no preprint relacionado | Manuscrito H12 |
|---|---|---|
| Tema principal | Necessidade antipodal e caso homogêneo cúbico | Caso homogêneo quártico em doze variáveis |
| Alcance usado na carta | Referência a um trabalho relacionado do autor | Exclusão de todos os 43 coeficientes da base concreta de H(12,4) |
| Dependência lógica de H12 | Não é invocado como premissa | Argumento apresentado de forma autossuficiente |
| Comunicação editorial | Informar DOI e situação editorial verdadeira | Não prometer uma prova da conjectura geral |

O parágrafo da carta apenas identifica os temas e a independência lógica do argumento H12. Não declara uma auditoria integral de sobreposição textual ou de todo o conteúdo do V1. Antes da submissão, um avaliador deve comparar os dois textos para identificar material repetido, referências cruzadas ausentes ou uma divisão editorial inadequada.

## Objeção editorial que precisa ser enfrentada

“Por que um caso finito merece publicação além de um relato de busca?”

A resposta factual disponível é a redução explícita do espaço completo a três famílias afins e a certificação das refutações com uma ponte de correção e cobertura até o enunciado. O tamanho 2^43 explica a escala do domínio, mas não demonstra por si só relevância científica. O uso de Lean melhora a verificabilidade; não demonstra prioridade nem torna o interesse editorial automático.

## Afirmações a evitar

- “A conjectura de Stănică–Maitra foi resolvida” sem restringir ao caso H(12,4).
- “Primeira prova” sem investigação de prioridade que sustente essa afirmação.
- “A simetria por rotação impede bentness” sem homogeneidade e parâmetros.
- “Um avaliador certifica toda a prova em dois minutos”: o replay independente observado é diferente de reconstrução Lean e revisão humana.
- “As fontes novas foram recompiladas integralmente”: os arquivos matemáticos têm hashes conferidos, mas a configuração mínima de distribuição não recebeu essa nova execução completa.

## Trabalhos recentes na argumentação

A discussão de Sun et al., Polujan–Kudin–Pasalic e Tang deve remeter às hipóteses efetivas, conforme o artigo e ANALISE_NOVIDADE_POLUJAN_TANG.md. Ausência de sobreposição identificada na análise dirigida não constitui prioridade absoluta. O editor deve receber uma descrição sóbria da contribuição, sem alegações promocionais sobre autores, instituições ou quantidade de computação.''')
write('CHECKLIST_ENVIO_E_CONTROLE_VERSOES.md','''# Checklist antes do envio — sem submissão automática

## Conteúdo e documentos

- [x] Artigo PDF, Markdown e LaTeX preservados no pacote.
- [x] Carta em inglês e tradução para conferência em português.
- [x] Texto de disponibilidade de dados com referências fixas.
- [x] Declaração de IA mantida na forma aprovada.
- [x] Relação com V1 identificada; estado editorial não inventado.
- [ ] Receber e tratar análise adversarial externa do conjunto.
- [ ] Confirmar financiamento, conflitos, contribuições, aprovação e exclusividade.
- [ ] Confirmar situação editorial atual do V1.
- [ ] Preparar e conferir o layout de submissão recomendado pela revista; a versão incluída é a do preprint.
- [ ] Validar os arquivos e links após qualquer alteração.

## Preprint e versão para a revista

O item Figshare está em rascunho. A etapa atual é revisão. Melhorias de redação, referências, exemplos e organização podem produzir uma versão de submissão distinta. Registrar data e resumo das alterações. Correções que mudem enunciados, hipóteses ou partes formais exigem revalidação do que foi afetado. Não repetir a busca inteira ou a formalização por um simples ajuste editorial.

Se o preprint já tiver sido publicado quando houver revisão substancial, preparar uma versão nova e comunicar correções materiais com clareza. Não atribuir a um DOI antigo arquivos que ainda não estavam nessa versão. Na carta, inserir o DOI real de H12 somente após existir publicação confirmada. O DOI de V1 não é o DOI de H12.

## Registro editorial proposto

Manter um arquivo CHANGELOG_SUBMISSAO.md com data, versão do artigo, motivo e alcance de cada alteração. Distinguir ajustes de exposição, correções matemáticas e alterações dos certificados. A versão enviada ao editor deve ter seu próprio conjunto de hashes.

## Fontes oficiais consultadas

- https://link.springer.com/journal/10623/submission-guidelines
- https://support.springernature.com/en/support/solutions/articles/6000258807-preprints

Consulta: 21/10/2026. A política geral da Springer Nature informa que preprints não contam como publicação prévia impeditiva. As confirmações acima são tarefas desta preparação e não uma alegação de que o portal já as tenha recebido.''')
write('AUTOCRITICA_MATERIAIS_SUBMISSAO.md','''# Autocrítica adversarial dos materiais de submissão

Parecer simulado nesta conversa. Não é avaliação independente nem parecer da revista.

## Veredito

O conjunto está pronto para análise adversarial externa. Ainda não está pronto para envio automático à revista: faltam confirmações factuais do autor, a leitura externa e a preparação final do layout de submissão.

## Achados da carta anterior e correções

| Gravidade | Problema | Correção nesta versão |
|---|---|---|
| Maior | “Declarações serão completadas antes da submissão” fazia a própria carta parecer inacabada | Pendências foram retiradas da carta e explicitadas em documento separado; não foram substituídas por fatos inventados |
| Maior | Frase aberta sobre qualquer submissão concorrente de V1 não informava o estado real | Carta identifica o preprint relacionado; checklist exige informar o estado real e número, se aplicável, antes do envio |
| Editorial | Escala da busca e Lean podiam parecer o argumento principal de mérito | Carta explica redução estrutural e cobertura certificada, sem prometer relevância automática |
| Editorial | Tempo do checker poderia ser entendido como tempo total de avaliação | Carta não promete tempo; documentação distingue replay, reconstrução e revisão humana |
| Menor | Novo preprint ainda não tem DOI público confirmado | Nenhum DOI H12 foi inventado e a URL privada do rascunho não é usada como citação pública |

## Riscos que permanecem

1. Interesse editorial de um caso finito: um editor pode considerar H(12,4) insuficiente para o periódico. A carta apresenta a contribuição, mas não elimina esse julgamento.
2. Prioridade: a análise dirigida dos antecedentes não demonstra ausência universal de resultado anterior. Não usar “primeira prova”.
3. Relação V1/H12: o argumento H12 não usa V1 como hipótese, mas a sobreposição textual e a adequação de duas submissões ainda merecem comparação dos manuscritos completos.
4. Declarações: ausência de financiamento e conflitos continua não confirmada. Isso é pendência factual, não falha a resolver com uma frase padrão.
5. Reprodutibilidade: fontes exatas e registros preservados não dispensam avaliar o empacotamento para uma nova reconstrução. O pacote informa que o Lake mínimo não foi reconstruído integralmente.

## Conferências de consistência realizadas

- Mesmo título, autoria, escopo e identificação de H(12,4) em carta, metadados e artigo.
- Declaração de IA copiada do artigo aprovado, sem reduzir a assistência a correção gramatical e sem transferir autoria às ferramentas.
- Estado Figshare mantido como rascunho; nenhuma afirmação de submissão já feita.
- O resumo do formulário é transcrição do resumo atual, não uma nova formulação matemática.
- Carta não afirma exclusividade, inexistência de conflitos, ausência de financiamento ou aprovação institucional sem confirmação.

O avaliador externo deve contestar estas conclusões quando tiver evidência; não deve tratá-las como validação independente.''')
old=(out/'PEDIDO_ANALISE_ADVERSARIAL.md').read_text(encoding='utf-8')
write('PROMPT_ANALISE_ADVERSARIAL_INTEGRAL.md','''# Pedido de análise adversarial integral — artigo e submissão

Atue como pesquisador e editor crítico de Designs, Codes and Cryptography. Examine o artigo e também a carta, a apresentação da contribuição, as declarações propostas, a disponibilidade dos dados, os suplementos e a relação com V1. Seu objetivo é identificar falhas reais e recomendar a menor correção suficiente. Não aceite a certificação relatada como substituto de conferir as definições; não invente uma falha para parecer adversarial.

## Material adicional obrigatório

Na pasta materiais_submissao, leia CARTA_AO_EDITOR_EN.md, RESUMO_E_DADOS_SUBMISSAO.md, DISPONIBILIDADE_DADOS_EN.md, DECLARACOES_PENDENTES.md, RELACAO_V1_H12_E_POSICIONAMENTO.md e CHECKLIST_ENVIO_E_CONTROLE_VERSOES.md. A tradução CARTA_AO_EDITOR_PT.md serve à conferência pelo autor. AUTOCRITICA_MATERIAIS_SUBMISSAO.md é apenas uma autocrítica prévia, não um parecer independente.

## Perguntas adicionais sobre a submissão

1. A carta explica um mérito científico concreto além de verificar um caso finito? Identifique o argumento mais forte para uma rejeição editorial e diga se a carta consegue respondê-lo honestamente.
2. Há exagero, afirmação de prioridade sem base, confusão entre grau e homogeneidade, ou extrapolação do resultado H(12,4)? A comparação com Sun e com construções recentes está fiel às hipóteses?
3. Carta, resumo, artigo, Figshare, dados e suplementos descrevem a mesma versão e o mesmo enunciado? A afirmação de que a prova é autossuficiente em relação a V1 corresponde às dependências efetivas?
4. A relação com V1 é suficientemente transparente? Se tiver acesso ao texto completo de V1, procure sobreposição matemática e textual ou divisão editorial inadequada. Se não o tiver, registre essa limitação; não conclua ausência de sobreposição só pelo título.
5. As declarações propostas atribuem responsabilidade corretamente e descrevem o uso de IA de forma fiel, sem desvalorizar o autor nem ocultar assistência? Não sugira declarar auxílio apenas gramatical se os materiais mostram programação e formalização.
6. Há alguma declaração factual ausente apresentada como verdadeira? Financiamento, interesses e estado editorial estão deliberadamente pendentes. Não complete essas lacunas por palpite; diferencie bloqueios antes do envio de falhas matemáticas.
7. A disponibilidade dos dados permite identificar fontes, versões e evidências? Diferencie checker independente, registros de execução, prova original e reconstrução do novo empacotamento. Verifique se o tempo observado foi descrito sem promessa irrealista.
8. Que partes deveriam ser encurtadas ou movidas da carta para o suplemento? Proponha uma carta revisada em inglês, só com fatos sustentados pelos materiais.
9. As exigências da revista estão sendo efetivamente atendidas ou apenas listadas? Consulte as diretrizes oficiais se houver acesso à internet e cite a página exata. Não afirme conformidade completa do layout ou dos formulários ainda não preparados.

## Entrega esperada

Produza três avaliações separadas: (A) matemática/certificação; (B) escrita e mérito editorial; (C) prontidão dos documentos e das declarações. Classifique achados como críticos, maiores, menores ou editoriais e cite o arquivo e trecho. Apresente uma tabela com evidência, consequência e correção mínima. Entregue a reescrita da carta e dos parágrafos que mais prejudicam o conjunto. Liste o que foi realmente verificado e os arquivos/fontes que não examinou.

O veredito pode ser rejeição, revisão substancial, revisão menor ou pronto para submissão; justifique sem estimar porcentagem de aceitação. Não envie nada ao periódico, não publique o rascunho Figshare e não inicie computação pesada por rotina. Modificações do artigo devem ser propostas com controle de versão e indicação de possível impacto na formalização.

## Pedido matemático/editorial detalhado do artigo

'''+old)
write('LEIA_PRIMEIRO_SUBMISSAO.md','''# Materiais para revisão da submissão

Tudo nesta pasta é preparação local para análise adversarial. Nada foi enviado aos editores. O Figshare permanece rascunho e não há submissão à revista neste fluxo.

Comece pelo PROMPT_ANALISE_ADVERSARIAL_INTEGRAL.md. Ele abrange o artigo, os certificados, a carta e os documentos adicionais. A carta em inglês é a candidata para utilização após revisão; a tradução em português permite conferir o conteúdo. Declarações factuais ainda não confirmadas estão em DECLARACOES_PENDENTES.md e não foram inseridas como afirmações verdadeiras.

O ZIP integral reúne esta pasta com o pacote completo de revisão do artigo. As fontes Lean permanecem em H12_formal_sources.zip dentro dele. Não é necessário repetir uma reconstrução pesada para revisar a apresentação e a lógica da prova.

Para uma outra IA: cole o prompt integral e forneça o artigo PDF/Markdown e esta pasta; disponibilize os arquivos de certificação conforme a capacidade da ferramenta. Um sistema que não examine o suplemento deve dizer isso, não simular uma conferência.
''')
# Static consistency checks over the new package; these do not assess mathematical truth.
assert abstract in (sub/'RESUMO_E_DADOS_SUBMISSAO.md').read_text(encoding='utf-8')
assert ai in (sub/'DECLARACOES_PENDENTES.md').read_text(encoding='utf-8')
assert title in (sub/'CARTA_AO_EDITOR_EN.md').read_text(encoding='utf-8')
cover=(sub/'CARTA_AO_EDITOR_EN.md').read_text(encoding='utf-8')
for bad in ['first proof','resolves the conjecture in full','no competing interests','no financial support','not under consideration elsewhere']:
    assert bad not in cover.lower()
manifest={p.name:{'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()} for p in sorted(sub.iterdir()) if p.is_file()}
write('MANIFEST_SHA256.json',json.dumps(manifest,ensure_ascii=False,indent=2))
small=out/'H12_MATERIAIS_SUBMISSAO_PARA_REVISAO.zip'
with zipfile.ZipFile(small,'w',zipfile.ZIP_DEFLATED,compresslevel=9) as z:
    for p in sorted(sub.iterdir()): z.write(p,p.name)
full=out/'H12_ARTIGO_E_SUBMISSAO_ANALISE_COMPLETA.zip'
with zipfile.ZipFile(out/'H12_ANALISE_ADVERSARIAL_COMPLETA.zip') as src,zipfile.ZipFile(full,'w') as z:
    assert src.testzip() is None
    for item in src.infolist():
        z.writestr(item.filename,src.read(item.filename),compress_type=zipfile.ZIP_STORED if item.filename.endswith('.zip') else zipfile.ZIP_DEFLATED)
    for p in sorted(sub.iterdir()): z.write(p,'materiais_submissao/'+p.name,compress_type=zipfile.ZIP_DEFLATED)
    z.writestr('COMECE_PELA_REVISAO_INTEGRAL.md','''# Revisão do artigo e de toda a submissão

Use materiais_submissao/PROMPT_ANALISE_ADVERSARIAL_INTEGRAL.md como prompt principal. Ele substitui o prompt restrito ao artigo para esta entrega ampliada. A pasta inclui a carta ao editor em inglês e português, dados do formulário, declarações pendentes, disponibilidade dos dados, relação com V1, checklist e autocrítica.

O restante do ZIP contém o artigo e todos os materiais da revisão matemática. Abra COMECE_AQUI.md para a organização desses arquivos. Figshare permanece rascunho; nenhuma submissão foi enviada. As pendências factuais continuam explícitas.
'''.encode('utf-8'),compress_type=zipfile.ZIP_DEFLATED)
with zipfile.ZipFile(full) as z:
    assert z.testzip() is None
    for name,m in manifest.items(): assert hashlib.sha256(z.read('materiais_submissao/'+name)).hexdigest()==m['sha256']
audit={'status':'PASS_SUBMISSION_REVIEW_PACKAGE_INTEGRITY','manuscript_changed':False,'submitted_to_journal':False,'figshare_published':False,'ai_declaration_identical':True,'abstract_identical':True,'pending_author_facts':['funding','competing interests','contribution statement and approval','exclusivity at actual submission','V1 editorial status'],'full_zip':{'name':full.name,'bytes':full.stat().st_size,'sha256':hashlib.sha256(full.read_bytes()).hexdigest()},'submission_documents_zip':{'name':small.name,'bytes':small.stat().st_size,'sha256':hashlib.sha256(small.read_bytes()).hexdigest()}}
(out/'SUBMISSION_REVIEW_DELIVERY_AUDIT.json').write_text(json.dumps(audit,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
print(json.dumps(audit,ensure_ascii=False,indent=2))

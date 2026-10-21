from pathlib import Path
import json,re,shutil,hashlib,zipfile
root=Path(__file__).resolve().parent
old=root.parents[1]/'outputs/H12_preprint'
out=root.parents[1]/'outputs/H12_revisao2'
def write(n,t): (out/n).write_text(t.strip()+'\n',encoding='utf-8')
sub=out/'materiais_submissao';sub.mkdir(exist_ok=True)
for p in (old/'materiais_submissao').glob('*.md'):shutil.copyfile(p,sub/p.name)
article=(out/'H12_preprint.md').read_text(encoding='utf-8')
abstract=article.split('## Abstract\n\n')[1].split('\n\n**Keywords:')[0]
ai=article.split('### 5.3 Use of AI-assisted tools\n\n')[1].split('\n\n## 6')[0]
for filename in ['RESUMO_E_DADOS_SUBMISSAO.md','DECLARACOES_PENDENTES.md']:
 p=sub/filename;s=p.read_text(encoding='utf-8')
 oldarticle=(old/'H12_preprint.md').read_text(encoding='utf-8')
 oldabs=oldarticle.split('## Abstract\n\n')[1].split('\n\n**Keywords:')[0]
 oldai=oldarticle.split('### 5.3 Use of AI-assisted tools\n\n')[1].split('\n\n## 6')[0]
 s=s.replace(oldabs,abstract).replace(oldai,ai)
 s+='\n\n## Confirmações recebidas em 21/10/2026\n\nO autor informou que H12 e V1 não foram submetidos a revista e confirmou UniBH/Belo Horizonte e contatofilipevono@gmail.com. O V1 tem preprint público; H12 permanece rascunho privado no Figshare. Financiamento, interesses e a declaração final de contribuições/aprovação continuam sem resposta específica. As pendências anteriores sobre o estado editorial e o contato ficam substituídas por esta confirmação datada.\n'
 p.write_text(s,encoding='utf-8')
for language in ['EN','PT']:
 p=sub/f'CARTA_AO_EDITOR_{language}.md'
 if language=='EN':
  s='''Dear Editors,

Please consider the manuscript “Nonexistence of homogeneous rotation symmetric bent functions of degree four in twelve variables” for publication in Designs, Codes and Cryptography.

We prove nonexistence throughout the complete twelve-variable homogeneous quartic rotation symmetric space, which has forty-three independent cyclic coefficients. The structural reduction combines restricted-weight divisibility and autocorrelations on inputs of period four to obtain three explicit affine families of dimension thirty-six. Finite certificates then refute all three families, with the rules, coverage and concrete instances verified in Lean.

The reduction connects homogeneity to spectral constraints without imposing a support pattern in advance. Earlier interval criteria exclude restricted support configurations; the arithmetic hypotheses of Theorems 1–2 of Sun et al. fail at twelve variables, and their Theorem 4(2) starts at degree five at this dimension. The present result covers all forty-three quartic coefficients. The manuscript also distinguishes its homogeneity hypothesis from recent constructions of general rotation symmetric bent functions.

The article gives the structural argument, the certificate rules and their soundness, with supplementary sources, an independent finite checker and preserved formal verification records. The data-availability statement supplies fixed repository references. A persistent public DOI for the H12 deposit has not yet been issued; the deposit remains a draft pending this review.

A related preprint by the author concerns antipodal necessity and the cubic case (https://doi.org/10.6084/m9.figshare.34165260.v2). The quartic proof is self-contained and does not invoke that result. Neither manuscript is currently under consideration by a journal, as confirmed by the author on 21 October 2026. The manuscript includes a declaration of AI-assisted tool use, including adversarial review.

Thank you for considering the manuscript.

Sincerely,
Filipe Martins Vono
Centro Universitário de Belo Horizonte (UniBH), Belo Horizonte, Brazil
ORCID: https://orcid.org/0009-0009-4994-8533
contatofilipevono@gmail.com
'''
 else:
  s='''Prezados Editores,

Submeto à apreciação de Designs, Codes and Cryptography o manuscrito “Nonexistence of homogeneous rotation symmetric bent functions of degree four in twelve variables”.

Demonstramos a inexistência em todo o espaço homogêneo quártico simétrico por rotação em doze variáveis, com quarenta e três coeficientes cíclicos independentes. A redução estrutural combina divisibilidade de pesos restritos e autocorrelações em entradas de período quatro para obter três famílias afins explícitas de dimensão trinta e seis. Certificados finitos refutam as três famílias, com as regras, a cobertura e as instâncias concretas verificadas em Lean.

A redução conecta homogeneidade a restrições espectrais sem impor previamente um padrão de suportes. Critérios anteriores de intervalos excluem configurações restritas; as hipóteses aritméticas dos Teoremas 1–2 de Sun et al. falham em doze variáveis, e seu Teorema 4(2) começa no grau cinco nessa dimensão. O presente resultado cobre os quarenta e três coeficientes quárticos. O manuscrito também distingue a homogeneidade das construções recentes de funções bent rotacionais gerais.

O artigo apresenta o argumento estrutural, as regras dos certificados e sua correção, acompanhado de fontes, verificador finito independente e registros preservados da verificação formal. A declaração de disponibilidade fornece referências fixas do repositório. Ainda não foi emitido um DOI público persistente para o depósito H12, que permanece rascunho aguardando esta revisão.

Um preprint relacionado do autor trata da necessidade antipodal e do caso cúbico (https://doi.org/10.6084/m9.figshare.34165260.v2). A prova quártica é autossuficiente e não invoca esse resultado. Nenhum dos dois manuscritos está sob avaliação por revista, conforme confirmação do autor em 21 de outubro de 2026. O manuscrito inclui declaração do uso de IA como auxílio, inclusive na revisão adversarial.

Agradeço a consideração do manuscrito.

Atenciosamente,
Filipe Martins Vono
Centro Universitário de Belo Horizonte (UniBH), Belo Horizonte, Brasil
ORCID: https://orcid.org/0009-0009-4994-8533
contatofilipevono@gmail.com
'''
 p.write_text(s,encoding='utf-8')
# The letter remains an honest review draft until the public DOI and declarations are ready.
(sub/'CARTA_STATUS.md').write_text('''# Estado da carta

A carta acima é uma candidata revisada para análise adversarial, não uma carta já enviada. O parágrafo sobre o depósito descreve o estado atual; depois de publicar os dados, deve ser substituído pelo DOI real e por uma frase afirmando a disponibilidade efetiva. Não se apresenta como carta final pronta para envio enquanto o depósito persistente e as declarações factuais estiverem pendentes. A referência a 21/10 registra a confirmação recebida, não uma garantia sobre futuras submissões.
''',encoding='utf-8')
(sub/'RELACAO_V1_H12_E_POSICIONAMENTO.md').write_text('''# Comparação executada entre V1 e H12

Foi obtida a versão pública 2 do V1 diretamente da API Figshare, arquivo HRSBF_v2.pdf, de 15/10/2026. SHA256: 99b661dc24469b0f69cda0e07bd0466de880e60a9010781adc943547710424e3. O texto integral foi extraído e comparado com H12; os dados e o método constam de V1_H12_COMPARISON.json.

V1 enuncia necessidade antipodal para funções rotacionais bent de grau no máximo três em toda dimensão positiva par e deduz o caso homogêneo cúbico. Seu argumento usa transferência quadrática a espaços fixos de ordem ímpar e rigidez/fibras. H12 trata somente grau homogêneo quatro em doze variáveis, com filtros de peso, descida módulo três e refutações concretas. A árvore de imports certificada de H12 não invoca o teorema V1. A coincidência temática e os antecedentes comuns são identificados na nota da introdução e na carta.

A comparação normalizou palavras, caixa e hifens de quebra de linha e procurou blocos exatos com pelo menos nove palavras. Encontrou cinco blocos: títulos/referências da literatura, uma expressão do título da conjectura e a frase padrão sobre axiomas. Não foi identificado, por esse método, reaproveitamento de um parágrafo substantivo de demonstração. Isso não é um teste universal de plágio ou paráfrase, nem avaliação editorial independente da conveniência de duas submissões.

O autor confirmou em 21/10/2026 que nenhum dos dois manuscritos foi submetido a revista. V1 permanece citado como preprint público, e H12 permanece rascunho no Figshare. A comparação foi realizada nesta preparação; não foi delegada como pendência a um avaliador futuro.
''',encoding='utf-8')
for n in ['CHECKLIST_ENVIO_E_CONTROLE_VERSOES.md','LEIA_PRIMEIRO_SUBMISSAO.md']:
 p=sub/n;s=p.read_text(encoding='utf-8')
 s+='\n\n## Atualização da rodada 2\n\nEstado editorial, afiliação e e-mail confirmados pelo autor em 21/10/2026. O template oficial Springer foi preparado e compilado como rascunho de layout; não houve teste no conversor do portal nem submissão. O limite específico de arquivo suplementar do portal DCC não foi confirmado e não foi inferido do limite de outra revista. O arquivo de fontes tem cerca de 49 MB; o checker compacto pode ser disponibilizado separadamente. O DOI público do depósito continua pendente enquanto se preserva o rascunho para revisão. Consultar RESPOSTAS_AO_PARECER.md para a situação de cada achado.\n'
 p.write_text(s,encoding='utf-8')
write('AUDITORIA_LITERATURA_E_PRIORIDADE.md','''# Conferência dirigida da literatura — rodada 2

O objetivo foi conferir as hipóteses citadas, procurar sobreposição com H(12,4) e construir uma tabela que não transforme resultados condicionais em uma classificação completa.

| Fonte primária | Conferência | Limite |
|---|---|---|
| Stănică–Maitra, DOI 10.1016/j.dam.2007.04.029 | A descrição original registra estudo até dez variáveis e evidência experimental motivadora | Não é um enunciado de exclusão de H(12,4) |
| Meng–Chen–Fu, DOI 10.1016/j.dam.2010.02.009 | Metadados originais conferidos; critério de intervalo lido na reprodução como Lemma 7 de Sun e Theorem 3.10 de Cusick–Sanger | O PDF original não foi recuperado nesta rodada; não se finge leitura integral. A tabela atribui expressamente a reprodução |
| Zhang–Gao, https://arxiv.org/pdf/1303.2282 | Lidos enunciados de restrições aos padrões SANF e exemplos no texto primário | Não foi identificado teorema para todos os 43 coeficientes em doze variáveis |
| Cusick–Sanger, https://arxiv.org/pdf/1708.09313 | Theorem 3.8: n=2p, p primo ímpar, grau de uma homogênea bent deve ser par; Theorem 3.10 reproduz o critério de intervalos de Meng | n=12 não é 2p com p primo |
| Sun et al., DOI 10.1007/s10623-026-01848-4 | PDF integral fornecido pelo autor, enunciados 1–6 e página 5 visual; Th.1–2 têm primeiro limite primo 2^(2^a); a=2 dá 16; Th.3/4(1) dependem de suportes, Th.4(2) começa em grau 5 a n=12, Th.5/6 são cúbicos | Esses enunciados não dão uma exclusão incondicional de H(12,4). Não se afirma que nenhuma combinação concebível de critérios possa simplificar a prova |
| Polujan–Kudin–Pasalic, DOI 10.1109/TIT.2026.3685133 | Hipóteses e páginas visuais já conferidas; construção quártica exige m ímpar e 3 não divide m | Não inclui n=12 nessa família |
| Tang, https://eprint.iacr.org/2026/1799 | Th.4.5 e 5.4 e respectivas páginas visuais conferidos: n=30·7^j e n=70t | Preprint; as duas famílias não incluem n=12 |

A tabela do artigo é intitulada como seleção de resultados, com suas fronteiras; não se diz que contém todos os casos conhecidos. A busca dirigida adicional não localizou um resultado anterior que provasse a exclusão completa H(12,4). Isso é um resultado da busca, não demonstração de prioridade absoluta. Mantiveram-se fora do artigo as alegações “primeira prova” e de resolução da conjectura geral.

Os registros anteriores com hashes dos PDFs Polujan e Tang estão em LITERATURE_OVERLAP_AUDIT.json, incluído no pacote. O novo preprint V1 foi obtido da fonte pública primária e sua comparação está documentada separadamente. As considerações sobre limitações acima são parte da documentação para o avaliador, não uma declaração de que toda a literatura foi examinada.
''')
responses=[
('A1','Corrigido','Apêndice C imprime as definições; a auditoria compara diretamente os 43 índices e todos os 495 suportes do Markdown com a fonte certificada. Não foi criado um novo teorema ANF abstrato.'),
('A2','Corrigido','Tabela por raiz com nós, bifurcações, folhas e atribuições terminais; profundidades 36/22. Dados extraídos do grafo de construtores nas fontes com hashes certificados. O relatório de integração sozinho não contém essas estatísticas.'),
('A3','Corrigido com discordância da hipótese','Estado=(k,E), ambiente=coordenadas de E, raiz e observação definidos. A soundness geral NÃO exige independência do pivô; T(z)=z no ramo aplicável basta. Todos os casos concretos foram inspecionados e têm independência. Não se atribuiu ao Lean uma hipótese inexistente.'),
('A4','Corrigido','Tabela dos 16 códigos com tabelas-verdade e direção/C_g/resíduo para cada rejeitado; sobreviventes têm todos os 15 resíduos zero.'),
('A5','Corrigido','Explicada a bijeção rotacional entre subespaços e igualdade de pesos para toda escolha de coeficientes.'),
('A6','Corrigido','Exemplo Q42: três pesos 30, demais múltiplos de quatro, interseções pares; identidade do peso módulo quatro deriva R2. Explicado o espaço linear em que os produtos podem ser encontrados.'),
('A7','Corrigido','Polinômio cúbico C(y) renomeado E_3(y); autocorrelação mantém C_f.'),
('A8','Esclarecido','A pasta foi organizada em 20/10 e a integração concluiu em 21/10. Não era necessário alterar uma data correta ou atribuir o caso genericamente ao fuso.'),
('A9','Sugestão rejeitada com prova','Não há condição de paridade adicional nesta família: cada monômio quártico sobre oito coordenadas tem peso 16, de modo que toda soma tem paridade zero. A observação correta foi incluída.'),
('B1','Corrigido','Contribuição apresentada como redução estrutural explícita e certificação, sem usar Lean ou 2^43 como prova automática de mérito.'),
('B2','Corrigido com limite','Tabela de resultados selecionados, com parâmetros e fronteiras; fontes primárias/reproduções identificadas. Busca não estabelece prioridade absoluta.'),
('B3','Corrigido sem adotar o limite sugerido','Novo resumo de 169 palavras. O anterior tinha 160, não cerca de 190. A proposta de aproximadamente 120 ficaria abaixo das 150–250 palavras exigidas por DCC.'),
('B4','Corrigido','Removido o parágrafo defensivo sobre busca versus certificado e concentrada a apresentação na cadeia da demonstração.'),
('B5','Corrigido','Caminho de JSON saiu da prova; nomes das três instâncias e dados de execução ficam no Apêndice C.'),
('B6','Corrigido','Seção Data availability separada; hashes extensos ficam nos suplementos. Escopo formal tem subseções próprias.'),
('B7','Corrigido','Relação com V1 foi movida a nota de rodapé da introdução, como preprint e sem dependência lógica.'),
('B8','Corrigido','Conclusão identifica a mudança de ordem da rotação a n=16, a necessidade de novos filtros/refutações e a existência de quadráticas bent no caso não homogêneo.'),
('B9','Conferido','Hipóteses dos dois PDFs já verificadas e preservadas com páginas/hash; não foi inferida homogeneidade só pelo grau.'),
('C1','Parcial: fatos humanos pendentes','Confirmados pelo autor: nenhum trabalho submetido, UniBH/Belo Horizonte e e-mail. Financiamento, interesses e declaração final de contribuição/aprovação ainda não foram respondidos especificamente.'),
('C2','Preparado, publicação pendente','Cinco arquivos estão no rascunho Figshare. Um DOI público arquivístico exige concluir o depósito, mantido em espera pela análise adversarial. Não se inventou DOI nem se publicou para esconder a pendência.'),
('C3','Corrigido','Declaração agora inclui Claude para a revisão adversarial incorporada, mantendo o núcleo da redação aprovada e a responsabilidade do autor.'),
('C4','Concluído com limite do método','Comparação integral do texto extraído do V1 público v2 com H12 executada; correspondências longas são títulos/referências e frase de axiomas. Comparação matemática dos escopos documentada. Não é prova universal de ausência de paráfrase.'),
('C5','Preparado e compilado','Incluído rascunho no template oficial Springer, além do PDF de leitura. Compilado por Tectonic/XeTeX com fonte compatível com pdfLaTeX; o conversor do portal não foi testado.'),
('C6','Mitigado, limite do portal pendente','Não foi encontrada confirmação do limite específico DCC e não foi usado o limite de outra revista. Arquivos continuam separados; o checker é compacto e as fontes têm cerca de 49 MB. Há opção de fracionamento preservando fontes se o portal exigir.'),
('C7','Mantido com esclarecimento','139 s é tempo observado em uma máquina; o relato de 101 s por outro avaliador foi distinguido. Não houve promessa de tempo universal ou reconstrução Lean.'),
]
write('RESPOSTAS_AO_PARECER.md','# Respostas ao parecer adversarial — rodada 2\n\nParecer recebido: H12_RELATORIO_FINAL_ANALISE_ADVERSARIAL.zip, SHA256 3b9747d0123f838f5367c38ab639696cc49825c18712709cc5b12132e9d0302a. Nenhuma nota subjetiva de chance foi adotada como probabilidade. Não foi identificada objeção matemática crítica no relatório; as alterações desta rodada não mudam as fontes Lean ou o enunciado final.\n\n| Item | Situação | Resposta e evidência |\n|---|---|---|\n'+'\n'.join('| '+' | '.join(x)+' |' for x in responses)+'\n\n## Pendências reais antes da submissão\n\nFinanciamento/interesses e a declaração final de contribuições/aprovação; conclusão do depósito com DOI público; confirmação do limite de arquivos e conversão no portal. Essas pendências não impedem a segunda análise adversarial, mas impedem afirmar que a submissão está inteiramente pronta. A comparação de literatura é dirigida e não prova prioridade absoluta.\n')
write('CHANGELOG_SUBMISSAO.md','''# Histórico — 21/10/2026

## Revisão de trabalho 2, após o parecer Claude recebido

- Preservado o manuscrito anterior de 11 páginas e o relatório recebido para comparação.
- Resumo reescrito com 169 palavras; contribuição e resultados anteriores reorganizados; removido meta-discurso defensivo.
- Acrescentadas definições formais exatas, comparação dos 43 índices/495 suportes e estatísticas reais dos três grafos de refutação.
- Definidas semânticas de estado, ambiente, observação e atualização; esclarecida a diferença entre o teorema geral e os pivôs concretos.
- Tabela periódica expandida para 16 casos; derivação direta de Q42; invariância de pesos explicada; polinômio cúbico renomeado.
- Explicado por que a paridade é automática, corrigindo a sugestão do parecer.
- Dados e escopo formal separados; conclusão agora especifica dificuldades de extensão a 16 variáveis e a termos inferiores.
- Declaração de IA atualizada para incluir Claude como revisão adversarial; artigo, resumo do formulário e declarações sincronizados.
- Carta, comparação integral com V1 e checklist atualizados; fatos confirmados pelo autor registrados com data.
- Preparado template oficial Springer para conferência de layout. Nenhuma submissão ou nova publicação efetuada.

## Impacto matemático/formal

Nenhuma alteração dos 2.093 fontes matemáticos Lean, dos certificados, do teorema ou de seus axiomas. As novas verificações examinam a correspondência de representação e as estatísticas dos fontes preservados. Não foi repetida a busca ou uma reconstrução pesada do Lean. A nova derivação expositiva e a tabela são confrontadas com dados finitos exatos, não apresentadas como nova certificação kernel.
''')
write('PEDIDO_SEGUNDA_RODADA_ADVERSARIAL.md','''# Segunda rodada adversarial — artigo, prova e submissão

Você recebe uma revisão após um parecer anterior, não uma versão já aprovada. Leia primeiro o artigo revisado sem usar os relatórios PASS como premissa de correção. Depois confronte RESPOSTAS_AO_PARECER.md com o parecer original na pasta parecer_recebido. O objetivo é decidir se cada crítica foi resolvida, se uma discordância da resposta é válida e se as mudanças introduziram erros.

## Prioridades obrigatórias desta rodada

1. A3: confira a semântica E∘T e a prova de soundness mesmo quando a expressão afim contém o pivô. O Lean geral não impõe independência. Examine também a auditoria dos casos concretos, que encontrou zero violações. Não acrescente uma hipótese inexistente sem necessidade.
2. A9: confira a afirmação de paridade automática dos pesos sobre oito coordenadas para monômios quárticos (peso 16). Decida se há de fato uma nova condição linear ou se ela é tautológica neste espaço.
3. Compare as definições exatas e todos os 43 índices com a base do Apêndice A. A auditoria nova compara diretamente os fontes certificados, e não apenas o Markdown consigo próprio. Distinguir prova humana de completude ANF e teorema Lean concreto.
4. Refaça a tabela dos 16 casos, a derivação Q42 e as parametrizações; procure erros na nova notação E_3. Confira contagens de nós/folhas e o sentido de contagem com multiplicidade.
5. Literatura: verifique a tabela de resultados selecionados contra as fontes primárias e examine o limite declarado na recuperação do PDF original de Meng. Não conclua prioridade absoluta por uma busca negativa. Se encontrar um teorema anterior que exclua H(12,4) inteiro, cite-o e compare hipóteses antes de recomendar mudança de título ou mérito.
6. A versão usa 169 palavras no resumo, atendendo ao intervalo 150–250 informado por DCC. Não recomendar um limite conflitante sem verificar as diretrizes atuais.
7. Confira a comparação com V1 público v2 e se a separação editorial é defensável, considerando os textos completos e não só os títulos. O V1 de referência é incluído; não o trate como submetido a revista.
8. Reavalie a carta, dados de submissão, IA e checklist. Claude foi acrescentado à declaração pela revisão incorporada. Financiamento/interesses e aprovação final continuam pendentes; o DOI público do depósito ainda não existe. Não preencher nenhum fato por palpite.
9. Avalie a leitura humana dos PDFs e do template Springer. O template é um rascunho compilado, não uma conversão aprovada pelo portal ou uma submissão completa.

## Material e método

- H12_preprint.md e H12_quartic_revised_round2.pdf: texto atual.
- dcc_template: fonte e PDF no template oficial Springer; ler seus limites no README.
- certificados e registros: os mesmos da prova original, com hashes preservados; não repetir Lean pesado por rotina.
- FORMAL_DEFINITIONS_EXACT.md, CERTIFICATE_SIZE_AND_ENCODING_AUDIT.json, R2_RESTRICTED_WEIGHT_EXAMPLE.json, PERIODIC_CLASSIFICATION_16_CASES.json e V1_H12_COMPARISON.json: verificações específicas, produzidas nesta preparação, sem autoridade de revisão independente.
- materiais_submissao: documentos atuais; versões anteriores ficam na pasta historico.

Separe o parecer em (A) matemática/certificação, (B) escrita/interesse científico e (C) prontidão de documentos. Para cada achado use gravidade, arquivo/trecho, derivação ou evidência e correção mínima. Faça uma tabela com os 25 itens do parecer anterior e marque resolvido, parcialmente resolvido, resposta incorreta ou não verificado. Liste os novos achados separadamente.

Entregue um veredito fundamentado, os trechos reescritos e as pendências factuais. Não dê porcentagem ou nota de chance de aceitação. Diga o que realmente executou, o que só leu e o que não conseguiu examinar. Não simule reconstrução Lean, leitura bibliográfica ou revisão humana que não realizou. Não publique o Figshare nem envie nada à revista.
''')
write('COMECE_AQUI.md','''# Segunda rodada adversarial — pacote revisado completo

Use PEDIDO_SEGUNDA_RODADA_ADVERSARIAL.md como prompt principal para a próxima IA. O artigo atual é H12_quartic_revised_round2.pdf e H12_preprint.md. RESPOSTAS_AO_PARECER.md trata cada item do relatório anterior, inclusive as sugestões rejeitadas com fundamentação. CHANGELOG_SUBMISSAO.md registra o que mudou.

Incluem-se os documentos de submissão, o parecer anterior, as auditorias novas, V1 público v2 para comparação e as mesmas fontes/certificados matemáticos da prova original. Nenhuma busca ou execução Lean pesada foi reiniciada. O manuscrito anterior permanece em historico; não o confundir com o atual.

O Figshare continua rascunho com arquivos da primeira preparação. NÃO é o depósito público desta revisão. Ele deve ser atualizado antes de qualquer publicação. Nenhuma submissão à revista foi feita.

Pendências que não foram ocultadas: financiamento/interesses e declaração final de contribuições/aprovação; DOI público do depósito após a revisão; limite específico de arquivos e conversão do portal. São pendências antes do envio, não novos teoremas a provar. A análise dirigida de antecedentes não estabelece prioridade absoluta.
''')
write('STATUS_REVISAO2.json',json.dumps({'status':'READY_FOR_SECOND_ADVERSARIAL_REVIEW_NOT_FOR_SUBMISSION','article_revision':2,'abstract_words':len(abstract.split()),'formal_sources_changed':False,'new_lean_execution':False,'author_confirmed':['UniBH/Belo Horizonte','contatofilipevono@gmail.com','V1 and H12 not submitted to a journal'],'still_pending':['funding and interests','final author contributions/approval','public persistent H12 DOI','DCC portal size limit/conversion'],'figshare_contains_previous_article_revision':True,'received_report_sha256':'3b9747d0123f838f5367c38ab639696cc49825c18712709cc5b12132e9d0302a'},ensure_ascii=False,indent=2))
print('REVISION_DOCUMENTS_READY',len(responses),'responses')

# Carta e materiais de submissão

## Problemas da carta atual (`CARTA_AO_EDITOR_EN.md`)

1. Parágrafo 3: "earlier support-dependent nonexistence criteria" é vago; não diz o que se sabia nem por que H(12,4) era aberto.
2. Parágrafo 4: "The independent replay does not require repeating the original exhaustive search" sugere uma busca bruta anterior que o artigo não descreve, e puxa a atenção para a computação. Remover.
3. Cita "Lean 4.35.0" na carta; isso pertence ao artigo.
4. Não diz ao editor, em uma frase, por que a redução estrutural interessa.
5. Falta apontar para o depósito persistente dos dados.

O que está correto e deve ser mantido: não promete prioridade, não alega resolver a conjectura geral, não afirma exclusividade/ausência de conflitos/financiamento, não inventa DOI, identifica V1 com o DOI real, menciona a declaração de IA.

## Carta revisada (só fatos sustentados pelos materiais)

Colchetes = fatos a confirmar pelo autor ou pela literatura. Não preencher por palpite.

> Dear Editors,
>
> Please consider the manuscript "Nonexistence of homogeneous rotation symmetric bent functions of degree four in twelve variables" for publication in Designs, Codes and Cryptography.
>
> Stănică and Maitra conjectured that homogeneous rotation symmetric Boolean functions of degree greater than two are never bent. We settle the case of degree four in twelve variables: none of the 2^43 functions in the full quartic cyclic space is bent. The result is limited to this case; it does not address sixteen variables, other dimensions, or non-homogeneous functions.
>
> The proof reduces the problem, using weight-divisibility conditions and autocorrelations on 4-periodic inputs, to three explicit affine families of dimension 36, and then refutes each family with a certificate. [One sentence, verified against Sun et al. and Meng–Chen–Fu, on why this case was not covered by earlier criteria.] The soundness of the certificate rules and the three instances are verified in Lean 4; an independent Python checker replays the finite part.
>
> The manuscript separates the structural proof, the finite certificate and the Lean verification, and states the limits of each. Sources, the checker and verification records are archived at [DOI/repository] and supplied as supplementary files. We discuss in the introduction how recent constructions of rotation symmetric bent functions (Polujan–Kudin–Pasalic; Tang) differ in hypotheses from the case treated here.
>
> A related preprint by the author on the cubic case is available at https://doi.org/10.6084/m9.figshare.34165260.v2; the present proof does not use it as a hypothesis. The manuscript includes a declaration of AI-assisted tool use.
>
> Sincerely,
> Filipe Martins Vono
> Centro Universitário de Belo Horizonte (UniBH), Belo Horizonte, Brazil
> ORCID: https://orcid.org/0009-0009-4994-8533 · contatofilipevono@gmail.com

Se a verificação de literatura mostrar que o caso já era conhecido, **não enviar esta carta**; reescrever o enquadramento.

## Mudanças nos demais documentos

| Arquivo | Mudança |
|---|---|
| `RESUMO_E_DADOS_SUBMISSAO.md` | Trocar a transcrição do resumo pelo novo (ver `02`, Mudança 1); atualizar "Main result" se necessário |
| `DISPONIBILIDADE_DADOS_EN.md` | Depositar fontes e checker com DOI (Zenodo ou Figshare) e citar o DOI, mantendo os commits fixos como apoio; não citar a URL do rascunho Figshare |
| `DECLARACOES_PENDENTES.md` | Manter. Acrescentar: se qualquer IA adicional (inclusive esta análise) contribuir com texto ou revisão incorporada, atualizar a declaração |
| `RELACAO_V1_H12_E_POSICIONAMENTO.md` | Executar a comparação textual V1 × H12 (sobreposição, referências cruzadas, divisão editorial) e registrar o resultado, em vez de deixá-la para o avaliador |
| `CHECKLIST_ENVIO_E_CONTROLE_VERSOES.md` | Acrescentar itens: verificação de literatura do estado da arte; conferência do limite de tamanho do portal para o suplemento de ~49 MB; preparação do template do DCC; harmonização de datas |
| Todos | Criar `CHANGELOG_SUBMISSAO.md` e recalcular os hashes da versão enviada |

## Pendências factuais (bloqueios; só o autor confirma)

- Financiamento (presente ou ausente; qual).
- Conflitos de interesse.
- Contribuições do autor e aprovação.
- Exclusividade (sem submissão simultânea).
- Situação editorial atual de V1 (em avaliação? periódico e número?).
- Afiliação/e-mail atuais.

Nenhuma dessas lacunas é falha matemática. Não completar com frases-padrão por inferência.

## Sobre a escolha do periódico (sugestão de estratégia, não conclusão)

DCC publicou Sun et al. (citado no artigo), o que ajuda no encaixe temático. Mesmo assim o editor pode achar o escopo curto. Periódicos onde Stănică–Maitra e Meng–Chen–Fu já publicaram (por exemplo Discrete Applied Math, conforme as referências do artigo) são uma alternativa a considerar, caso o DCC recuse por escopo. Verificar as diretrizes atuais de cada um antes de decidir.

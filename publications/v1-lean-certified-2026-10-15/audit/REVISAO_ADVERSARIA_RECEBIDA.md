# Revisão adversária independente — teorema antipodal global

Data: 15 de outubro de 2026. Repositório: [contatofilipevono-rgb/hrsbf-bent-verification](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification).

## 1. Veredito e limite da conclusão

**APROVADO COM RESSALVAS.** Não encontrei erro matemático, definição enfraquecida, hipótese estrutural oculta ou atalho de prova na cadeia examinada. Reproduzi a construção dos fontes do projeto no SHA indicado e a inspeção dos seis teoremas finais; todos os comandos finais passaram e as dependências são exatamente `[propext, Classical.choice, Quot.sound]`. A fidelidade das definições e a interpretação dos dois objetivos globais foram verificadas separadamente da compilação.

As ressalvas são explícitas: a reprodução local necessitou de adaptação de localização de executáveis, e a comparação bibliográfica não permite certificar novidade/prioridade. A identidade geral de folding não foi formalizada separadamente e não é necessária à rota global. A aprovação diz respeito aos enunciados exatos, não à conjectura em todos os graus superiores a dois.

Esta revisão separa três questões: (i) o kernel aceita os termos de prova; (ii) os tipos e definições exprimem os conceitos convencionais; (iii) a interpretação matemática e editorial não ultrapassa esses tipos. Os relatórios anteriores foram usados somente como alegações a conferir, não como prova. Não foi alterado ou publicado nenhum arquivo da branch auditada.

## 2. Versões e referências efetivamente examinadas

| Item | Versão e resultado |
|---|---|
| Fontes Lean principais | Checkout destacado e limpo em `6dd183685ef8a5b033c1bcf8733496d57b853cc7` |
| Relatórios posteriores | `6f9f66c2e6bba001490e5245f6eb039158a37ffa`; certificado lido e diferença integral de nomes/estatísticas comparada ao SHA dos fontes |
| Cabeça da branch no clone desta revisão | `formal/astra-global-antipodal-2026-10-15` apontava para `6f9f66c2e6bba001490e5245f6eb039158a37ffa`; nenhum avanço posterior nessa branch foi observado nesse snapshot |
| Missão original | `formal/antipodal-global-completion-2026-10-14` resolvida no clone para `c333889462e4c08acfb9ae2b6a12ecb2124f8c15`; lido `formalization/ASTRA_MISSION_GLOBAL_LEAN4.md` nesse ref |
| Arquivo global | `formalization/Antipodal/GlobalAntipodal.lean` no SHA dos fontes; blob Git `45dbbd83962b02444b120831d9593e8a0c2a5b58` confirmado pela API |
| Certificado declarado | `research/astra-global-2026-10-15/KERNEL_CERTIFICATE.md` no SHA final; blob Git `4d333f526f45ca529da6ddeb6ddb917a0e914499` |
| CI inicial | Run `38682075049`, job `116248619552`, checkout real `9f186bc871361b263a9356a8d80cbcc837db21de` |
| CI com Walsh absoluto | Run `38682481132`, job `116249898348`, checkout real `6dd183685ef8a5b033c1bcf8733496d57b853cc7` |
| Lean | Distribuição oficial `leanprover/lean4:v4.15.0`, commit de release `11651562caae` |
| Mathlib | `9837ca9d65d9de6fad1ef4381750ca688774e608`, no lakefile, manifesto e checkout efetivo |

As referências estavam disponíveis pelo clone Git e pela API autenticada do GitHub. A abertura da página GitHub pelo mecanismo de pesquisa web falhou; isso não impediu a leitura dos bytes Git nem dos logs reais via API. Não deduzi o conteúdo a partir do título da página.

O diff entre os dois SHAs fornecidos altera nove arquivos, todos em `research/astra-global-2026-10-15/`: relatórios, manifesto e um log de CI. Não altera fontes Lean, configuração, dependências ou workflow. A versão auditada não foi substituída silenciosamente pelo commit posterior.

## 3. Reprodução independente

| Comando final, em `formalization/` | Exit | Duração |
|---|---:|---:|
| `lean --version` | 0 | 0.03 s |
| `lake --version` | 0 | 0.04 s |
| `git -C .lake/packages/mathlib rev-parse HEAD` | 0 | 0.0 s |
| `lake build` | 0 | 48.46 s |
| `lake env lean Antipodal/GlobalAntipodal.lean` | 0 | 3.25 s |
| `lake env lean Antipodal/WalshNormalization.lean` | 0 | 2.15 s |
| `lake env lean CheckGlobal.lean` | 0 | 2.39 s |
| `lake env lean <arquivo externo AuditSignatures.lean>` | 0 | 2.71 s |

Execução concluída: Lean 4.15.0 e Lake 5.0.0-1165156. O SHA efetivo da Mathlib coincide com o solicitado. O build final reconstruiu 32 módulos Antipodal e o módulo raiz, gerando 33 `.olean` do projeto. Antes dessa execução, os 33 produtos da primeira tentativa haviam sido eliminados; o primeiro clone tinha zero produtos do projeto. A primeira compilação limpa também passou (48,88 s), mas os comandos `lake env lean` inicialmente falharam ao resolver argv[0] sem caminho absoluto; após completar o shim com resolução pelo PATH, foi feita esta segunda compilação limpa e todos os comandos passaram. `reproduction_path_attempt.json` preserva as falhas iniciais; `reproduction.json` registra a execução final.

A saída independente de `AuditSignatures.lean` imprime as assinaturas com argumentos implícitos explicitados, as definições fundamentais e **os seis** conjuntos de axiomas. Cada um contém exatamente `propext`, `Classical.choice` e `Quot.sound`; um parser próprio conferiu presença dos seis e igualdade da lista, com saída em `final_axioms.json`. Nenhum `sorryAx` ou `Lean.ofReduceBool`. As provas de limite dos índices podem aparecer abreviadas pelo pretty-printer; não são hipóteses públicas adicionais.

O diretório de produtos **do projeto** `.lake/build` é apagado antes da reprodução. O clone não traz `.olean` versionados. Os dois módulos auxiliares fora do alvo raiz, `Endpoint2.lean` e `OddMultiplicity.lean`, também foram checados separadamente ao final, ambos com exit 0; não são dependências necessárias da montagem global. Os caches reaproveitados são de dependências fixadas, não dos módulos Antipodal. O log de build deve mostrar a construção dos módulos do projeto, inclusive `GlobalAntipodal` e `WalshNormalization`. Isto não é uma recompilação de todos os fontes da Mathlib: usa-se o cache da revisão fixada, conforme o escopo solicitado.

### Limitações e ajustes do ambiente

A execução inicial do `lean --version`, inclusive pelo caminho absoluto da distribuição, retornou `error: failed to locate application` (exit 1). A distribuição tenta localizar o próprio executável em `/proc/<pid>/exe`; a superfície deste ambiente não fornece o caminho esperado. Foi compilado um shim de localização (`path_shim.c`, incluído nas evidências) que intercepta somente `readlink` desses caminhos e devolve o caminho real do programa a partir de `/proc/self/cmdline`. Os binários, bibliotecas Lean e fontes do kernel não foram editados. A versão então imprimiu Lean 4.15.0, commit `11651562caae`.

O download auxiliar de `leantar` também encontrou uma falha de ownership do `tar`; o arquivo foi extraído com `--no-same-owner` e instalado no nome de versão esperado. Uma tentativa de release de ProofWidgets falhou; a execução explícita de `lake -v build proofwidgets:release` passou, seguida de nova obtenção de cache. Uma tentativa de cache com nomes pontuados falhou (`Unknown package directory`); foram usados os caminhos `.lean` documentados pelo cache. São falhas de preparação, não erros matemáticos nem provas aprovadas por ignorar mensagens de falha. Os logs originais foram preservados.

Não apresento a execução local como reprodução sem adaptações do sistema operacional. O shim não substitui decisões, redução, axiomas ou a checagem do kernel. Os CIs externos examinados usam o Lean oficial sem esse shim. Nenhum desses fatos certifica ausência de bugs no próprio Lean ou na plataforma, que permanecem na base de confiança usual.

### Inspeção de atalhos

Foi implementado um scanner próprio que remove comentários aninhados e strings antes de procurar identificadores proibidos. Foram examinados os 34 módulos `Antipodal/*.lean`, o módulo raiz e `CheckGlobal.lean` (36 arquivos). Nenhum token de `sorry`, `admit`, `sorryAx`, declaração `axiom`, `unsafe`, `native_decide`, `implemented_by`, `extern` ou `Lean.ofReduceBool` apareceu no código desses arquivos após essa limpeza.

`#print axioms` é um comando de inspeção, não uma declaração de axioma. Os usos de `decide` observados são casos finitos verdadeiros: aritmética em F₂, alternativas 0/1, pequenas cardinalidades e testemunhos de duas variáveis. A prova universal usa lemas gerais, não enumeração de dimensões. Táticas como `ring`, `omega` e `simp` produzem termos verificados pelo kernel. A lista de axiomas dos teoremas finais é a verificação decisiva de dependências; o scanner isolado não a substitui.

## 4. Fidelidade semântica dos enunciados

Todos os nomes abaixo pertencem ao namespace `HRSBF.Antipodal`.

| Conceito | Definição efetiva | Avaliação |
|---|---|---|
| Corpo e entradas | `F₂ := ZMod 2`; `Vec n := Fin n → F₂` em `LocalRigidity.lean` | Espaço booleano convencional, com todos os vetores |
| Rotação | `rotate x i := x (finRotate n i)` | Uma posição, com wraparound; os lemas modulares dão `(i+k) % n` |
| ANF | `anfCoefficient f s := ∑ t ∈ s.powerset, f (supportVector t)` | Transformada de Möbius booleana da ANF quadrado-livre, não escolha arbitrária de representação |
| Reconstrução e unicidade | `booleanMobius_involution`, `anf_reconstruction`, `anfCoefficient_unique`, `anf_polynomial_evaluation` | A ligação entre coeficiente e função é provada |
| Grau ≤ 3 | Todo suporte com cardinalidade > 3 tem coeficiente canônico zero | Não exclui grau 0, 1 ou 2; constantes e lineares são livres, sujeitos à simetria |
| Homogeneidade cúbica | Todos os suportes de cardinalidade diferente de 3 têm coeficiente zero; existe coeficiente cúbico 1 | Exatamente grau 3 e homogênea; não inclui a função zero |
| Walsh | `sign b = if b=0 then 1 else -1`; `dot b x = ∑ i, b i*x i`; `walsh f b = ∑ x, sign(f x)*sign(dot b x)` | Transformada não normalizada, inteira, em todas as frequências |
| Bent | `∀ b, walsh f b ^ 2 = Fintype.card (Vec n)` em ℤ | Em `n=2H`, equivale exatamente a magnitude `2^H` |
| Antipodal | Coeficiente do suporte `{0,H}` em `2H` coordenadas | É um coeficiente, não soma dos coeficientes de toda a órbita |

A órbita antipodal contém H pares distintos. Por RS, `anfCoefficient_rotation_pow` propaga o coeficiente de `{0,H}` para todos os pares. Logo o valor encontrado é o coeficiente de `P_(2H)=Σ_(i=0)^(H−1) x_i x_(i+H)` na decomposição por órbitas. Somar os H coeficientes em F₂ seria outra operação e poderia zerar para H par; o código não comete essa identificação.

Os seis enunciados públicos pedidos têm os quantificadores e hipóteses pretendidos:

1. `universal_antipodal`: para H natural positivo, f em H+H coordenadas, grau canônico ≤3, RS e bent, o coeficiente de `{0,H}` é 1.
2. `universal_antipodal_2h`: a mesma conclusão em `2*H` coordenadas.
3. `universal_antipodal_canonical`: parametrização por `2*(h+1)`, que cobre todo H>0; não é restrição a uma subfamília.
4. `no_homogeneous_cubic_rotation_symmetric_bent`: homogeneidade cúbica e RS implicam não bent em H+H, H>0.
5. `universal_antipodal_walsh_absolute`: traz literalmente a hipótese `∀ b, |∑ x, sign (f x + dot b x)| = (2 : ℤ)^H`.
6. `no_homogeneous_cubic_rotation_symmetric_bent_absolute`: a não existência usando literalmente essa mesma condição convencional.

`WalshNormalization.lean` prova `isBent_iff_walsh_absolute` por `|Vec(2H)|=(2^H)^2` e igualdade de quadrados/valores absolutos em ℤ. Não se troca soma inteira por soma em F₂. O uso de naturais positivos expressa os inteiros positivos solicitados sem perda de casos.

### H = 1 e não vacuidade

Em duas variáveis, o suporte `{0,H}` tem dois elementos distintos e o alvo é o único coeficiente quadrático. A rota geral permite `r=0,m=1,h=1,k=1`; o complemento da média é zero-dimensional e é tratado pelas identidades finitas. A fibra complementar contém duas entradas, não um conjunto vazio.

Há 8 funções bent nas 16 tabelas de duas variáveis; 4 são RS e todas têm coeficiente `x₀x₁=1`, confirmado por teste independente. Os quatro testemunhos RS são `x₀x₁+a(x₀+x₁)+c`, com a,c∈F₂. Em dimensão 2, a premissa "homogênea exatamente cúbica" é impossível por falta de suportes de tamanho 3; a vacuidade desse caso do corolário é legítima. O teorema antipodal, por sua vez, é não vacuoso nesse mesmo caso.

Também há testemunhos matemáticos em toda dimensão 2H: `P_(2H)+aΣx_i+c` é RS e bent por fatoração do Walsh em H pares independentes. O projeto formaliza explicitamente a não vacuidade na fronteira; não atribuo ao arquivo `Nonvacuity.lean` um teorema formal de existência em toda dimensão que ele não declara.

## 5. Reconstrução adversária da cadeia completa

### 5.1. Rigidez quadrática, sem eliminar o radical por suposição

| Arquivo e declaração | Hipóteses efetivas | Justificação e ponto auditado |
|---|---|---|
| `QuadraticPolar.lean`: `quadratic_polar_add_right/left` | `third Q a b c=0` para todos a,b,c | O polar normalizado `Q(a+b)+Q(a)+Q(b)+Q(0)` é bilinear. O termo Q(0) está presente |
| `RadicalInvariant.lean`: `radicalSubmodule`, `radical_stable_under_linear_equiv`, `radical_proper_of_nonzero_polar` | Quadraticidade, S linear invertível, Q∘S=Q, e polar não zero para a última conclusão | O radical é realmente submódulo estável e próprio; não se confunde com o conjunto Q=0 |
| `PowerTwoNilpotence.lean`: `shift_plus_one_nilpotent` | S^(2^k)=I | Em característica 2, (S+I)^(2^k)=0, com Frobenius provado para endomorfismos |
| `CyclicQuadraticRigidity.lean`: `cyclic_image_iff_parity_zero`, `cyclic_range_eq_parity_ker`, `cyclicShift_pow` | Rotação concreta; identidades também cobrem fronteiras indicadas | `im(S+I)=ker(Σx_i)` por somas prefixas e wraparound; S^N=I |
| `NilpotentNakayama.lean`: `nilpotent_stable_decomposition_forces_top` | T nilpotente, R estável, V=R+im(T) | Iterar a decomposição até T^m=0 força R=V |
| `NilpotentHyperplane.lean`: `proper_stable_le_range_of_nilpotent_hyperplane` | Hipótese de geração módulo im(T), nilpotência e R próprio | Se R contivesse vetor fora da imagem, geraria V módulo im(T) e contrariaria o lema anterior |
| `CyclicQuadraticRigidity.lean`: `cyclic_quadratic_radical_image` | N=2^k, Q quadrática RS, polar não zero | Instancia a hipótese de geração com paridade e a nilpotência com S; não deixa `himage` como premissa final |
| `QuadraticRadical.lean`: `radical_image_value_zero`, `radical_vanishes_of_image` | r∈radical e r=Sy+y, Q∘S=Q | Substituição direta no polar dá Q(r)=Q(0). Mantém termos afins |
| `QuadraticGauss.lean`: `quadratic_walsh_square` | Q quadrática | `(Σ(-1)^Q)^2=|V| Σ_(r∈radical)(-1)^(Q(r)+Q(0))` |
| `QuadraticBalanceBridge.lean` e `CyclicQuadraticRigidity.lean`: `balanced_rotation_invariant_quadratic_polar_zero` | Q quadrática RS balanceada em 2^k coordenadas, k≥1 | Se o polar não fosse zero, Q seria constante no radical e a soma de Gauss não poderia zerar, pois o radical contém 0 |

A passagem crítica é a imagem de S+I **dentro do radical estável**, não somente no espaço ambiente. Na rota nilpotente ela é obtida pela condição de submódulo próprio; na rota sem pontos fixos abaixo, pela bijetividade no próprio radical. Não encontrei o salto indevido "surjetivo no ambiente ⇒ surjetivo no radical".

### 5.2. Fourier e a contradição em potência de dois

`Fourier.lean` demonstra ortogonalidade de caracteres e Parseval com inteiros. `Autocorrelation.lean` prova inversão, `transform_autocorrelation` e `bent_iff_derivative_balanced` sem hipótese de grau ou RS: bent equivale a todas as derivadas não nulas serem balanceadas. Não usa apenas a frequência zero para definir bent.

`DerivativeBridge.lean:cubic_derivative_third_zero` deriva a quadraticidade de `D_a f` de `HasCubicRepresentation`. `ANFPolynomial.lean:hasCubicRepresentation_of_anf_degree` fornece essa representação a partir do grau canônico, incluindo monômio vazio e monômios lineares/quadráticos. `Autocorrelation.lean:bent_cyclic_cubic_derivative_polar_zero` aplica a rigidez a `Q=D_J f`, J=vetor de uns: J≠0, Q é RS e balanceada, logo seu polar é zero.

Agora suponha que f seja constante na diagonal (u,u). Em coordenadas de dois blocos, `Fourier.lean:complementary_fiber_balance` usa os valores Walsh nos pares de frequências (b,b). A fibra z=0 já consome toda a energia de Parseval; então toda fibra z≠0 deve ser balanceada. A normalização é `|Vec h|²`, correspondente a 2h variáveis, e não `|Vec h|`.

Por outro lado, `LocalRigidity.lean:fiber_polar_eq_derivative_polar` relaciona o polar da fibra `u↦g(u,u+J)` ao polar de `D_(J,J)g`. Usa grau≤3, constância diagonal e troca de blocos; a comparação de terceiras diferenças é expandida em termos de produtos de formas afins. `Cyclic.lean:local_complementary_fiber_rigidity` obtém troca de blocos e rotação com seam flip a partir da rotação concreta. A fibra é afim com parte linear L; a invariância `u↦rotate(u)+e_last` força L(e_last)=0 e igualdade de L em todos os vetores da base, logo L=0. Assim a fibra complementar é constante e tem soma ±2^h, não zero.

`Main.lean:not_bent_of_diagonal_and_derivative_polar_zero` combina as duas conclusões incompatíveis. `BlockCoordinates.lean` fornece `joinBlocks`, a identidade do dot/Walsh e o transporte das rotações. `PowerTwoCubic.lean:not_bent_constant_diagonal_power_two_of_cubic` descarrega de fato o polar zero pela rigidez; a constância diagonal permanece explicitamente condicional **nesse lema**, sendo provada depois para a aplicação global. Não há circularidade entre o lema condicional e o teorema universal.

### 5.3. Redução por simetria de ordem ímpar

`OddProjector.lean` define `P=Σ_(j<m)S^j`. Sob m ímpar e S^m=I, a imagem de P é o espaço fixo U, P|U=I e P²=P. Como m=1 em F₂, não há divisão indevida por inteiro. `orbitAverage_decomposition` e `OddRestriction.lean:averagingEquiv` dão V=U⊕K, K=ker(P), e provam que S não tem vetor fixo não nulo em K. Ordem **dividindo** m basta; não é necessário afirmar ordem exatamente m.

Para Q quadrática S-invariante, `fixed_kernel_polar_zero` prova B(U,K)=0 pela soma das órbitas. `FiniteQuadratic.lean:finite_fixed_free_radical_image` aplica S+I ao radical em K: é endomorfismo injetivo do próprio radical, logo sobrejetivo por finitude. Invariância dá Q=Q(0) nesse radical. A identidade de Gauss finita prova que o fator de soma em K é não zero, inclusive K={0} e polares degenerados.

Consequentemente, `odd_order_quadratic_balance_iff` prova a fatoração exata

`Σ_V sign(Q) = sign(Q(0)) · (Σ_U sign(Q|U)) · (Σ_K sign(Q|K))`.

O fator `sign(Q(0))` evita contar a constante duas vezes. A equivalência de balanceamento decorre de o fator K ser não nulo. A prova não usa invariância sozinha para afirmar que restrições de bent arbitrárias continuam bent.

`odd_order_cubic_fixed_derivatives_balanced` aplica esse resultado a Q=D_a f para a∈U não nulo: Q é quadrática, S-invariante e balanceada por bentness original. `odd_order_bent_restriction` usa o critério de derivadas no espaço menor, em coordenadas dadas por uma equivalência linear e. Não assume bentness da restrição nem uma dimensão par do espaço fixo sem demonstração.

Em `CyclicOddCoordinates.lean`, S é a rotação por t posições em N=t*m coordenadas. `repeatBlock` é literalmente `(Ry)_i=y_(i mod t)`; `cyclicPower_fixed_periodic` prova que todo vetor fixo é dessa forma, e `cyclicFixedEquiv` constrói a equivalência linear com `Vec t`. `repeatBlock_rotate` entrelaça a rotação de **uma** posição no espaço menor com a original. `bent_repeatInto` e `rotationSymmetric_repeatInto` dão a restrição bent e RS. `CubicTransport.lean:hasCubicRepresentation_comp_linear` preserva a representação de grau≤3 por substituição linear; não promete preservar homogeneidade exata, o que nem seria necessário.

### 5.4. ANF, meia-volta e a montagem universal

`DiagonalANF.lean:constant_on_fixed_vectors_of_antipodal_absence` trata uma involução livre e uma função invariante de grau≤3. Os suportes não fixos vêm em pares de mesma avaliação e mesmo coeficiente; cancelam em F₂. Um suporte fixo não vazio de tamanho≤3 só pode ser um par `{i,e(i)}`: suportes ímpares 1 ou 3 são impossíveis. Os pares têm coeficiente zero pela hipótese. Sobra apenas o termo vazio, f(0). Isto cobre termos afins e órbitas curtas sem contar erroneamente cada monômio n vezes.

`PowerTwoCubic.lean:antipodal_pairs_zero_of_base_zero` usa covariância da ANF por rotações para zerar todos os pares a partir de `{0,H}`. `constant_on_halfTurn_fixed_of_antipodal_zero` conclui f(x)=f(0) para **todo** x fixo da meia-volta, em qualquer H>0.

`GlobalAntipodal.lean:antipodal_necessity_factored` escreve H=2^r*m, m positivo ímpar, escolhe h=2^r e g(y)=f(Ry) em 2h coordenadas. O argumento é:

1. g é bent pela redução ímpar, RS por entrelaçamento e tem representação de grau≤3 por composição linear.
2. Se o coeficiente antipodal original não é 1, é 0 porque o corpo é F₂.
3. Para y=(u,u), o vetor repetido R(y) é fixo da meia-volta do espaço original. `repeated_diagonal_fixed` prova isso pelo cálculo modular `(i+hm) mod h = i mod h`.
4. A constância de f nesse espaço fixo dá g(u,u)=g(0).
5. A dimensão de g é 2h=2^(r+1); a contradição em potência de dois aplica-se.

`positive_two_power_odd_factor` usa indução forte em H: se H é ímpar escolhe r=0; se H é par positivo escreve H=a+a e aplica a indução a 0<a<H. Não há limite finito ou fatorização assumida sem prova. `universal_antipodal` substitui essa fatorização. O corolário homogêneo aplica a definição canônica ao suporte de dois elementos, obtendo simultaneamente coeficiente 0 e 1.

### 5.5. Identidade de folding não demonstrada separadamente

A rota global **dispensa** a igualdade geral de preservação do coeficiente antipodal por folding: ela não calcula nenhum coeficiente da função reduzida g. Transporta somente a constância de f no espaço fixo para a diagonal de g. Inspecionei as chamadas da montagem global e os lemas de transporte; não há hipótese disfarçada dessa igualdade.

`OddMultiplicity.lean` prova apenas fatos de multiplicidade par/ímpar em F₂. Isso não é a identidade geral de coeficientes. A missão original pedia tal identidade como um dos meios; essa subentrega permanece ausente, mas a ausência não invalida os dois objetivos globais alcançados pela rota alternativa. Não declaro a identidade provada, nem sequer deduzida da compilação.

## 6. Testes independentes exatos

Foram escritos novos programas C++ e Python nesta revisão; não foram usados os scripts de busca entregues pelos autores para obter os números abaixo. O C++ enumera órbitas **distintas** de suportes, calcula tabelas por ANF e Walsh por Hadamard inteiro. O Python calcula Walsh por soma direta, polar e Möbius, fornecendo uma segunda implementação. Não foi usada aritmética de ponto flutuante ou amostragem nos resultados tabulados.

### Todas as funções RS de grau ≤ 3 nas dimensões indicadas

| n | Órbitas ANF incluindo vazio/linear | Funções examinadas | Bent | Homogêneas exatamente cúbicas examinadas | Bent homogêneas cúbicas |
|---:|---:|---:|---:|---:|---:|
| 2 | 3 | 8 | 4 | 0 | 0 |
| 4 | 5 | 32 | 8 | 1 | 0 |
| 6 | 9 | 512 | 48 | 15 | 0 |
| 8 | 13 | 8.192 | 256 | 127 | 0 |
| 10 | 19 | 524.288 | 6.336 | 4.095 | 0 |

Total: 533.032 funções nessas cinco classes. Todas as 6.652 bent encontradas têm coeficiente antipodal 1. Para cada função com coeficiente antipodal 0, testou-se cada vetor da diagonal da meia-volta, confirmando f(x)=f(0): respectivamente 4,16,256,4096 e 262144 funções. Para cada bent, testou-se também sua redução à parte de dimensão potência de dois. As reduções não triviais incluem todos os 48 casos de n=6 e 6.336 casos de n=10; continuaram bent. As classes incluem as órbitas cúbicas curtas de n=6, além de constantes e lineares.

Para as quadráticas RS balanceadas em n=2,4,8, o polar foi conferido em todos os pares de vetores da base e era zero (duas funções balanceadas em cada dimensão). A bilinearidade do polar das quadráticas faz esse teste de base suficiente.

### Balanceamento e degenerescências

Para a ação coordenada S=rotação por t, foram enumeradas **todas** as ANFs quadráticas S-invariantes, não somente as RS sob uma posição:

| n | t | Ordem dividindo | ANFs examinadas | Balanceadas |
|---:|---:|---:|---:|---:|
| 0 | 1 | 1 | 2 | 0 |
| 3 | 1 | 3 | 8 | 4 |
| 6 | 2 | 3 | 256 | 96 |
| 9 | 3 | 3 | 65.536 | 35.840 |

Em cada caso a soma inteira total é zero se e somente se a soma no espaço fixo é zero.

O Python enumera ainda todas as quadráticas, **sem simetria imposta**, em dimensões 0,1,2,3,4: 2,4,16,128 e 2048 ANFs. Confirma reconstrução por Möbius e a identidade exata de Gauss sobre o radical em todos esses casos, inclusive constantes, formas afins balanceadas, radical total e radical trivial. Nas funções invariantes sob ações lineares de ordem 3 `S(a,b)=(b,a+b)`, ou soma direta de dois desses blocos, verifica transferência de balanceamento e o fator não nulo quando não há fixos não nulos.

Também enumera as 32768 ANFs de grau≤3 em quatro variáveis para cada uma de duas ações lineares de ordem 3 que não são apenas permutações de coordenadas:

| Ação | Invariantes | Bent invariantes | Dimensão fixa | Restrição bent |
|---|---:|---:|---:|---|
| Um bloco S e duas coordenadas fixas | 128 | 8 | 2 | Todos os 8 casos |
| Dois blocos S | 32 | 20 | 0 | Todos os 20 casos, incluindo espaço zero-dimensional |

Por fim, todas as 16 tabelas de duas variáveis foram examinadas por Walsh direto. Nenhum teste falhou e não há contraexemplo a minimizar. Esses resultados exaustivos valem somente para as classes tabuladas; não são uma prova universal nem uma enumeração de todas as ações lineares em dimensões arbitrárias.

## 7. Logs reais de CI

Os dois jobs foram consultados via GitHub, incluindo o texto integral dos logs, não somente o status visual ou os logs copiados para o repositório. Ambos registram conclusão `success`.

- [Run inicial](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38682075049): checkout `9f186bc871361b263a9356a8d80cbcc837db21de`, Lean 4.15.0, Mathlib fixada, build completo; `GlobalAntipodal` construído; `CheckGlobal` imprime interfaces centrais e axiomas. Esse job **não** certifica a interface absoluta acrescentada no commit seguinte.
- [Run final dos fontes](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/38682481132): checkout `6dd183685ef8a5b033c1bcf8733496d57b853cc7`, mesmo Lean e Mathlib, construção de `GlobalAntipodal`, `WalshNormalization` e módulo raiz, execuções standalone e `CheckGlobal`. Os logs exibem a hipótese convencional de Walsh absoluto e os axiomas dos teoremas correspondentes.

O workflow usa checkout novo, não restaura um cache de `.olean` do projeto e executa `lake build`. `Antipodal.lean` importa `WalshNormalization` e `Nonvacuity`, que alcançam a prova global. Os logs mostram efetivamente os módulos sendo construídos. Há `set -euo pipefail`, portanto `tee` não mascara falha do Lean. A expressão regular da allowlist considera listas de axiomas multilineares. Os runs são duas execuções do mesmo workflow, não duas revisões matemáticas humanas independentes.

## 8. Achados por gravidade

### A. Falhas críticas ou maiores do teorema

Nenhuma encontrada na inspeção dos fontes, reconstrução matemática e buscas exatas realizadas. Esta afirmação não significa que se demonstrou impossibilidade de qualquer erro futuro de revisão ou do kernel.

### B. Limitação relevante: novidade e prioridade não certificadas

Arquivo/declaração afetada: qualquer interpretação editorial de `KERNEL_CERTIFICATE.md`/status global como certificado de originalidade. Evidência: a pesquisa encontrou trabalhos anteriores próximos, incluindo publicação de abril de 2026 cujo texto integral não ficou disponível. Impacto: não é legítimo concluir prioridade histórica ou aceitação em periódico apenas da prova formal. Nenhum efeito sobre a validade lógica dos tipos Lean.

### C. Limitação de reprodução local: localização de executáveis

Arquivo afetado: ambiente de execução, não um fonte Lean. Evidência: falha inicial de localização e shim descrito na seção 3. Impacto: a execução local deve ser descrita com essa adaptação; não se deve anunciar uma reprodução local sem ajustes. Os logs de CI sem shim e a preservação dos binários oficiais são evidências complementares, não motivo para ocultar a adaptação.

### D. Achado menor: omissão de inspeção explícita de axiomas de uma interface

Arquivo: `formalization/CheckGlobal.lean`. Declaração: `universal_antipodal_2h`. Evidência: o arquivo executa `#check` dessa interface, mas não seu `#print axioms`; imprime os axiomas de outras cinco interfaces. Impacto: a afirmação estrita de inspeção explícita dos **seis** itens pede um comando adicional. O arquivo independente `AuditSignatures.lean` inclui os seis; nenhuma edição na branch auditada é necessária. A interface `_2h` deriva diretamente da universal por reindexação de dimensões; não foi encontrada hipótese matemática adicional.

### E. Achado editorial: comentários locais de etapas anteriores

Arquivos: `QuadraticBalanceBridge.lean`, `DerivativeBridge.lean`, `Main.lean`, `QuadraticRadical.lean`. Evidência: comentários mencionam etapas ainda "missing" ou "remaining" em módulos condicionais que são descarregadas por módulos posteriores. Impacto: podem confundir quem lê isoladamente, mas não indicam premissa global pendente. Uma revisão editorial separada pode esclarecer o contexto histórico desses comentários.

### F. Subentrega auxiliar ausente e dispensável

Arquivo: missão original, pilar de transporte exato de coeficiente; `OddMultiplicity.lean`. Evidência: os únicos lemas de multiplicidade são elementares e a montagem global transporta constância. Impacto: a identidade geral de coeficientes continua sem formalização separada; não é uma lacuna dos dois teoremas globais.

## 9. Comparação bibliográfica e limites de acesso

Foram consultadas fontes primárias acessíveis:

1. Cusick e Sanger, *Rotation Symmetric Bent Boolean Functions for n=2p*, [arXiv:1708.09313v1](https://arxiv.org/pdf/1708.09313). A seção 2, especialmente Corolário 2.8, já estabelece a necessidade do termo antipodal para bent RS quadráticas; também há resultados para somas de ciclos curtos e dimensões 2p. Isso deve ser distinguido da extensão global de grau≤3 examinada aqui.
2. Zhang e Gao, *On the conjecture about the nonexistence of rotation symmetric bent functions*, [arXiv:1303.2282v1](https://arxiv.org/pdf/1303.2282). O texto apresenta condições e famílias parciais; não usei seu título como prova de uma solução universal cúbica.
3. Meng, Chen e Fu, *On homogeneous rotation symmetric bent functions*, Discrete Applied Mathematics 158 (2010), 1111–1117, [DOI 10.1016/j.dam.2010.02.009](https://doi.org/10.1016/j.dam.2010.02.009). Resumo editorial acessível declara resultados parciais; o texto integral não foi recuperado nesta revisão.
4. Sun, Shi, Liu e Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, Designs, Codes and Cryptography 94, artigo 93 (2026), [DOI 10.1007/s10623-026-01848-4](https://link.springer.com/article/10.1007/s10623-026-01848-4). A página primária confirma publicação em 13/04/2026 e resultados parciais; o texto integral está atrás de acesso por assinatura. O resumo não determina se alguma subfamília coincide com todo o caso cúbico; essa comparação fica pendente.

Esta comparação não é uma pesquisa bibliográfica exaustiva. Não pude verificar todas as versões publicadas, todos os resultados de 2026 nem toda a proveniência de cada lema. A validade da construção formal não depende de o resultado ser novo; atribuição e prioridade exigem trabalho separado. Não infiro da aprovação de um kernel uma revisão por pares, importância criptográfica prática ou solução da conjectura em todos os graus >2.

## 10. Lacunas e conclusão em português

**Sim: é justificável afirmar que os dois objetivos globais foram demonstrados, para os enunciados exatos auditados.** A prova alcança toda dimensão par positiva, permite termos lineares e constantes na necessidade antipodal e deriva a inexistência homogênea cúbica da ANF canônica. A reprodução independente dos fontes e a lista de axiomas confirmam a certificação pelo kernel; a inspeção semântica confirma que não se formalizou apenas uma versão enfraquecida ou condicional.

Não encontrei lacuna matemática restante na cadeia desses dois resultados. Restam a subentrega auxiliar dispensável de folding, a comparação completa com literatura e melhorias editoriais menores. O resultado não é uma demonstração da inexistência homogênea em graus 4 ou maiores e não certifica originalidade, prioridade, revisão por pares ou aceitação de artigo.

Não foi demonstrada separadamente a igualdade geral de coeficientes por folding, nem isso foi necessário na cadeia global. Não foi auditado aqui o restante dos projetos V1/V2/V3 ou a correspondência linha a linha com um manuscrito externo não indicado como versão de referência desta missão. O objeto certificado nesta revisão é a afirmação matemática expressa pelos seis tipos públicos, usando os conceitos convencionais verificados acima.

As evidências anexas contêm código próprio de teste, resultados, scanner, assinaturas, comandos e logs locais/CI. Os números de testes são apoio adversário; a universalidade vem da prova geral examinada e da checagem formal reproduzida quando registrada como concluída na seção 3.

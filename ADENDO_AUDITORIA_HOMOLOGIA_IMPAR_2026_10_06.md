# Adendo de auditoria adversarial — homologia ímpar

Data: 2026-10-06

Repositório: https://github.com/contatofilipevono-rgb/hrsbf-bent-verification  
Branch obrigatória: `colab-a100-2026-10-06`

> **Instrução ao auditor:** antes de começar, registre o SHA exato da versão que realmente auditou. Não substitua silenciosamente esta branch por `main`.

## Objetivo

Auditar adversarialmente uma nova prova candidata para

\[
H_{2r+1}\!\left(C_\bullet(\Delta^{2^k-1};\mathbf F_2)^{C_{2^k}}\right)=0
\]

para todo \(k\ge 1\) e todo grau ímpar permitido.

Não tente “salvar” a prova. Procure erros de indexação, convenção, aplicação indevida de teoremas externos, confusão entre invariantes/coinvariantes, homologia/cohomologia/Tate, erro em syzygies \(\Omega\), Burnside ou Euler–Poincaré.

Se uma etapa não estiver completamente justificada, marque-a como **GAP** mesmo que os dados computacionais concordem.

---

## Objeto

Para

\[
N=2^k,\qquad G=C_N,\qquad \Bbbk=\mathbf F_2,
\]

considere o módulo regular

\[
V_N=\Bbbk[G].
\]

O complexo \(C_\bullet(N)\) tem em grau \(d\) a base das órbitas cíclicas de \(d\)-subconjuntos de \(\mathbb Z_N\), e diferencial induzida por apagar um vértice, com as multiplicidades orbitais corretas em \(\mathbf F_2\).

A nova prova candidata identifica

\[
C_d(N)\cong (\Lambda^dV_N)^G.
\]

Se

\[
\varepsilon:V_N\to\Bbbk
\]

é a augmentação e

\[
W_N=\ker\varepsilon,
\]

a diferencial exterior é a contração por \(\varepsilon\).

---

# PASSO A — ciclos como potências exteriores do augmentation ideal

Alega-se:

\[
\ker\left(
\partial:\Lambda^dV_N\to\Lambda^{d-1}V_N
\right)
=
\Lambda^dW_N.
\tag{A1}
\]

Daí

\[
Z_d(C_\bullet(N))
=
(\Lambda^dW_N)^G.
\tag{A2}
\]

Audite:

1. A1 diretamente.
2. A passagem
   \[
   (\ker\partial)^G
   =
   \ker(\partial|_{(\Lambda^dV)^G}).
   \]
3. As convenções de grau: aqui \(d\) é cardinalidade do subconjunto, não dimensão simplicial.

---

# PASSO B — homologia par como cohomologia de grupo

Para \(d=2i\), usa-se a sequência exata

\[
0\to
\Lambda^{2i+1}W_N
\to
\Lambda^{2i+1}V_N
\xrightarrow{\partial}
\Lambda^{2i}W_N
\to0.
\tag{B1}
\]

Como \(2i+1\) é ímpar e \(G=C_{2^k}\), todo \((2i+1)\)-subconjunto teria estabilizador trivial. Logo \(\Lambda^{2i+1}V_N\) seria uma soma de módulos regulares, portanto livre/projetivo.

Aplicando invariantes, alega-se

\[
\boxed{
H_{2i}(C_\bullet(N))
\cong
H^1\!\left(G,\Lambda^{2i+1}W_N\right).
}
\tag{B2}
\]

Audite independentemente:

1. se o cokernel ao aplicar invariantes é realmente a homologia \(H_{2i}\);
2. se falta algum termo \(H^0\), imagem ou kernel;
3. se a projetividade usada é suficiente;
4. se todo subconjunto de cardinalidade ímpar tem estabilizador trivial sem exceção.

---

# PASSO C — ponto crítico: Himstedt–Symonds

Escreva

\[
N=2h.
\]

O augmentation ideal \(W_N\) é o indecomponível de dimensão \(N-1\), normalmente denotado \(V_{N-1}\).

A especialização candidata do teorema de Himstedt–Symonds é

\[
\boxed{
\Lambda^{2i+1}W_{2h}
\cong_{\rm proj}
\Omega_{2h}^{\,i+1}\Lambda^iW_h.
}
\tag{C1}
\]

Este é o ponto mais importante da auditoria.

Leia o **Teorema 1.1 original de Himstedt–Symonds** e confira literalmente:

- parametrização dos módulos \(V_s\);
- se \(W_{2h}=V_{2h-1}\);
- qual parâmetro \(s\) deve ser usado;
- índices \(2i+1\) versus \(i\);
- expoente exato de \(\Omega\);
- eventual dualidade;
- sinais;
- faixa permitida de \(i\);
- se aparecem outros termos não projetivos;
- se a congruência módulo projetivos é suficiente para o uso posterior.

**Não aceite C1 por plausibilidade.**

Se houver shift incorreto, dê a fórmula corrigida.

---

# PASSO D — periodicidade e inflação \(C_{2h}\to C_h\)

Defina

\[
M_i=\Lambda^iW_h
\]

e considere-o inflado para \(C_{2h}\) pelo quociente

\[
C_{2h}\twoheadrightarrow C_h.
\]

Então \(g^h\) age trivialmente.

A norma

\[
\mathcal N=1+g+\cdots+g^{2h-1}
\]

deveria agir como zero porque

\[
\mathcal N
=
(1+g+\cdots+g^{h-1})(1+g^h)
\]

e, em característica \(2\),

\[
1+g^h=0
\]

sobre \(M_i\).

Usando a resolução 2-periódica de \(C_{2h}\), a prova conclui

\[
\dim H^1\!\left(
C_{2h},
\Omega^{i+1}M_i
\right)
=
\dim M_i^{C_h}.
\tag{D1}
\]

Como

\[
M_i^{C_h}
=
(\Lambda^iW_h)^{C_h}
=
Z_i(C_\bullet(h)),
\]

teríamos a recursão central

\[
\boxed{
b_{2i}(2h)=z_i(h).
}
\tag{R}
\]

Aqui

\[
b_j(n)=\dim H_j(C_\bullet(n)),
\qquad
z_j(n)=\dim Z_j(C_\bullet(n)).
\]

Audite especialmente:

- \(H^1\) versus \(\widehat H^1\);
- homologia versus cohomologia;
- efeito exato de \(\Omega^{i+1}\);
- somandos projetivos;
- invariantes versus coinvariantes;
- se só obtemos igualdade de dimensões ou um isomorfismo canônico.

Para o fechamento final, igualdade de dimensões basta.

---

# Checagens computacionais conhecidas

A recursão (R) concorda com os cálculos já feitos:

Para \(N=8\),

\[
(b_0,b_2,b_4,b_6)
=
(1,1,1,1),
\]

e

\[
(z_0,z_1,z_2,z_3)(4)
=
(1,1,1,1).
\]

Para \(N=16\),

\[
(b_0,b_2,\ldots,b_{14})
=
(1,1,3,5,5,3,1,1),
\]

e

\[
(z_0,\ldots,z_7)(8)
=
(1,1,3,5,5,3,1,1).
\]

Se (R) for válida, para \(N=32\) ela prevê

\[
\boxed{
(b_0,b_2,\ldots,b_{30})
=
(1,1,7,29,87,189,315,405,
405,315,189,87,29,7,1,1).
}
\]

Essas coincidências **não são prova**.

---

# PASSO E — Burnside

Defina

\[
T_n=\sum_d\dim C_d(n),
\]

o número total de órbitas de subconjuntos de \(\mathbb Z_n\), e

\[
\chi_n
=
\sum_d(-1)^d\dim C_d(n).
\]

Para \(n=2^k\), alega-se

\[
\boxed{
\chi_n=
\frac1n
\sum_{j=1}^{k}
2^{j-1}\,2^{n/2^j}.
}
\tag{E1}
\]

Derive E1 do zero por Burnside, inclusive a contribuição da identidade e do subconjunto vazio.

Depois prove ou refute

\[
\boxed{
T_h=2\chi_{2h}-\chi_h.
}
\tag{E2}
\]

Não aceite E2 só porque funciona numericamente.

---

# PASSO F — fechamento por Euler–Poincaré

Se

\[
Z_h=\sum_i z_i(h),
\qquad
B_h=\sum_i b_i(h),
\]

alega-se para qualquer complexo finito

\[
\boxed{
2Z_h=T_h+B_h.
}
\tag{F1}
\]

Cheque os índices nas extremidades.

Suponha indutivamente que a homologia ímpar de \(C_\bullet(h)\) é zero. Então

\[
B_h=\chi_h.
\]

Por E2 e F1,

\[
Z_h
=
\frac{T_h+\chi_h}{2}
=
\chi_{2h}.
\tag{F2}
\]

Pela recursão (R),

\[
\sum_i b_{2i}(2h)
=
\sum_i z_i(h)
=
Z_h
=
\chi_{2h}.
\tag{F3}
\]

Euler–Poincaré também dá

\[
\chi_{2h}
=
\sum_i b_{2i}(2h)
-
\sum_i b_{2i+1}(2h).
\]

Logo F3 forçaria

\[
\sum_i b_{2i+1}(2h)=0.
\]

Como dimensões são não negativas,

\[
b_{2i+1}(2h)=0
\]

para todo \(i\).

Cheque o caso-base \(N=2\) explicitamente.

---

# Conexão com openai/math

A mudança de linguagem foi motivada por arquivos do repositório público `openai/math`, liberado em 2026-10-06.

Trilhas relevantes:

1. **Bounded-degree coboundary expanders in every dimension**  
   A seção de homologia usa módulos de permutação de simplices \(\mathbf F[K/H]\) e o complexo de órbitas com fronteira por deleção de vértices. Lá, estabilizadores de ordem ímpar tornam os módulos projetivos sobre \(\mathbf F_2\). No nosso problema os estabilizadores são \(2\)-grupos, então exatamente essa projetividade falha.

2. **An Infinite Finitely Presented Simple Amenable Group**  
   A seção de homologia monta um bicomplexo a partir de um complexo simplicial e uma resolução livre; a outra filtragem produz termos de homologia de estabilizadores. Isso é conceitualmente próximo da obstrução de órbitas curtas do nosso problema.

3. Arquivos Smith–Toda no mesmo repositório usam explicitamente resolução 2-periódica de grupos cíclicos, periodicidade e Bockstein.

Use esses arquivos apenas como inspiração técnica. Não aceite resultados não formalizados deles como autoridade.

---

# Missão do auditor

Prioridade:

## CRÍTICO 1
Verifique literalmente o Teorema 1.1 de Himstedt–Symonds e diga se (C1) é TRUE ou FALSE.

## CRÍTICO 2
Reconstrua B2 e D1 sem confiar neste texto.

## CRÍTICO 3
Derive E1 e E2 por Burnside independentemente.

## CRÍTICO 4
Cheque se F1–F3 fecham a indução sem circularidade.

## CRÍTICO 5
Procure contraexemplo por força bruta para

\[
b_{2i}(2h)=z_i(h)
\]

em \(h=2,4,8,16\), sempre que possível.

---

# Formato obrigatório do veredito

Responda primeiro:

```
GENERAL ODD-HOMOLOGY THEOREM:
PASS / PASS WITH CAVEATS / FAIL

A1-A2: PASS / FAIL
B1-B2: PASS / FAIL
C1 HIMSTEDT-SYMONDS: PASS / FAIL
D1 PERIODICITY/SYZYGY: PASS / FAIL
E1 BURNSIDE: PASS / FAIL
E2 RECURSION: PASS / FAIL
F1-F3 INDUCTION: PASS / FAIL
SMALL-N CHECKS: PASS / FAIL
```

Depois liste:

1. **Primeiro erro fatal**, se existir.
2. **Primeiro gap não fatal**, se existir.
3. **Fórmula corrigida**, se algum índice/shift estiver errado.
4. **Menor contraexemplo**, se existir.

Não reescreva a prova elegantemente antes de concluir a auditoria.

Se tudo passar, somente então produza uma versão formal, autocontida e publicável.

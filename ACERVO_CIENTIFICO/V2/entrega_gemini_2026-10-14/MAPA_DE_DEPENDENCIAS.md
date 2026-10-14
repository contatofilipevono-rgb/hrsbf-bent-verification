# MAPA DE DEPENDÊNCIAS LÓGICAS — PROJETO V2
**Data:** 14 de outubro de 2026  

Este documento mapeia a arquitetura dedutiva completa do projeto V2 e dos novos teoremas demonstrados nesta auditoria, especificando com precisão **quais resultados permanecem de pé e quais caem** caso cada lema ou certificado isolado falhe ou seja modificado (por exemplo, ao trocar a semente $f$ em $n=8$ por outra semente em dimensão $2m$).

## 1. Grafo Hierárquico de Dependências (Níveis L0 a L4)

- **Nível L0 — Definições Algébricas Universais sobre $\mathbb{F}_2$ (Independentes da Semente $f$):**
  - **L0.1:** Expansão de Taylor de polinômios de grau $4$ sobre $\mathbb{F}_2$: $[f(x+a)+f(x)]_3 = i_a(D^4 f) = i_a\phi$.
  - **L0.2:** Identidade de 1-cociclo cúbico $\delta_3(AB) = B^*\delta_3(A) + \delta_3(B)$ para todo $A,B \in \operatorname{Aut}(\phi)$.
  - **L0.3:** Ortogonalidade dos subespaços tensoriais de arcos opostos $\mathbb{F}_2 e_i \otimes \Lambda^2(V_i^*) \otimes V_j^*$ e $\mathbb{F}_2 e_j \otimes V_i^* \otimes \Lambda^2(V_j^*)$ na terceira derivada mista $D^3(F_G+Q)$ para $i \neq j$.

- **Nível L1 — Invariantes Estruturais da Forma Quártica $\phi = D^4 f$ (Dependem Apenas de $[f]_4$):**
  - **L1.1 (Propriedade Grassmann-Free):** $\ker C_\phi \subset \Lambda^2(V_0)$ não contém bivetores simples não nulos $u \wedge v$ (posto $22/28$, espectro $\{4:3, 8:60\}$ em $n=8$).
  - **L1.2 (Injetividade da Translação Cúbica):** $\iota_\phi : a \mapsto i_a\phi$ é injetora ($\dim\operatorname{Im}(\iota_\phi) = 8$) — **consequência algébrica direta de L1.1** (se $i_a\phi = 0$ para $a \neq 0$, então $i_{a\wedge b}\phi = 0$, violando L1.1).
  - **L1.3 (Grupo $\operatorname{Aut}(\phi)$):** Em $n=8$, $|\operatorname{Aut}(\phi)| = 1920$ e $\operatorname{Aut}(\phi) = \mathcal{K}_Y^0 \rtimes (\langle C_3\rangle \times \langle P_5\rangle \rtimes \langle\sigma\rangle) \cong \mathbb{F}_2^4 \rtimes (C_{15} \rtimes C_8)$.

- **Nível L2 — Invariantes da Semente Completa $f = [f]_2 + [f]_4$ (Dependem de $\operatorname{Orb}_8(01)$ e de $[f]_4$):**
  - **L2.1 (Bentness):** $\operatorname{wt}(f) = 120$ e $|W_f(\omega)| = 16$ para todo $\omega \in \mathbb{F}_2^8$.
  - **L2.2 (Subgrupo de Simetrias Afins Módulo Grau $\le 2$):** $\mathcal{G}_{\le 2}(f) = \langle P_5, \sigma \rangle \cong C_5 \rtimes C_8$ (ordem $40$), toda translação admissível é nula ($a = 0$), e todo $A \in \mathcal{G}_{\le 2}(f)$ satisfaz a simetria exata $f(Ax) = f(x)$ — **reduzido por L0.2 + L1.3 a apenas duas testemunhas ($C_3$ e $U_0 \in \mathcal{K}_Y^0$) via Lema de Schur (Teorema C3)**.
  - **L2.3 (Trivialidade dos Estabilizadores de Acoplamento):** $\operatorname{Stab}_{\mathcal{G}_{\le 2}(f)}(e_0^*) = \{I_8\}$ e $\operatorname{Stab}_{\mathcal{G}_{\le 2}(f)}(e_0^* \wedge e_1^*) = \{I_8\}$ — **decorre de L2.2 pelo Teorema Órbita-Estabilizador** ($|\operatorname{Orb}(e_0^*)| = |\operatorname{Orb}(e_0^*\wedge e_1^*)| = 40$).

- **Nível L3 — Teoremas Estruturais Globais em $r$ Blocos:**
  - **L3.1 (Recuperação de Blocos via $\operatorname{Rad}_\Phi(u)$ e $R_2(F_G+Q) = r$ — Teorema 1):** Depende **exclusivamente de L1.1** (Grassmann-free)! **NÃO depende** de L1.3, L2.1, L2.2 nem L2.3.
  - **L3.2 (Fórmula Fechada de Flats Maximais $|\mathcal{M}_2(F_G+Q)|$ — Teorema 1.3):** Depende **apenas de L1.1** (e da forma do acoplamento $x_{i,0}x_{i,1}x_{j,0}$). **NÃO depende** de L1.3, L2.2 nem L2.3!
  - **L3.3 (Decomposição Primária de Krull–Schmidt EA via $K(G,Q)$ e Contagem $|\mathcal{Q}_r^{\mathrm{indec}}(G)|$ — Teorema C2):** Depende **exclusivamente de L3.1 (isto é, apenas de L1.1 Grassmann-free!)** e de L0.3! **NÃO depende** da ordem $1920$, nem da ordem $40$, nem dos estabilizadores L2.3!
  - **L3.4 (Classificação EA Global com ou sem Vértices Isolados — Teorema C1):** Depende de **L3.1 + L2.2 + L2.3** (e para a presença de vértices isolados $k \ge 1$, usa crucialmente o fato de que todo $A_i \in \mathcal{G}_{\le 2}(f)$ satisfaz a igualdade exata $f(A_i x_i) = f(x_i)$ sem resíduo quadrático).

- **Nível L4 — Teoremas Enumerativos Globais (Burnside / Pólya / Assintótica):**
  - **L4.1 (Fórmulas de Burnside $N_{\mathrm{EA}}(G)$, $\mathcal{N}_r$ e Estratificação $\mathcal{N}_{r,k}$ por Monodromia — Teorema 3.2 e Tarefa B):** Dependem de **L3.4** (para que as classes de equivalência EA coincidam com as órbitas de $\mathcal{E}(G)$ em $\mathcal{Q}_r$) e da estrutura de Jordan–ciclotomia de $C_5 \rtimes C_8$ em $V_0 = \mathbb{F}_2^8$.
  - **L4.2 (Identidades Combinatórias Puras $C_r(\pi)$, $I_r(\pi)$ e $c_2(\pi)$):** São identidades matemáticas incondicionais sobre ações de grupos finitos; mesmo que L3.4 falhasse para outra semente, elas continuariam contando exatamente as órbitas de $S_r$ (ou $\mathcal{E}(G)$) sobre pares $(G, [Q]_2)$.

## 2. Matriz de Análise de Falha Hipotética (Teste de Estresse Dedutivo)

| Cenário de Falha Hipotética | Resultados que CAEM | Resultados que SOBREVIVEM Intactos |
| :--- | :--- | :--- |
| **Cenário 1: Falha apenas nos estabilizadores L2.3** (ex.: se numa nova semente $\operatorname{Stab}_{\mathcal{G}_{\le 2}(f)}(e_0^*) = H_0 \neq \{I_8\}$ ou $\operatorname{Stab}(e_0^*\wedge e_1^*) = H_{01} \neq \{I_8\}$) | Cai a identidade $A_i = I_8$ nos vértices ativos (L3.4 com $k=0$), logo caem as contagens $N_{\mathrm{EA}}(G)$ com grupo puro $\operatorname{Aut}(G)$. | **Sobrevivem intactos:** Recuperação de blocos $\operatorname{Rad}_\Phi(u)$, $R_2(F_G+Q)=r$, $|\mathcal{M}_2(F_G+Q)|$ (Teorema 1), **toda a Decomposição Primária $K(G,Q)$ (Teorema C2)**, e $a_0=0$! Além disso, o Teorema C1 adapta-se substituindo $I_8$ por $H_{01}$ nas origens, $H_0$ nos destinos e $H_{01}\cap H_0$ em vértices mistos. |
| **Cenário 2: Falha na ausência de translações em L2.2** (ex.: existe $a_i \neq 0$ com $\deg(f(A_i x_i + a_i)+f(x_i))\le 2$) | Cai $a_0 = 0$ (L3.4.(ii)), e translações $a_i \neq 0$ nos vértices ativos induzem termos quadráticos cruzados $D_{a_i}(x_{i,0}x_{i,1})x_{j,0}$ a partir dos acoplamentos cúbicos, alterando a ação afim sobre $[Q]_2$. | **Sobrevivem intactos:** Recuperação de blocos $\operatorname{Rad}_\Phi(u)$, $R_2(F_G+Q)=r$, $|\mathcal{M}_2(F_G+Q)|$ (Teorema 1) e **toda a Decomposição Primária $K(G,Q)$ (Teorema C2)** (pois translações internas aos blocos só criam termos quadráticos ao longo de arcos $(i,j)\in E(G)$ que já pertencem a $K(G,Q)$!). |
| **Cenário 3: Falha na propriedade Grassmann-free L1.1** (ex.: $\ker C_\phi$ possui bivetores simples $u \wedge v \neq 0$ de posto 2) | **Colapso estrutural completo de L3.1–L4.1:** $R_2(F_G+Q)$ torna-se $> r$, a quarta derivada $\Phi$ deixa de impedir rotações contínuas entre blocos distintos $V_i \leftrightarrow V_j$, e caem tanto a ultra-rigidez (Teorema C1) quanto o critério $K(G,Q)$ (Teorema C2). | Sobrevivem apenas a bentness escalar de $f$ (L2.1) e as identidades combinatórias abstratas de Burnside/Möbius (L4.2) desvinculadas da equivalência EA. |
| **Cenário 4: Presença de vértices isolados $I(G) \neq \emptyset$ na família V2 atual** | Cai a versão antiga do Teorema de Ultra-Rigidez (que afirmava $A = P_\pi \otimes I_8$) e cai a fórmula de Burnside sem monodromia para $G$ com isolados. | **Sobrevivem e são governados exatamente pelo Teorema C1 e Teorema C2:** $a_0=0$ persiste, o grupo de gauge passa a ser $\operatorname{Aut}(G_{\mathrm{act}}) \times ((C_5\rtimes C_8)\wr S_k)$, e a contagem exata é dada pela fórmula fechada de monodromia (Teorema 3.2). |

## 3. Descoberta Arquitetural Crucial Deste Mapa

Um achado inesperado desta análise de dependências é que **o Teorema de Decomposição Primária de Krull–Schmidt via $K(G,Q)$ (Teorema C2) e o Teorema do Índice Relaxado $R_2(F_G+Q)=r$ + $|\mathcal{M}_2(F_G+Q)|$ (Teorema 1) são logicamente independentes do certificado de ordem 1920/40 (`certificar_ultrarrigidez_local.py`)**: eles dependem **exclusivamente** do fato de $\phi = D^4 f$ ser Grassmann-free (ausência de bivetores de posto 2 em $\ker C_\phi$, verificável em menos de $0,01\text{ s}$ sobre as $28$ linhas de $C_\phi$)! Portanto, **qualquer** uma das $64$ formas quárticas RS Grassmann-free bent-completáveis em $n=8$ (ou as sementes em $n=10, 12$ de `verificar_contracoes.py`) satisfaz imediatamente o Teorema 1 e o Teorema C2 na íntegra, mesmo antes de se calcular seu grupo $\operatorname{Aut}(\phi)$.

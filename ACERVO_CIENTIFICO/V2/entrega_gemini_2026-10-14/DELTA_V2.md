# DELTA_V2 — Alterações Propostas para o Manuscrito V2 (Sem Sobrescrever o Original)
**Data:** 14 de outubro de 2026  
**Regra de Preservação:** O pacote V2 recebido foi integralmente preservado sem alterações em `PACOTE_V2_ORIGINAL_PRESERVADO/`. Este documento especifica exatamente os blocos textuais e matemáticos que devem substituir ou expandir as seções correspondentes do manuscrito V2 e do adendo de 13/10/2026.

## Delta 1 — Substituição da Citação Opaca de Centroides pela Prova Elementar de 6 Linhas via Radical Grassmann-Free e Invariante $|\mathcal{M}_2(F_G+Q)|$

### Trecho Antigo (`ADENDO_ULTRARRIGIDEZ_CERTIFICADA_2026-10-13.md`, Seção 2.(i))
> **(i) Recuperação de blocos.** A quarta derivada das funções é o tensor $\bigoplus_i \phi_i$ com saídas independentes $e_i$. O centroid de $\phi$ é unidimensional e a propriedade Grassmann-free do núcleo da contração implica a rigidez dos idempotentes: os idempotentes mínimos não nulos do centroid global são as projeções sobre $V_i$.

### Trecho Novo Proposto
> **(i) Recuperação elementar e autocontida de blocos e exatidão de $R_2(F_G+Q)=r$.** Seja $\Phi = D^4(F_G+Q) = \sum_{i=1}^r e_i \otimes \phi_i$. Para cada $u = (u_1,\dots,u_r) \in V$, defina o radical intrínseco de contração $\operatorname{Rad}_\Phi(u) := \{v \in V : i_{u\wedge v}\Phi = 0\}$. Pela independência linear de $e_1,\dots,e_r \in W$ e pela propriedade Grassmann-free de $\phi_i$ ($\ker C_{\phi_i}$ não possui bivetores simples de posto 2), temos $i_{u\wedge v}\Phi = 0 \iff \forall i \in [r],\; u_i \wedge v_i = 0 \iff v \in \bigoplus_{i : u_i \neq 0} \mathbb{F}_2 u_i$. Logo $\dim_{\mathbb{F}_2}\operatorname{Rad}_\Phi(u) = |\{i \in [r] : u_i \neq 0\}|$. Isso caracteriza intrinsecamente $\bigcup_{i=1}^r V_i = \{u \in V : \dim\operatorname{Rad}_\Phi(u) \le 1\}$ e recupera os blocos $V_1,\dots,V_r$ como os subespaços maximais contidos nesse conjunto, forçando $A(V_i) = V_{\pi(i)}$ e $B = P_\pi^{-1}$ para uma única permutação $\pi \in S_r$. Além disso, todo subespaço $U \le V$ no qual $D_a D_b(F_G+Q)$ é constante satisfaz $i_{a\wedge b}\Phi = 0$ ($\forall a,b \in U$), logo $\dim\pi_i(U) \le 1$ e $\dim U \le r$, com igualdade $R_2(F_G+Q) = r$ atingida exatamente nos subespaços $U = \bigoplus_{i=1}^r \mathbb{F}_2 v_i$ ($v_i \in V_i \setminus \{0\}$) tais que $(v_{i,0},v_{i,1})=(0,0)$ ou $v_{j,0}=0$ para todo arco $(i,j) \in E(G)$, em número exato $|\mathcal{M}_2(F_G+Q)| = \sum_{A \subseteq [r]} 63^{r-|A|} 64^{|\{j\in A : N_G^-(j)\cap A \neq \emptyset\}|} 192^{|\{j\in A : N_G^-(j)\cap A = \emptyset\}|}$.

## Delta 2 — Inclusão da Estrutura Semilinear $\Gamma\mathrm{L}(1,16)$ e Redução por 1-Cociclo e Lema de Schur (Teorema C3)

### Trecho Antigo (`ADENDO_ULTRARRIGIDEZ_CERTIFICADA_2026-10-13.md`, Seção 1)
> Em coordenadas $V = U \oplus E$, enumeram-se $\operatorname{GL}(4,2)$ e matrizes em bloco `[[P,Y],[0,Q]]`... No segundo estágio, calcula-se a ANF por transformada de Möbius para os 1.920 automorfismos e as 256 translações, decidindo exatamente quando o grau da diferença é $\le 2$.

### Trecho Novo Proposto
> **Estrutura Conceitual de $\operatorname{Aut}(\phi)$ e Redução de Duas Testemunhas via Lema de Schur.** Em $V_0 = U \oplus E$ ($U = \operatorname{Fix}(\sigma^4)$), os bidegraus $(4,0)$ e $(3,1)$ de $\phi$ são identicamente nulos; o núcleo de posto 2 da forma $(2,2)$ define um *spread* simplético $\mathbb{F}_4^2$ cujo estabilizador em $\operatorname{GL}(4,2)$ é $\Gamma\mathrm{L}(2,4)$ (ordem $360$); e o tensor $(1,3)$ força $P = Q \in \Gamma\mathrm{L}(1,16) \cong C_{15} \rtimes C_4$ (ordem $60$). O núcleo de cisalhamentos $\mathcal{K}_Y \cong \mathbb{F}_2^5$ (ordem $32$) decompõe-se sob $P_5$ em $Z(\operatorname{Aut}(\phi)) = \langle\sigma^4\rangle \cong C_2$ e no $\mathbb{F}_2[P_5]$-módulo simples normal $\mathcal{K}_Y^0 = [\mathcal{K}_Y, P_5] \cong \mathbb{F}_2^4$ (ordem $16$), fornecendo o produto semidireto global $\operatorname{Aut}(\phi) = \mathcal{K}_Y^0 \rtimes (\langle C_3\rangle \times \langle P_5\rangle \rtimes \langle\sigma\rangle) \cong \mathbb{F}_2^4 \rtimes (C_{15} \rtimes C_8)$ de ordem $1920$. A igualdade $\mathcal{G}_{\le 2}(f) = \langle P_5,\sigma\rangle \cong C_5 \rtimes C_8$ (ordem $40$) e $a=0$ decorre sem busca exaustiva sobre $1920 \times 256$ pares do 1-cociclo $\delta_3(A) = [f(Ax)+f(x)]_3$: como $\iota_\phi(a) = i_a\phi$ é injetora com imagem na componente $\Phi_5$-isotípica de $\Lambda^3(V_0^*)$, bastam duas testemunhas: $\delta_3(C_3) \neq 0$ (no subespaço $P_5$-invariante) e $\delta_3(U_0) \notin \operatorname{Im}(\iota_\phi)$ para um único $U_0 \in \mathcal{K}_Y^0 \setminus \{I_8\}$ (pelo Lema de Schur sobre $\mathcal{K}_Y^0$).

## Delta 3 — Extensão Completa da Classificação EA para Dígrafos com Vértices Isolados (Teorema C1)

### Trecho Antigo (`ADENDO_ULTRARRIGIDEZ_CERTIFICADA_2026-10-13.md`, Seção 2)
> Sejam $G, H$ dígrafos **sem laços e sem vértices isolados**, com $r \ge 2$, sobre os blocos $(\mathbb{F}_2^8)^r$... toda equivalência EA satisfaz 1. $B = P_\pi^{-1}$... 2. $A = P_\pi \otimes I_8$; 3. $a_0 = 0$; 4. $[Q']_2 = P_\pi^{-1}[Q]_2(P_\pi \otimes I_8)$.

### Trecho Novo Proposto
> **Teorema Geral de Classificação EA (Com ou Sem Vértices Isolados).** Sejam $G, H$ dígrafos sem laços arbitrários sobre $[r]$ ($r \ge 1$), com conjuntos de vértices isolados $I(G), I(H)$ ($k = |I(G)| \ge 0$) e vértices ativos $V_{\mathrm{act}}(G) = [r] \setminus I(G)$. Toda equivalência EA $(F_H+Q')(x) = B(F_G+Q)(Ax+a_0)+L(x)+c_0$ satisfaz necessária e suficientemente: (1) $B = P_\pi^{-1}$ para um isomorfismo de dígrafos $\pi : H \to G$ (onde $P_\pi e_i = e_{\pi(i)}$); (2) $a_0 = 0$ globalmente (mesmo nos vértices isolados); (3) $A = (P_\pi \otimes I_8)\operatorname{diag}(A_1,\dots,A_r)$ com $A_i = I_8$ para $i \in V_{\mathrm{act}}(H)$ e $A_i \in \mathcal{G}_{\le 2}(f) \cong C_5 \rtimes C_8$ arbitrário para $i \in I(H)$; e (4) $[Q']_2(x) = P_\pi^{-1}[Q]_2(Ax)$. O grupo de gauge EA de $G$ é o produto corona $\mathcal{E}(G) \cong \operatorname{Aut}(G_{\mathrm{act}}) \times ((C_5 \rtimes C_8) \wr S_k)$ de ordem $|\operatorname{Aut}(G_{\mathrm{act}})|\,k!\,40^k$, e o número de classes EA $N_{\mathrm{EA}}(G)$ é dado em forma fechada pela redução de monodromia (Teorema 3.2 de `NOVO_TEOREMA_V2.tex`).

## Delta 4 — Elevação do Critério $K(G,Q)$ a Teorema de Decomposição Primária de Krull–Schmidt e Contagem de Möbius (Teorema C2)

### Trecho Antigo (`ADENDO_ULTRARRIGIDEZ_CERTIFICADA_2026-10-13.md`, Seção 3)
> Então $F_G+Q$ é EA-indecomponível **se e somente se** $K(G,Q)$ é conexo.

### Trecho Novo Proposto
> **Decomposição Primária de Krull–Schmidt EA e Enumeração Indecomponível.** As componentes conexas $C_1,\dots,C_m$ de $K(G,Q)$ fornecem em tempo $O(r^3)$ a decomposição canônica $F_G + [Q]_2 = \bigoplus_{a=1}^m (F_{G[C_a]} + [Q]_{2,C_a})$ em fatores EA-indecomponíveis, única a menos de equivalência EA e permutação dos fatores, enquanto a condensação de $\vec{K}(G,Q)$ em componentes fortemente conexas fornece a decomposição triangular maximal. Quando $G$ possui componentes fracamente conexas de tamanhos $r_1,\dots,r_m$, o número exato de perturbações quadráticas homogêneas que tornam $F_G+Q$ EA-indecomponível é $\sum_{\pi=\{B_1,\dots,B_q\}\in\Pi_m} (-1)^{q-1}(q-1)! \prod_{u=1}^q 2^{s_u\binom{8s_u}{2}}$ ($s_u = \sum_{a\in B_u} r_a$).

## Delta 5 — Correção de Escopo Assintótico, Distinção $\mathcal{C}_r \subsetneq \mathcal{I}_r$ e Atribuição OEIS A003085

### Trecho Antigo (Relatórios prévios de Burnside e contagem de dígrafos)
> Referências sem ressalva explícita à novidade de $880471142$ ($r=7$) ou sem separação entre o erro de desconexão e o erro de automorfismos em $\mathcal{N}_r \sim 4^{\binom{r}{2}} 2^D / r!$.

### Trecho Novo Proposto
> **Atribuição OEIS e Escalas Assintóticas.** A sequência $d_2,\dots,d_7 = (3, 54, 3834, 1027080, 1067308488, 4390480193904)$ e o número de classes não rotuladas em $r=7$ ($880.471.142$) são clássicos (Harary & Palmer, 1973; OEIS [A003027](https://oeis.org/A003027) e [A003085](https://oeis.org/A003085)); a novidade de V2 reside exclusivamente na interpretação algébrica via classes EA da família quártica. Para $r \ge 4$, o domínio $\mathcal{I}_r$ do teorema de rigidez sem isolados contém estritamente $\mathcal{C}_r$ ($I_r(\pi)$ dado pela inclusão-exclusão fechada em ciclos). Na assintótica de $\mathcal{N}_r$, a codimensão exata de transposições é $D - c_2(\tau) = 96r^2 - 204r + 144$, de modo que o erro relativo de automorfismos ($\sim \binom{r}{2} 2^{-96r^2+202r-141}$) é super-exponencialmente menor que o erro relativo de desconexão $1 - d_r/4^{\binom{r}{2}} \sim r 4^{-(r-1)}$.

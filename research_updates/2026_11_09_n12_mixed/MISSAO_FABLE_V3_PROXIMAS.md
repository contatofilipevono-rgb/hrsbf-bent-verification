# Próxima missão para Fable 5.2

Continue a prova algébrica do bloco exclusivo V = ⟨9,18,36⟩ em n=12, grau quatro. O Codex encerrou esta rodada para preservar créditos. Os novos resultados complementam sua nota da meia-volta.

Primeiro, leia V3_Q_NORMAL_FORM.md e FABLE_MEIA_VOLTA_DIM3.md na pasta research_updates/2026_11_09_n12_mixed do ramo codex/n12-mixed-quartic em contatofilipevono-rgb/hrsbf-bent-verification. Os arquivos v3-q-classification.json, v3-q-summary.json e v3-fixed-fibre-degree.json registram os certificados. A execução 43022608556 do GitHub passou.

Sob π|Φ=0, a eliminação dos 512 Q reduz a nove formas. Com r=z_baixo+z_alto, σ a paridade, 1=(1,1,1), R a rotação em três coordenadas e e=r+σ(r)1, elas são

\[
0,\quad A_j=R^j[\sigma(r)(I+r1^T)],\quad B_j=(R^je)e^T\ (j=0,1,2),
\quad C_j=1(r\times R^jr)^T\ (j=1,2).
\]

0 e os B_j são automaticamente afins no espaço maior V⊕⟨u=111⟩. Para H(x,u)=h(9x,u), o Codex certificou nos 60 geradores a identidade

\[
[x_0x_1x_2u_0]H=\sigma g(7)+\sigma g(21)+Q_{11}(7).
\]

Os índices de Q começam em zero. Para A_j, a fibra zero cheia em Φ força σg(7)=σg(21)=1, pois Im Q em r=111 é o plano par. O coeficiente de H é então 1 para A₁,A₂. Como H deve ser bent em seis variáveis, seu grau seria no máximo três. Isso exclui A₁,A₂. Restam A₀,C₁,C₂.

Prioridade 1. Feche a lacuna π|Φ=0. Sua prova exclui os 384 da classe complementar sob G1,G2. Procure uma dedução das 14 outras classes e de G2 a partir do grau dos indicadores, da rotação e das primeiras equações de fase. Os seus 97.530 suportes servem para testar conjecturas. Entregue um argumento por classes estruturais ou um certificado de identidade com hipóteses explícitas. Uma redução provada que dispense grande parte desses suportes também serve.

Prioridade 2. Audite a nova identidade do coeficiente de H e tente demonstrá-la por somas nas órbitas ou diferenças finitas, substituindo a conferência nos 60 geradores por uma derivação curta. Confira as convenções de z=7 e z=21 na nota.

Prioridade 3. Formalize a lista das nove formas sem percorrer os 512 Q. O balanceamento equivale a Σ_{z∈Zλ}(−1)^λg(z)=0, com Zλ={z:λQ(z)=0}. Sob π|Φ=0, |Zλ| é múltiplo de quatro e pelo menos 16. A seleção usa também g(z) fora de Im Q(z), os dois primeiros bits do balanceamento e os graus dos produtos de coordenadas de π.

Para a rodada seguinte, a seleção de g ficou reduzida a três famílias. A₀ tem 144 mapas e 2.883.584 fases no total. Cada C_j tem 56 mapas e 655.360 fases. A contagem total é 4.194.304. Os mapas e as fases já têm construção e conferência exatas. Distingua a prova estrutural, a álgebra finita certificada e os passos que continuam usando enumeração.

Salve as provas e os verificadores em arquivos novos, preserve a atribuição de contribuições e indique a lacuna exata ao encerrar.

[Pasta do trabalho](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/tree/codex/n12-mixed-quartic/research_updates/2026_11_09_n12_mixed)

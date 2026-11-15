# Padrões nos certificados de n = 12, grau ≤ 4: simetria, colunas e estrutura dos conjuntos bent

Data: 15/11/2026. Base: os certificados de `NOTA_CERTIFICADOS_ARVORE.md`.

As contas rodaram no Google Cloud e no GitHub Actions. Os scripts são:
- `analise_certificados.py`;
- `analise_estrutura_bent.py`;
- `simetria_circulante.py`;
- `simetria_todos.py`.

Os resultados estão em `estr_out/`, nos arquivos `resumo_estrutura.json`, `simetria.json` e `orbitas_18816.json`.

## 1. Uma simetria que reduz a prova a cerca de um sexto dos casos
Toda matriz circulante invertível sobre F₂ comuta com a rotação, o que preserva:
- a simetria de rotação (RS);
- o grau, porque a matriz é linear;
- a bentness, porque a matriz é invertível.

Essas matrizes são as unidades do anel F₂[X]/(X¹² − 1), que são 1.536. O mesmo vale para as trocas de coordenadas i ↦ k·i, com k = 5, 7, 11. O grupo Γ gerado por elas age nos polares.

**Conferido nos 18.816 polares:**
- a imagem de um polar não depende da função escolhida dentro dele (0 casos dependentes);
- a imagem sempre cai na lista dos 18.816;
- os 10 geradores circulantes usados geram as 1.536 unidades.

**Órbitas:**

| | Polares | Órbitas | Tamanhos |
|---|---:|---:|---|
| espaço inteiro de (Pf4) | 18.816 | **3.344** | 56 de tamanho 1, 308 de 2, 1.424 de 4, 1.556 de 8 |
| polares bent | 72 | **25** | 1, 2, 4, 8 |

Consequência: a classificação só precisa de certificados para os 3.344 representantes, e as contagens para 25 deles. Isso dá uma prova cerca de 5,6 vezes menor e mais fácil de auditar.

## 2. As obstruções moram nas "colunas"
Nos 140 certificados de árvore:
- **família S** (autocorrelação nas direções de w, ou seja, Parseval nas 64 colunas): 1,58 milhão de usos;
- **família W:** 176 mil usos, quase todos com u = 0, isto é, W(0,b) = Σ_z r_b(z);
- **família F:** 87 mil usos; das 87.345 referências, 87.328 têm ω = 0, ou seja, são somas K_z sem caractere.

Na raiz, 89 dos 140 polares morrem: 52 só com S, 36 com S e F, e 1 só com F.

Isso sugere que as obstruções vivem nas funções parciais r_b(z) = Σ_w (−1)^{f(z,w)+b·w} e nas suas somas em z, e quase nunca no Walsh completo. Uma "teoria das colunas" poderia substituir boa parte das árvores.

## 3. Estrutura dos conjuntos bent
Para cada polar bent, seja S ⊆ U o conjunto das fases bent. Medimos três coisas:
- a dimensão da envoltória afim de S;
- o estabilizador L = {v : S + v = S};
- o número de classes |S/L|.

| Bent | dim U | Envoltória | dim L | Classes \|S/L\| | Polares | Órbitas de Γ |
|---:|---:|---:|---:|---:|---:|---:|
| 1.536 | 33 | 17 | 4 | 96 = 3·2⁵ | 4 | 1 |
| 4.096 | 36 | 15 | 8 | 16 | 2 | 1 |
| 6.144 | 28 | 18 | 2 | 1.536 = 3·2⁹ | 16 | 2 |
| 6.144 | 30 | 18 | 2 | 1.536 | 16 | 2 |
| 8.192 | 33 | 21 | 4 | 512 | 7 | 4 |
| 8.192 | 33 | 21 | 5 | 256 | 1 | 1 |
| 16.384 | 36 | 23 | 6 | 256 | 2 | 1 |
| 90.112 | 35 | 24 | 5 | 2.816 = 11·2⁸ | 4 | 1 |
| 196.608 | 39 | 20 | 14 | 12 = 3·4 | 1 | 1 |
| 196.608 | 38 | 21 | 11 | 96 | 2 | 1 |
| 262.144 | 39 | 21 | 6 | 4.096 | 1 | 1 |
| 262.144 | 38 | 23 | 8 | 1.024 | 2 | 1 |
| 393.216 | 38 | 23 | 9 | 768 = 3·2⁸ | 2 | 1 |
| 393.216 | 39 | 24 | 8 | 1.536 | 2 | 1 |
| 524.288 | 38 | 23 | 8 | 2.048 | 2 | 1 |
| 589.824 | 39 | 24 | 9 | 1.152 = 9·2⁷ | 2 | 1 |
| 655.360 | 36 | 27 | 9 | 1.280 = 5·2⁸ | 2 | 1 |
| 786.432 | 36 | 27 | 5 | 24.576 = 3·2¹³ | 2 | 1 |
| 10.485.760 | 41 | 29 | 10 | 10.240 = 5·2¹¹ | 1 | 1 |
| polar nulo: 290.062.336 | 43 | — | — | — | 1 | 1 |

O que a tabela mostra:
- **Invariantes e órbitas:** polares com os mesmos invariantes formam quase sempre uma única órbita de Γ. As exceções são as duas famílias de 6.144 (2 órbitas de 8 cada) e a de 8.192 com dim L = 4 (4 órbitas). Pode haver uma simetria além de Γ, ou pode ser coincidência dos invariantes. Fica em aberto.
- **Partes ímpares:** as partes ímpares das contagens (3, 5, 9, 11) vêm todas do quociente S/L. Os estabilizadores são pequenos, então os conjuntos bent não são uniões de poucos subespaços grandes. A regra de cada família está no conjunto quociente.
- **Polar de 10.485.760:** com a transformada de 2²⁹ rodada na nuvem, o estabilizador tem dimensão 10 e há 10.240 = 5·2¹¹ classes. A parte ímpar 5 também vem do quociente. A nota `EXTERIOR_QUARTICO_N12.md` descreve o mesmo conjunto como 1.280 mapas com fibras planas × 2¹³ fases.

### Os pontos em aberto, fechados (`teste_dual.py`, `juntar_dual.py`)
- **Γ já contém todas as simetrias afins de RS.** Uma transformação afim x ↦ Mx + c preserva RS quando M conjuga a rotação numa potência dela. As matrizes M assim são exatamente as circulantes invertíveis compostas com i ↦ k·i, e c tem de ser 0 ou (1,…,1).
- **Translação:** a translação por (1,…,1) nunca muda o polar (testado em 4 funções bent de cada um dos 71 polares).
- **Dualidade:** testada nas mesmas funções.
  - O dual de uma bent RS é bent RS, mas tem grau 5 em 234 dos 284 casos, ou seja, sai da classe de grau ≤ 4.
  - Mesmo quando o dual fica quadrático em w e cai num polar bent, cai na **mesma órbita** de Γ: o grafo de Γ, dualidade e translação continua com 25 componentes, e nenhum deles mistura famílias.
- **Conclusão:** as famílias de 6.144 (2 órbitas cada) e de 8.192 com dim L = 4 (4 órbitas) reúnem classes realmente distintas sob as simetrias afins de RS e a dualidade. A igualdade dos invariantes é numérica. O perfil de postos de B_z também não as separa: (0:1, 2:7, 4:56) nas de 6.144 e (0:4, 2:60) nas de 8.192. Se houver uma correspondência entre elas, ela não é afim nem é a dualidade.

## 4. Próximos passos sugeridos
1. **Reescrever a prova por órbitas:** um certificado por representante (3.344) e uma prova à mão de que Γ preserva o modelo e o conjunto dos 18.816.
2. **Teoria das colunas:** provar lemas gerais sobre r_b(z) que expliquem as raízes `const`/`lin` das famílias S e F com ω = 0.
3. **Quocientes:** descrever o quociente S/L de cada uma das 25 órbitas bent. Os casos de 12, 16 e 96 classes são pequenos o bastante para fazer à mão.
4. **Famílias que se partem:** fechado acima. Elas não vêm de simetria afim nem da dualidade. Se valer a pena, dá para procurar uma correspondência não afim, como um "switching" entre os conjuntos bent.

# Classe 129 de V1: entrada em A_2 por células de ρ

Data: 13/11/2026. Continuação de `NOTA_ENTRADA_A2.md`, com a mesma notação (z = (y,w), d = y + w, linha R_d, swap, M = linhas 1, 2, 4).

## Resultado

**Teorema.** Seja um mapa admissível da classe com estas três propriedades:
- está no envoltório;
- o momento constante da fibra 5 é nulo;
- os dois momentos do par [2] são nulos.

Então o código está em A_2.

A prova usa o teorema I (momento da fibra 5 nulo ⇒ Λ_7 = 0) e uma checagem finita em 4.096 valores de ρ, mais 5 direções por célula. Ela não percorre os 2^25 mapas nem usa o catálogo.

## Estrutura

Seja T o envoltório ∩ {Λ_7 = 0}, de dimensão 17. Em T, o mapa código ↦ ρ é afim, com imagem de dimensão 12 e núcleo de dimensão 5. Para cada ρ da imagem, a célula C_ρ é afim de dimensão 5. Dentro de uma célula, ρ e todos os Z_[t] são fixos. Por isso cada momento de [2] é uma função afim do código na célula, e a cegueira às fases depende só de Z_[2].

**Passo 1. Condições de suporte que só dependem de ρ.** São consequências de (F1)–(F3):
- |Z_[t]| = 8;
- a·e_t e b·e_t ortogonais a RM(1,6);
- |Z_[t] ∩ M| par.

Das 4.096 imagens, 174 passam. Os tipos de (Λ_1, Λ_2, Λ_4) dessas células correspondem às fatias que você descreveu: cada fatia ativa é um laço (multiplicidade 8) ou uma aresta (4+4).

**Passo 2. Os momentos de [2] por célula.** Em todas as 174 células, os dois momentos são cegos às 19 fases e constantes na célula. A conferência é o ponto base e as 5 direções.

| valores (Q2.s1, Q2.s2) | células |
|---|---:|
| pelo menos um é 1 | 112 |
| (0,0), com Λ_1 = Λ_2 = Λ_4 = 0 | 30 |
| (0,0), com Λ_M ≠ 0 | 32 |

As 112 células estão certificadas por um dos dois momentos, cujo valor é constante na célula: esse é o certificado compacto por tipo. As 30 estão em A_2 pela identidade (D).

**Passo 3. A família que sobra: 32 células, nenhuma admissível.** Nelas, as linhas M carregam pares ímpares, e os pares pares [2], [4], [6] ficam inteiros em N, em duas meias-linhas de 4 pontos das linhas 3, 5, 6. Daí o argumento:

1. Com Z_[t] ⊂ N, |P_t| = 4|g_t|, e a fibra exige |g_t| = 4.
2. Em Z_[t], o swap não muda o rótulo: χ = 0, constante na célula. O swap não tem pontos fixos fora da linha 0. Logo Z_[t] se divide em 4 órbitas de 2 pontos, cada uma com um só rótulo, e |g_t| = 2·(número de órbitas com rótulo t).
3. Num par puro, o indicador [π0 = t] é π0₀ + constante, que é afim no código. A paridade do número de órbitas com rótulo t é, portanto, uma função afim na célula; ela é constante 1. Visto por meia-linha, é a soma de duas derivadas de π0, uma em cada meia-linha, o mesmo formato da obstrução do ramo 2+2.
4. Assim |g_t| ≡ 2 mod 4, e |P_t| = 4|g_t| ∈ {8, 24} ≠ 16. Dentro da célula, a condição de tamanho de fibra falha para todo código.

Juntando os passos: um admissível de T com os dois momentos de [2] nulos está numa das 30 células, portanto em A_2.

**Controle no catálogo.** Os 2.784 suportes do catálogo em T caem só nas 174 células aprovadas, e os de valor (0,0) são exatamente os 480 residuais.

## O que está provado e o que é conferência

| peça | situação |
|---|---|
| envoltório contém os admissíveis | enumeração (`hipoteses_classe129.py`) |
| Λ_7 = 0 a partir do momento da fibra 5 | teorema I; usa (Z5), conferida nos 11.232 admissíveis |
| (D): A_2 ⇔ Λ_7 = 0 e Λ_M = 0 | linear no envoltório |
| condições de ρ (passo 1) | consequência direta de (F1)–(F3) |
| 174 células aprovadas | checagem finita: 4.096 valores de ρ |
| constância e cegueira dos momentos de [2] por célula | linear: ponto base e 5 direções por célula |
| exclusão das 32 células (χ = 0 e paridade de órbitas constante 1) | linear por célula |

A única dependência fora desta checagem é (Z5): Z_[5] não encontra M. Ela entra no teorema I e continua conferida só nos 11.232 admissíveis.

Não usei o lema de postos ≤ 1 do Carbon: a enumeração das imagens de ρ já cobre todos os postos. Ele pode servir para reduzir as 4.096 imagens a uma lista por tipo feita à mão.

## Arquivos

- `verifica_entrada_A2_celulas.py`: passos 1–3. Com `--catalogo`, confere também a localização dos 2.784 suportes.
- `relatorio_celulas.txt`: saída.

```
python -I verifica_entrada_A2_celulas.py <repo>/research_updates/2026_11_09_n12_mixed --catalogo <dir>/mapas_V1.txt
```

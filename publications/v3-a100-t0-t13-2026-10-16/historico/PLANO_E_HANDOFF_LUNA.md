# Missão executada: grau 4 na A100 do Colab

T0–T10 foram executados. Consulte `RESULTADOS_E_PROXIMA_MISSAO.md` para
as conclusões e `results/` para as evidências reais da sessão. O notebook
incluído conserva as seis células executadas e suas saídas. As instruções
de execução abaixo permitem reproduzir os testes; não representam tarefas
ainda pendentes. A próxima missão científica está no relatório de resultados.

O usuário autorizou executar os testes no Colab e informou ter muitos créditos.
O objetivo é obter resultados matemáticos verificáveis, usando GPU em lotes
exatos; os créditos não são uma razão para executar varreduras sem redução.

Notebook criado nesta sessão, separado dos projetos anteriores:
https://colab.research.google.com/drive/17kFfk93CpP_lFc0TKgDOWp3sOhXdey3a

Nome: `GRAU4_A100_TESTES_ESTRUTURAIS_2026_10_16.ipynb`.
A100 selecionada. Não alterar compartilhamento nem publicar resultados.
Não acessar senhas ou tokens: autenticação ocorreu pela interface segura.

## Testes executáveis, em ordem

| Etapa | Pergunta e escopo | Condição de aceitação |
|---|---|---|
| T0 | Estamos usando a referência corrigida? | SHA do ZIP e todos os hashes internos iguais. |
| T1 | CUDA reproduz aritmética inteira correta? | FWHT 64/256/1024/4096 igual à CPU, inversão, Parseval, paridade em 245 coeficientes e controle negativo da fase. |
| T2 | GPU acelera o trabalho real? | Medir aquecimento, sincronização, dados residentes e transferências; sem prometer fator de aceleração antes da medição. |
| T3 | A cascata de referência continua cobrindo o espaço? | Executar algoritmo original com apenas callback de checkpoints; contadores idênticos e zero sobreviventes. |
| T4 | As 94.544 extensões são realmente excluídas por cálculo direto? | Avaliar na GPU as 64 energias e TODO o Walsh de 4096 frequências, sem transporte. Comparar primeiro lote inteiro à CPU int64. |
| T5 | Podemos simplificar a parte final do certificado? | Cobrir as 94.544 classes com poucas frequências de energia; exportar testemunha por classe. Cobertura gulosa, sem alegar mínimo. |
| T6 | Que reduções exatas existem em n=16,20? | Reconstruir geradores e mapas de restrição; guardar mudança de base e pivôs e verificar sua identidade. |
| T7 | Há divisibilidades/obstruções novas nas imagens completas? | Enumerar integralmente as imagens pequenas na A100; histogramas, divisibilidade, Bessel e Poisson com contagens exatas. |

## Por que T4 é mais que outro contador

O código anterior já eliminava as 94.544 funções por energias necessárias.
T4 acrescenta uma rota CUDA direta, incluindo os 4096 coeficientes de Walsh
de cada função completa, além de certificados explícitos de falha. Isso
valida a implementação, mas não constitui por si só um teorema inédito.

T5 cobre apenas as extensões de posto 41 após o prefixo certificado. Não
apagar o prefixo da prova: uma cobertura pequena dessas extensões não prova
sozinha o teorema para as 2^43 funções originais.

## Reduções que orientam a A100

Os seguintes postos foram calculados em CPU durante a preparação, com
operações exatas sobre F2 e conferência de P*A=M:

| n | geradores | g0 | gJ | galt | (g0,gJ) | fibras de período 2 |
|---|---:|---:|---:|---:|---:|---:|
| 12 | 43 | 3 | 5 | 6 | 8 | 12 |
| 16 | 116 | 4 | 8 | 14 | 12 | 21 |
| 20 | 245 | 5 | 13 | 22 | 18 | 32 |

Em n=20, `gJ` tem 8.192 imagens e `galt` tem 4.194.304. Em n=16,
as quatro fibras de período 2 têm 2.097.152 imagens conjuntas.
Cada classe da imagem tem exatamente 2^(dimensão original - posto)
pré-imagens, razão pela qual uma contagem exata de classes eliminadas
por filtros necessários pode ser convertida em número de funções.

## Poisson novo para as restrições locais

Para V=span(J), implementar a identidade geral de Poisson:
L_gamma(b) = W_g0(b) + (-1)^gamma W_gJ(b)
          = 2 * soma dos sinais de Walsh do dual na classe beta·J=gamma.

Frequências completas na mesma órbita cíclica compartilham um sinal.
O código calcula o conjunto admissível por somas inteiras dos tamanhos
dessas interseções. Trata-se de relaxação necessária: não força compatibilidade
de sinais entre testes diferentes. Não repetir que isso caracteriza bentness.

Conferir os controles positivos P_n antes de usar o filtro em n=16,20.
Há testes locais CPU para isso; registrar o resultado no notebook também.

## Como continuar no Colab

Os arquivos enviados à sessão são `experiment.py`, `experiment_science.py`,
`sector_analysis.py` e o ZIP de referência. Em um runtime novo, envie os três
scripts da pasta `code/` e o ZIP da pasta `reference/` para `/content/` antes
de executar o notebook incluído. Os checkpoints originais estão em `results/`.
Não usar o arquivo antigo de preprint como fonte do algoritmo.
Importar `experiment as ex` e manter `gpu = ex.GPU()`.

1. T0–T2: a primeira célula já foi preparada para integridade, validação e benchmark.
2. Executar `ex.capture_baseline(release)` para T3. O algoritmo de referência
   roda em CPU e exporta coeficientes reais das classes dos estágios 5 e 15.
   Isso é a âncora independente; o teste T4 roda na GPU.
3. Executar `ex.audit_n12_gpu(gpu)` e `ex.greedy_certificate()`.
4. Executar `ex.inspect_images(n)` para n=12,16,20.
5. Executar inicialmente:
   - n=12: `gJ`, `joint_ends`, `joint_period2`, para calibrar as leis conhecidas;
   - n=16: `gJ`, `galt`, `joint_ends`, `joint_period2`;
   - n=20: `gJ`, `galt`, `joint_ends`.
6. Não enumerar ingenuamente o mapa conjunto de posto 32 em n=20.
   Usar os resultados para definir uma filtração triangular nova. Muitos
   créditos não tornam justificável esconder a dimensão real do problema.

Para cada imagem enumerada, T7 produz:

- posto e número integral de classes;
- histogramas em b=0, J e alternado;
- gcd espectral 2-ádico e mínimo |A|;
- classes que sobrevivem à energia parcial;
- classes que sobrevivem a Poisson em span(J), quando g0 e gJ são conhecidos;
- interseção dos filtros e número exato de pré-imagens excluídas;
- checkpoints com assinatura da base e do código, recusando retomada incompatível.

## Regras de rigor e execução

- FWHT e paridade em inteiros; energias sempre int64 antes de elevar ao quadrado.
- CPU compara arrays completos, não só hashes ou alguns pontos.
- Manter kernel, logs e parâmetros. Nenhuma divergência CPU/GPU é aceitável.
- Se houver falha, interromper a etapa científica dependente, corrigir e repetir
  T1; conservar os resultados anteriores em outra pasta.
- Sem fraude de execução: um arquivo JSON recebido não é execução nesta sessão.
- Não declarar teorema de não existência em n=16 ou n=20 apenas porque algumas
  imagens ou setores foram eliminados. Só zero classes em uma cobertura completa
  e com filtros necessários demonstrados autoriza essa conclusão.
- Não reintroduzir o erro ±8 versus ±32 módulo 5, o transporte sem fase,
  a cadeia falsa V2⊂V3 ou a afirmação universal g0(1)=0.
- O Lean da referência é auxiliar, não prova integral da cascata.

## Preservação ao terminar

As saídas são escritas em `/content/grau4_a100_results/`, ou em
`ex.ROOT` se o runtime usar outro diretório corrente.
Antes de encerrar, compactar resultados e o código em ZIP, baixar pela UI,
guardar o notebook com as saídas e conservar uma cópia persistente do ZIP.
Não solicitar acesso a todo o Drive para isso; downloads e arquivo privado
do notebook são suficientes. Desconectar o runtime ao concluir o trabalho
da sessão, sem excluir notebooks ou resultados do usuário.

Ao reportar, separar:
1. validação de engenharia;
2. dados exatos novos de restrições;
3. hipóteses sugeridas;
4. demonstrações matemáticas novas, se efetivamente obtidas.

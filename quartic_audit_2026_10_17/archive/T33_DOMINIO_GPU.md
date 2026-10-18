# T33: a sétima condição reduz pela metade o domínio GPU

## Resultado exato em CPU

O domínio T27 de 325.074.944 estados foi reduzido a **162.537.472 estados**, antes dos filtros finais de energia e Poisson. T33 impõe as cinco condições iniciais e a sétima. A sexta não é imposta: T30 demonstra que ela sozinha não reduz esse quociente.

Essas contagens se referem a estados do quociente das cinco fibras, não a funções bent ou a sobreviventes da varredura final. Nenhuma execução GPU de T33 foi realizada.

## Descida ao quociente

As cinco paridades da fórmula da sétima condição são determinadas pelas restrições nas fibras z={0,85,170,255,51}. Nos 33 bits do estado, suas máscaras são:

| paridade | máscara |
|---|---|
| R | 0xfccfe72 |
| M | 0x16f88 |
| K | 0x8540 |
| c57 | 0x1 |
| c99 | 0x2 |

Somente R usa os 12 bits de extensão; sua máscara nesses bits é 0x7e. Assim a sétima condição é uma equação afim na extensão, com gradiente fixo. Ela pode ser combinada exatamente com a equação afim de Q4 já usada por T27.

Dos 108.032 pais T27 com uma equação de extensão, 65.024 passam a ter duas equações independentes e 1.024 extensões cada. Em 43.008 pais as equações coincidem: 21.504 são consistentes e mantêm 2.048 extensões; os outros 21.504 são incompatíveis e desaparecem. Os 25.348 pais antes sem equação recebem a nova equação e mantêm 2.048 extensões cada.

Portanto há 65.024 pais com 1.024 extensões e 46.852 com 2.048:

`65024·1024 + 46852·2048 = 162537472`.

## Verificação e pacote A100

`VERIFICAR_DESCIDA_T33.py` reconstrói as órbitas e confirma a descida das formas ao quociente e suas máscaras, usando apenas Python padrão. A validação de mapeamento em CPU conferiu equivalência dos sistemas afins para todos os 111.876 pais, 49.152 estados gerados em cubos completos selecionados e 128 avaliações originais da ANF, incluindo Walsh e a sétima condição. Relatórios: `T33_DESCIDA_VERIFICACAO.json`, `T33_MAPPING_CPU_VALIDATION.json`, `T33_exact_domain_report.json`.

Use `GRAU4_T33_COLAB.zip` com `GRAU4_T33_A100.ipynb`. O piloto padrão processa 16.777.216 estados, compara a geração CUDA/CPU e os filtros, mede velocidade e salva checkpoint. Só depois de passar nessas conferências deve ser iniciada a varredura completa. O notebook não instala pacotes nem monta o Drive automaticamente.

Os pacotes anteriores foram preservados como versões históricas reproduzíveis. T33 é a versão atual para o próximo piloto A100.

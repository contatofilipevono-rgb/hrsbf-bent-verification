# Campanha adaptativa de fibras

Abra `HRSBF_GPU_LOOP.ipynb` no Google Colab, escolha uma GPU e conecte o ambiente. Execute as células em ordem. O notebook contém o código, verifica CPU versus CUDA e encerra se houver divergência. Não foram executados testes na GPU nesta sessão: o Colab observado estava sem login e a abertura do login do Google retornou 502.

## O que a campanha faz

- Testa quínticas e sépticas homogêneas RS em n=16.
- Avalia todas as 255 fibras não nulas e a derivada na direção de todos os uns.
- Combina candidatos novos densos, candidatos esparsos e mutações dos melhores candidatos da rodada anterior.
- Aprende uma cobertura finita de fibras e a valida em sorteios novos.
- Registra os coeficientes, pesos, testemunhas, propostas de hipóteses e checkpoints.
- Exporta um ZIP; a célula de exportação também pode ser executada após uma interrupção.

O padrão é 100 rodadas de 512 sorteios por alvo, com limite de 30 minutos por alvo. Pode haver repetições. A GPU calcula os lotes; a opinião de uma IA não substitui os dados, a avaliação direta da ANF ou uma prova.

## Resultados locais já obtidos na CPU

Foram concluídas quatro rodadas de grau 5 (1024 sorteios) e duas rodadas de grau 7 (256 sorteios). Nenhum candidato nessas rodadas satisfez o balanceamento simultâneo de todas as fibras não nulas. Os controles completos de n=8, graus 3 e 5, e controles bent positivos passaram. Uma testemunha em cada campanha foi reconstruída diretamente pela ANF.

No grau 5, as fibras z=5 e z=3 cobriram os 1024 sorteios iniciais. Em 8192 sorteios densos com semente nova, 28 funções passaram por essas duas fibras. Outras fibras as excluíram na amostra registrada.

A cobertura ampliada {5,3,15,1} foi então testada em 65536 novos sorteios densos: cinco passaram por essas quatro fibras. Os três exemplos registrados foram excluídos por outras fibras, com reconstrução independente da ANF: pesos 136, 96 e 136, em vez do peso balanceado 128.

Isso demonstra por que o loop precisa tentar refutar as hipóteses que ele próprio sugere. Nenhuma dessas coberturas é um certificado universal.

## Reproduzir na CPU

```bash
OPENBLAS_NUM_THREADS=1 python3 pesquisa_fibras_loop.py --backend cpu --rounds 4 --batch 256 --output rodada_cpu_loop_2026_10_06 --max-seconds 120
OPENBLAS_NUM_THREADS=1 python3 verify_fibras_loop.py --folder rodada_cpu_loop_2026_10_06 --round 4
OPENBLAS_NUM_THREADS=1 python3 audit_learned_cover.py
```

Para o Gemini dentro do Colab, use `ROTEIRO_GEMINI_LOOP.md`. Peça comandos e resultados observados; nenhum modelo deve transformar ausência de sobreviventes em amostras numa prova de inexistência.

## Limites

O caminho CUDA foi preparado, mas só poderá ser considerado validado depois de executar os controles CPU/CUDA numa sessão com GPU. Os checkpoints ficam no armazenamento temporário do Colab e precisam ser exportados para sobreviver a uma reinicialização. Este notebook não formaliza o teorema cúbico nem resolve o caso quíntico geral.

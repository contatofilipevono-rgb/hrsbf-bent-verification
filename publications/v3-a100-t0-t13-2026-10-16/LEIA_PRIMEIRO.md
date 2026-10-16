# Pacote atualizado T0–T13 — 16/10/2026

Este pacote inclui os resultados reais da A100 e os novos testes de
continuação. Comece por `docs/CONTINUACAO_T11_T13_RESULTADOS.md` e pela
demonstração em `docs/PROPOSICAO_REDUCAO_PERIODO_QUATRO.md`.

- `notebook/`: notebook completo com as doze células executadas e saídas.
- `code/`: seis scripts efetivamente executados no Colab.
- `results/`: certificados JSON/NPZ, checkpoints, logs e 6.144 exceções.
- `reference/`: pacote de referência n=12 corrigido, sem modificações.
- `historico/`: relatórios da primeira rodada, anteriores aos avanços T11–T13.

O estado final está em `results/T13_final_summary.json`. Arquivos de piloto
e de descoberta por amostra são mantidos por proveniência; eles não
substituem os certificados integrais posteriores.

Em n=20 foram enumerados 2^30 estados após excluir 3/4 da imagem de posto
32. Sobrevivem 536.864.768 estados; a exclusão total é 87,500143%. A prova
do adendo fornece três condições necessárias para n=4p, p primo>=5, e
exclui 7/8 em toda essa família. A prioridade bibliográfica não está
estabelecida e não há formalização Lean dessa nova demonstração.

Os casos n=16 e n=20 e a conjectura global continuam abertos. Não publicar
como prova de inexistência nem substituir o preprint por este pacote.

Para reproduzir num runtime novo: selecionar A100, enviar os seis scripts
de `code/` e o ZIP de `reference/` para `/content/`, abrir o notebook e
executar na ordem. A etapa de tabelas n=20 requer mais de 16 GiB de memória
GPU. O arquivo SHA256SUMS.txt cobre todos os demais arquivos do pacote.

Proveniência: `experiment.py` é a versão usada na primeira célula de
validação/benchmark; `experiment_science.py` contém as ampliações usadas
nas células científicas seguintes. As duas versões foram preservadas
exatamente como exportadas do runtime, seguindo os imports do notebook.

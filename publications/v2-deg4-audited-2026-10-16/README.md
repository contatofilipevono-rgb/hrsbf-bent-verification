# Pacote de submissão — grau 4, n = 12

O manuscrito principal está em inglês, com escopo concentrado na certificação
computacional de n = 12. A auditoria está em português. A carta é uma minuta
editorial, ainda sem periódico, afiliação ou declarações pessoais não fornecidas.

## Arquivos principais

- `manuscript/manuscript.pdf` e `.tex`: artigo de submissão.
- `audit/relatorio.pdf` e `.tex`: falhas, correções, evidências e limites.
- `manuscript/cover_letter.pdf` e `.tex`: carta de apresentação.
- `code/`: dois verificadores da cascata, terceira auditoria e Lean auxiliar.
- `logs/` e `results/`: registros da execução desta revisão.
- `SHA256SUMS.txt`: integridade de todos os arquivos do pacote, exceto o próprio manifesto.

## Reprodução

Ambiente testado: Python 3.12.14, NumPy 2.3.5, Lean 4.15.0 e LuaLaTeX.
Use um ambiente virtual de sua preferência e instale `requirements.txt`.
Na raiz extraída do pacote:

```sh
python -m pip install -r requirements.txt
python code/audit_foundations.py
python -u code/verify_stanica_maitra_deg4_v2.py
python -u code/verify_independent_n12_reimpl.py
lean code/StanicaMaitraDeg4_v2.lean
```

Não execute Python com `-O`: os verificadores usam `assert`.
O verificador principal escreve em `results/`, relativo ao próprio arquivo.
A segunda implementação imprime os contadores e termina com uma asserção de zero
sobreviventes. O tempo e a memória dependem do equipamento; reserve vários minutos
e alguns GB de RAM. O pacote não requer serviços externos nem bases de dados.

Com elan, `lean-toolchain` seleciona a versão. Sem elan, execute diretamente o
binário Lean 4.15.0. A compilação bem-sucedida pode não produzir saída textual.
O adaptador de `/proc` registrado nos logs foi necessário apenas no ambiente
isolado desta auditoria; não modifica o código Lean ou o kernel de prova.

Para reconstruir os PDFs, execute duas vezes cada comando:

```sh
lualatex -interaction=nonstopmode -halt-on-error -output-directory=manuscript manuscript/manuscript.tex
lualatex -interaction=nonstopmode -halt-on-error -output-directory=manuscript manuscript/cover_letter.tex
lualatex -interaction=nonstopmode -halt-on-error -output-directory=audit audit/relatorio.tex
```

## Como interpretar os resultados

O certificado exclui todo o espaço 2^43 em n = 12 por condições necessárias.
Não demonstra a conjectura geral. Os 64 testes de energia diagonal não são
equivalentes aos 4096 testes de módulo de Walsh para bentness.
O Lean certifica enunciados auxiliares, incluindo a sizígia nos 43 geradores
explicitamente listados, mas não executa a cascata nem prova o teorema principal.

Os dois programas da cascata compartilham os filtros matemáticos. O segundo usa
tabelas completas de fibras e FWHT, sem o transporte de sinais do primeiro.
Sua concordância reduz riscos de implementação; a validade dos filtros é
demonstrada no artigo. A terceira auditoria não importa os outros programas.

O artigo amplo recebido foi substituído por um manuscrito focado. Não incluímos
seu PDF antigo no pacote de submissão, para evitar a circulação das afirmações
retiradas. Os testes suplementares de n = 10 e dimensões maiores permanecem
no programa principal, com os limites descritos no relatório.

Antes de enviar, complete os dados autorais e as declarações exigidas pelo
periódico escolhido. A prioridade bibliográfica não foi certificada de modo
exaustivo. Nenhuma publicação externa foi realizada.

# Preparação para submissão

## Resultado que o manuscrito sustenta

Não existência de funções bent cúbicas homogêneas simétricas por rotação em toda dimensão positiva par n com 32∤n. A prova combina redução por ordem ímpar, descrição exata do espaço restrito e divisibilidade comprovada por cálculo finito. Não se afirma a resolução da conjectura inteira.

A comparação integral com Meng–Chen–Fu (2010) e Sun–Shi–Liu–Fu (2026) está registrada. A não bentness da cúbica de uma órbita contígua em n=32 já é conhecida; seu cálculo é um controle de divisibilidade.

## Arquivos da versão

- paper_hrsbf.tex: manuscrito principal.
- supplementary_material.tex: suplemento.
- cover_letter_dcc.tex: carta em rascunho.
- COMPARACAO_MENG_2010.md e COMPARACAO_SUN_2026.md: documentação da comparação bibliográfica.
- AUDITORIA_FINAL.md: alcance da auditoria e suas limitações.
- submission_manifest.json: SHA-256 dos arquivos obrigatórios da verificação.
- verify_submission.py: verifica integridade e executa os verificadores matemáticos.
- avanco_t32/verificar_fibras_exato.py: ferramenta de pesquisa para candidatos em n=32.
- avanco_t32/validar_fibras_exato.py: controles diferenciais dessa ferramenta.

Comando da suíte padrão, sem bibliotecas externas:

    python verify_submission.py

Somente integridade, sem fazer alegação de verificação matemática:

    python verify_submission.py --integrity-only

Todos os arquivos do manifesto são obrigatórios. Ausência ou divergência interrompe a suíte antes da execução dos verificadores. Os hashes conferem bytes relativos à versão registrada, não são uma assinatura de autoria nem uma demonstração de correção. Se arquivos cobertos forem legitimamente alterados, regenerar o manifesto e revisar essas mudanças; não copiar hashes de outra versão.

A implementação independente com NumPy continua disponível como verificação adicional; não é dependência da suíte padrão.

## Dados ainda necessários

A lista de autores, a ordem de autoria, afiliações, e-mail do autor correspondente, financiamento e declarações aplicáveis devem ser fornecidos pelos autores. Não foram inferidos a partir da conta do GitHub. A carta não deve ser enviada com esses campos pendentes. A publicação não foi submetida por esta revisão.

## Roteiro para leitura externa

Sem envio automático a terceiros, o pacote pode ser apresentado a um leitor externo com quatro perguntas:

1. O lema quadrático de ordem ímpar permanece correto para polares degeneradas e termos constantes?
2. O estabilizador do suporte cúbico e a multiplicidade do dobramento justificam todas as órbitas quadráticas e lineares admitidas, sem introduzir a quadrática antipodal?
3. A passagem dos representantes de órbitas para a divisibilidade da tabela completa, inclusive as interseções de ordem maior que quatro, está suficientemente explícita?
4. O alcance uniforme e o reconhecimento das sobreposições com os resultados consultados estão claros e a contribuição é apropriada para avaliação editorial?

Essa leitura não foi simulada nem chamada de revisão por pares.

## Próxima pesquisa: n=32

A ferramenta exata aceita um JSON com n=32, coordinate_base=0 e sanf como lista de suportes cúbicos de três coordenadas. Cada órbita deve aparecer uma vez. Coordenadas repetidas, duplicatas de órbita e entradas não homogêneas são recusadas.

Exemplo:

    python avanco_t32/verificar_fibras_exato.py avanco_t32/exemplo_fibras32.json --z 2261 --enumerate-sum --output auditoria_2026_10_04/exemplo_fibras32_resultado.json

O programa expande f(u,u+z) na ANF de 16 variáveis com u_i²=u_i, preserva termos constantes e lineares, reconstrói a polar alternante e calcula uma base do radical. Balanceamento equivale à parte linear normalizada ser não nula nesse radical. A opção --enumerate-sum calcula também a soma de sinais sobre os 65.536 pontos da fibra usando percurso Gray.

Sem --z, são testadas as 16 direções coordenadas, com interrupção na primeira fibra não balanceada. --all seleciona todas as 65.535 direções não nulas, também com interrupção na primeira obstrução; o tempo depende do candidato. Nenhum prazo universal de cinco segundos é prometido.

Uma fibra não balanceada fornece uma obstrução necessária à bentness, válida porque a cúbica homogênea RS se anula no subespaço diagonal de meia dimensão. Todas as fibras balanceadas não bastam para concluir bentness. O relatório sempre registra bentness_certified=false; não deve ser apresentado como busca completa de todas as funções em n=32.

Antes de um gerador SAT, formalizar quais variáveis descrevem o candidato e quais relações de polar, radical e avaliação são necessárias. Comparar a codificação em famílias pequenas com enumeração direta. Restrições do certificado de sete fibras só podem ser aplicadas após verificar a condição de parâmetro fixado que lhes dá validade. Não adicionar uma contradição pronta como se fosse uma condição universal.

# Auditoria dos relatórios Lean remotos

O executor existente pode anunciar sucesso se receber raízes vazias ou ausentes, pois ignora arquivos não encontrados. Dois testes sintéticos reproduziram esse caso, sem executar o Lean. Não há evidência de que tenha ocorrido na execução remota atual, que gerou seus arquivos normalmente.

A auditoria separada rejeita esses relatórios, verifica a presença da raiz H12CloudChartN, contagens, duplicações, fontes, resultados das fases e, quando fornecidos, os hashes e conteúdos dos logs. Os 14 testes incluem relatórios parciais válidos, conclusão de uma única carta, raiz ausente, carta incorreta, falsa conclusão global e logs adulterados. Essa auditoria é de consistência e não substitui o núcleo Lean nem atesta a autenticidade de logs externos.

## Uso na aceitação do próximo checkpoint

```sh
python -m unittest test_audit_cloud_report -v
python audit_cloud_report.py caminho/progress.json --chart 2 --logs caminho/logs
```

Uma mensagem CONSISTENT_COMPLETE_CHART_REPORT significa somente que o relatório da carta é internamente consistente. A prova global ainda exige três cartas e a integração final. Sem --logs, somente a estrutura e os hashes declarados são examinados.

O auditor não está automaticamente integrado no workflow atual. O executor ativo e sua chave de cache foram preservados, evitando invalidar o progresso durante a execução. Aplicar esta auditoria antes de aceitar o próximo resultado exportado. A correção do caso vazio no executor e sua estratégia de migração do cache ficam registradas para a próxima revisão do workflow.

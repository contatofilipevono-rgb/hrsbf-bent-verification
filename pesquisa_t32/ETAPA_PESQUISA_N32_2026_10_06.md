# Resultado da etapa seguinte

O resultado principal desta etapa é a prova em `PROVA_CUBICA_N32_2026_10_06.md`: não existem funções cúbicas homogêneas simétricas por rotação bent em 32 variáveis. O certificado é universal sobre os 155 coeficientes cúbicos, sem restrição no peso H. A prioridade bibliográfica ainda não foi estabelecida.

Antes da simplificação algébrica universal, obtivemos e auditamos esta cobertura computacional:

| Peso de H | Parâmetros | Excluídos | Restantes |
|---|---:|---:|---:|
| 0 | 1 | 1 | 0 |
| 1 | 35 | 35 | 0 |
| 2 | 595 | 595 | 0 |
| 3 | 6.545 | 6.545 | 0 |
| 4 | 52.360 | 52.360 | 0 |
| 5 | 324.632 | 324.632 | 0 |

O peso três está documentado no pacote anterior. Os demais estão em `certificados_pesos_0_1_2_4_5.json.gz.b64`, comprimidos sem perda. O auditor lê esse formato diretamente:

```
python3 audit_next_weights.py certificados_pesos_0_1_2_4_5.json.gz.b64 auditoria_pesos.json
```

Os metadados de escopo desse lote indicam corretamente que o lote de pesos limitados não cobria sozinho todas as cúbicas. O resultado universal é separado, em `status_universal_n32_2026_10_06.json` e nos arquivos de prova e auditoria universais.

Reprodução do resultado principal:

```
python3 audit_universal_n32.py certificado_universal_n32.json
python3 verify_universal_n32.py certificado_universal_n32.json auditoria_universal_n32.json
```

Os dois auditores regeneram ou avaliam os geradores e verificam 136 identidades lineares que tornam a fibra complementar constante sob as condições necessárias de bentness. A prova explica por que essas condições são necessárias e por que uma fibra constante contradiz bentness neste caso homogêneo. Há controles positivos não homogêneos.

Não há razão computacional para continuar enumerando os outros pesos H em n=32 com GPU: a prova universal já os abrange. O próximo trabalho deve ser revisão adversarial da prova, comparação bibliográfica e depois a escolha de uma dimensão ou grau não coberto. O resultado não resolve a conjectura para todas as dimensões ou graus e não inclui cúbicas com termos quadráticos adicionais.

# Consolidação do bloco afim em U

O parecer atualizado do Fable, recebido nesta conversa em 10 de novembro de 2026, relata a conclusão de todos os tipos de q não nulo. Seus resultados independentes são registrados abaixo com a numeração usada por ele. Essa numeração depende da base escolhida para o espaço de q.

| Tipo no parecer | Peso | Mapas percorridos | Fibras planas | Com fase |
|---|---:|---:|---:|---:|
| #1 | 30 | 2²⁸ | 0 | 0 |
| #2 | 24 | 2²⁸ | 10.368 | 1.280 |
| #3 | 30 | 2²⁸ | 0 | 0 |
| #4 | 16 | 2²⁸ | 0 | 0 |
| #6 | 28 | 2²⁸ | 0 | 0 |
| #5 e #7 | 31 | Excluídos pela paridade | 0 | 0 |

O Fable informa que cada rodada de peso par percorreu o trasladado afim completo, com apenas o filtro necessário dos pares verticais antes do teste das fibras. São cinco rodadas de 2²⁸ mapas, ou 1.342.177.280 mapas candidatos no total. Os arquivos dessas execuções não foram importados neste turno. A tabela registra o resultado comunicado pelo Fable, cuja recontagem é independente da nossa.

A classificação sobre F4 resolve as contagens do tipo sobrevivente por parâmetros.

- 72 funções psi vêm de 4·15+4·3.
- As 36 escolhas ímpares vêm de nove pares de coeficientes e quatro soluções de uma equação linear sobre F4.
- As quatro orientações são os dois parâmetros binários lambda e mu.
- As 32 funções psi da família não homogênea têm seis escolhas ímpares com fase.
- Quatro funções psi têm 20 escolhas, e duas têm 24.
- As 34 restantes não admitem fase.

Isso dá 10.368=72·36·4 mapas com fibras planas e 1.280=4·(32·6+4·20+2·24) mapas com fase. Cada um tem 2¹³ fases, totalizando 10.485.760 funções.

O dicionário entre as duas descrições está na seção 9 de CLASSIFICACAO_F4_BLOCO_U.md. Ele foi conferido nos 10.368 mapas. A parametrização reconstrói todo esse conjunto sem precisar lê-lo como entrada.

O resultado consolidado tem duas componentes de prova. O tipo de peso 24 possui classificação algébrica, com dois lemas de comparação finita de coeficientes e auditoria adversarial pelo Astra. Os outros tipos são excluídos pela paridade ou pelas recontagens exaustivas independentes relatadas pelo Fable. Uma exclusão inteiramente algébrica dos tipos de pesos 16, 28 e 30 continua como alvo.

Esse fechamento trata do bloco afim no hiperplano antipodal U de dimensão cinco. As outras 8.730.624 quárticas exteriores ainda exigem sua própria classificação.

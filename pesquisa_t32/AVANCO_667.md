# Avanço das 667 famílias em n=32 — 4 de outubro de 2026

O estrato de parâmetros polares H de peso 3 tem 6.545 elementos. Cada H fixa uma família afim de dimensão 120 nos 155 coeficientes cúbicos. A triagem inicial com 119 direções excluiu 5.878 famílias e deixou 667.

| Etapa | Famílias de entrada | Excluídas | Restantes |
|---|---:|---:|---:|
| 512 direções determinísticas; contradições de posto 14 | 667 | 618 | 49 |
| Todos os 4.115 representantes de direções; radical forçado a zero | 49 | 19 | 30 |

Assim, 6.515 das 6.545 famílias deste estrato estão excluídas. As 30 restantes não são exemplos bent: são famílias ainda não decididas por estes testes necessários. Outros pesos de H também não são resolvidos por esta contagem.

## Certificados e fibras de posto inferior

Usamos a partição x=(u,u+z). A fibra diagonal é nula para cúbicas homogêneas invariantes pela meia rotação. Parseval então exige balanceamento de toda fibra não nula de uma função bent.

Para uma fibra quadrática q, escreva Q(r)=q(r)+q(0). No radical da forma polar, Q é linear. A fibra é balanceada exatamente quando existe r no radical com Q(r)=1. Para posto inferior a 14, isso é uma disjunção sobre uma base do radical; não se substitui por uma equação individual.

As 618 exclusões são contradições entre as 35 equações que fixam H e as condições de posto 14. As outras 19 têm posto zero na direção z=65535: as equações da família forçam todas as avaliações normalizadas no radical a zero. Logo a fibra é constante e não balanceada. Os verificadores reconstruíram separadamente os coeficientes, os radicais e as identidades de cada certificado: 618 e 19 verificações passaram.

As 30 restantes não apresentam posto 14 em nenhum dos 4.115 representantes. Seus postos são no máximo 12. Suporte de H em órbitas de mesma paridade não basta para afirmar que todas as funções da família se desacoplam por paridade: os 120 coeficientes livres precisam ser considerados.

## Por que 4.115 direções cobrem as fibras

Os vetores z não nulos são agrupados sob rotação ordinária de seus 16 bits, e não sob uma ação afim em z. Na partição acima, uma rotação completa das 32 coordenadas induz z'=R16(z) e uma transformação afim bijetiva em u (com a convenção de rotação à esquerda: u'=R16(u)+z15 e0). Portanto, as fibras nas direções da mesma órbita têm o mesmo balanceamento. O enumerador verifica que as órbitas, junto com zero, cobrem todos os 65.536 vetores.

## Modelo SAT exato das condições necessárias

Foi gerada a CNF para H=0xc0000004, uma das 30 famílias restantes, eliminando as 35 coordenadas fixadas por H. Cada uma das 4.115 fibras impõe a disjunção das avaliações afins de Q numa base do radical. As paridades são codificadas por portas XOR com equivalências completas; subexpressões são compartilhadas.

Resultado: 120 variáveis livres, 211.400 variáveis totais e 849.202 cláusulas. Foram conferidos 48 casos dos controles de codificação, 100 substituições de coordenadas e 8 atribuições da fórmula inteira contra suas disjunções originais. Esses controles não substituem uma auditoria independente do modelo.

**Nenhum solver foi executado e nenhum resultado UNSAT é alegado.** UNSAT, acompanhado de prova verificada e da auditoria da modelagem, excluiria essa família. SAT provaria apenas consistência destas condições necessárias, sem certificar bentness. O próximo passo é executar um solver com certificado e um verificador de prova nesta instância antes de expandir às outras 29.

## Reprodução (Python 3.10+, biblioteca padrão)

Execute a partir desta pasta:

```bash
python3 aprofundar_667.py --source triagem_t32_peso3.json --check-only etapa_667_512.json --output conferir_618.json
python3 aprofundar_667.py --source triagem_t32_peso3.json --remaining-from etapa_667_512.json --check-only etapa_49_orbitas.json --output conferir_19.json
python3 modelo_radicais_t32.py --h 0xc0000004 --output-prefix reconstruida
```

O último comando reconstrói as fibras e a CNF desde os coeficientes originais. A opção `--reencode familia_c0000004_compacta.json` acelera a recodificação usando dados já calculados; não equivale a reconstruir a álgebra das fibras. Os relatórios completos, os 30 parâmetros restantes, a CNF e seu hash estão no pacote. Esta pesquisa está separada do manuscrito congelado para submissão.

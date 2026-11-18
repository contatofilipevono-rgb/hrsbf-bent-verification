# Busca por `0xff` e pelos 4 Alvos 7-de-8 (`0xfd`, `0xf7`, `0xdf`, `0x7f`) em $H_{16}$ ($c_{99}=1$, C1–C7)

Busca executada no GitHub Actions (Run ID `44221209611`, Job ID `134523238538`, `ubuntu-latest`, `6m37s`, custo US\$ 0,00) partindo do commit `9566eb5`.

## Tabela Final dos Alvos

| Alvo | Única distância que pode falhar | Status | Hexadecimal (116 bits) | $k_{\text{long}}$ | $W_f(0), W_f(e_0)$ | 8 valores com sinal (`0x3..0x101`) | Peso 2 | 1ª falha (FWHT) |
|---|---|---|---:|---:|---|---|---:|---|
| `0xff` | nenhuma (8/8) | **sem testemunha na busca realizada** | — | — | — | — | — | — |
| `0xfd` | 2 (`0x0005`) | **testemunha auditada** | `0x7dfbc6e96ab4ccc7522a55a9b149` | 59 | `-256, 256` | `256, 768, 256, 256, -256, 256, 256, -256` | 104/120 | `0x5 -> 768` (peso 2) |
| `0xf7` | 4 (`0x0011`) | **testemunha auditada** | `0x21fa9da6202a8f316e69bc43b2cbb` | 55 | `256, 256` | `256, 256, -256, 320, 256, 256, 256, -256` | 104/120 | `0x7 -> 0` (peso 3) |
| `0xdf` | 6 (`0x0041`) | **testemunha auditada** | `0x4549b7cd9fc26c844fa27b80f56d5` | 59 | `-256, 256` | `-256, 256, 256, 256, 256, 768, 256, -256` | 104/120 | `0x7 -> 0` (peso 3) |
| `0x7f` | 8 (`0x0101`) | **testemunha auditada** | `0x7ffacd667b275bb99963c1fa99b53` | 67 | `-256, 256` | `256, 256, 256, 256, 256, -256, 256, 512` | 112/120 | `0x7 -> 0` (peso 3) |

## Conclusão

Com estas quatro testemunhas somadas às quatro máscaras 7-de-8 que omitem uma distância ímpar (`0xbf`, `0xef`, `0xfb`, `0xfe`), **toda escolha fixa de sete das oito distâncias de peso 2 deixa passar alguma candidata C1–C7 que também passa em $W_f(0)$ e $W_f(e_0)$**. A ausência de `0xff` neste piloto não demonstra impossibilidade.

## Reprodução

```bash
gh workflow run search_h16_c99_7of8_0xff.yml --repo contatofilipevono-rgb/hrsbf-bent-verification
```

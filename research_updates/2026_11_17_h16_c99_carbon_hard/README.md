# Análise Algébrica via `gemini-4-carbon` para Exclusão do Ramo $c_{99}=1$ em $H(16,4)$

Chamada analítica com contexto máximo do caderno, certificados `T28`/`T31`/`T32`, testemunhas de 6 e 7 distâncias e relatório do Run `44221209611`.

## Configuração Efetiva

1. **Chamada `HIGH` (`carbon_hard_c99_meta.json`)**: `model=gemini-4-carbon`, `thinking_level=HIGH`, `include_thoughts=True`, `max_output_tokens=None`, `promptTokenCount=19.611`, `thoughtsTokenCount=65.533`, `candidatesTokenCount=3`, `finishReason=MAX_TOKENS` (pensamentos salvos em `carbon_hard_c99_thoughts.md`).
2. **Chamada `MEDIUM` (`carbon_medium_c99_meta.json`)**: mesmo contexto (`19.611` tokens), `thinking_level=MEDIUM`, `max_output_tokens=65536`, `candidatesTokenCount=50.239`, `finishReason=STOP` (resposta integral em `carbon_hard_c99_analysis.md`, `108.774` bytes).

## Principais Resultados e Lacunas

- **Refutação de obstrução 2-ádica $\bmod 512$ em peso $\le 2$**: `0xfd` e `0xdf` satisfazem $W_f(0) \equiv W_f(e_0) \equiv W_f(e_0+e_d) \equiv 256 \pmod{512}$ para todas as 8 distâncias.
- **Redução $113 \to 8$ em `0x5555` e Teorema 1**: para toda função bent em $c_{99}=1$, os 6 sinais em $U_4$ são iguais e $H(v)=0$ para os 5 cosets não-nulos de $U_4^\perp$, com $H(0) = \pm 256$.
- **Teorema Diagonal em `0x3f3f`, `0x5f5f`, `0x6f6f`**: $B_0(\delta) = 16(-1)^{c_{57}} \equiv 16 \pmod{32}$, injetando termo constante `1` nas condições $\bmod 32$.
- **Plano de certificado reproduzível**: extração simbólica (`VERIFICAR_ALGEBRA_C99_1.py`) dos polinômios de $H(v)=0$, $H(0)=\pm 256$ e suportes `0x3f3f/0x5f5f/0x6f6f` sobre as 111 variáveis livres, validação contra todas as testemunhas auditadas e decisão via matriz de Macaulay ou XOR-SAT.

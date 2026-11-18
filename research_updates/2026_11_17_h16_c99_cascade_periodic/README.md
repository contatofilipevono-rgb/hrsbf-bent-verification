# Ataque em Cascata e Frequências Periódicas ($u^{(2)}, u^{(4)}, u^{(8)}$ e Peso 2) no Interior de $H_{16}$ ($c_{99}=1$)

Execução dos próximos passos recomendados pelo `gemini-4-carbon` sobre **235.154.252** vetores no interior ($6 \le k \le 106$) do ramo $c_{99}=1$ (C1–C7).

## Frequências Testadas em Cascata (após $W_f(0), W_f(e_0)$ e C1–C7)

1. `u2_0x5555` (período 2, peso 8, estabilizador de ordem 8)
2. `u4_0x1111` (período 4, peso 4, estabilizador de ordem 4)
3. `u8_0x0101` (período 8, peso 2, estabilizador de ordem 2)
4. `w2_d1_0x0003` .. `w2_d7_0x0081` (demais 7 órbitas de peso 2: $e_0 + e_d$, $d=1..7$)
5. `u4_w8_0x3333` (período 4, peso 8)

## Resultados Principais (Cloud Run Job `h16-c99-cascade-periodic-4r5fv`, 8 vCPUs, 77,95s)

| Faixa | Testados (C1–C5+C7) | Passam $W_f(0), W_f(e_0)$ e C7 | Passam até `u8` | Passam até `d=4` (`0x11`) | Passam até `d=5` (`0x21`) | Bent |
|---|---:|---:|---:|---:|---:|---:|
| `central_50_62` | 80.000.000 | 255.449 | 4.363 | 1 | **0** | 0 |
| `full_interior_6_106` | 79.490.461 | 179.966 | 3.389 | 3 | **0** | 0 |
| `near_dense_97_106` | 75.663.791 | 11.179 | 216 | 0 | **0** | 0 |

### Descoberta Modular ($\bmod 128$) sobre os 446.594 Sobreviventes C7 de $(W_f(0), W_f(e_0))$

- **`u2_0x5555`, `u4_0x1111` e `u4_w8_0x3333`**: **100% (446.594 / 446.594)** já são $\equiv 0 \pmod{128}$ após C1–C7 — nenhuma falha modular ocorre em `64 mod 128`.
- **`u8_0x0101` e todas as 7 órbitas de peso 2 (`0x0003`..`0x0081`)**: dividem-se exatamente **50% / 50%** entre `0 mod 128` e `64 mod 128`, e cada uma aprova individualmente cerca de **11% (~1/9)** dos sobreviventes. Em conjunto, filtram **100%** dos `446.594` candidatos até `d=5` (`0x0021`), com `0` sobreviventes para FWHT completo.

## Reprodução

```bash
gcloud run jobs execute h16-c99-cascade-periodic --region=us-central1 --project=project-342eeb2f-3c82-4897-a4d --wait
```

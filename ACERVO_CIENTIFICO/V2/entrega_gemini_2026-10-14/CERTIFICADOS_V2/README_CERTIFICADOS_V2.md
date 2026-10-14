# CERTIFICADOS_V2 — Documentação, Comandos de Reprodução e Tempos Medidos
**Data de Execução Real:** 14 de outubro de 2026 (Python 3 + NumPy, Ambiente Linux Offline)

- `suite_auditoria_e_novos_teoremas_v2.py`: Reconstrução do zero de $f$, $\phi = D^4 f$, $C_\phi$, $\operatorname{Aut}(\phi)$ (ordem 1920), $\mathcal{G}_{\le 2}(f)$ (ordem 40), estratificação $\mathcal{N}_{r,k}$ com vértices isolados (Teorema C1) e contagem de flats $|\mathcal{M}_2(F_G+Q)|$ (Teorema 1). Tempo medido: ~2,3 s.
- `verificar_decomposicao_e_testemunhas_v2.py`: Prova das 2 testemunhas via Lema de Schur + 1-cociclo $\delta_3$ (Teorema C3), algoritmo $O(r^3)$ para $K(G,Q)$ (Teorema C2), verificação de $D_u D_v(F_G+Q)$ nos $65.536$ pares em $r=2$ e enumeração bent RS em NumPy vetorizado puro ($0,99\text{ s}$).
- `verificador_burnside_assintotica_v2.py`: Validação cruzada de $C_r(\pi)$ (Möbius vs. BFS direto em $r=2,3,4$) e codimensão $D - c_2(\tau) = 96r^2 - 204r + 144$ (Tarefa B). Tempo medido: ~0,10 s.
- `resumo_certificados_v2.json` e `saida_auditoria_completa_v2.txt`: Saídas reais da execução.
- `V2_NovosTeoremas_Lean4.lean`: Módulo Lean 4 (NÃO TESTADO por ausência de `lean`/`lake` na imagem offline).

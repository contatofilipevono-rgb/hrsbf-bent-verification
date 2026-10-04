# Revisão da crítica — 4 de outubro de 2026

## Resultado e alcance

O manuscrito explicita as hipóteses das fibras e do espaço restrito; suplemento, README e carta são alinhados ao mesmo alcance. O caso geral n=32 não está resolvido e a originalidade bibliográfica não está estabelecida.

| Ponto | Tratamento |
|---|---|
| Divisibilidade em n=16 | F_16 contém 35 órbitas cúbicas completas, sete quadráticas completas e L; exclui a quadrática antipodal. Não cobre termos inferiores arbitrários. |
| “Só homogêneas” | A função original é homogênea, mas a redução pode produzir termos quadráticos e lineares que precisam permanecer no espaço restrito. |
| Sete ou oito quadráticas | Oito no espaço RS completo, sete de comprimento 16. A antipodal tem comprimento oito. P_16=Σ_(i=0)^7 y_i y_(i+8) é bent, peso 32640≡128 (mod 256). |
| Redução por fator ímpar | A prova usa balanceamento de derivadas quadráticas. Controles para m=1,3,5 não substituem a prova universal. |
| Congruência n=32 | wt(H)/32=65780224≡512 (mod 2048), enquanto 32·wt(H)≡0 (mod 2048). |
| Barreira definitiva | Retirada do suplemento e da carta: refuta-se uma extensão específica de divisibilidade comprimida. |
| Balanceamento de fibras | Não vale para bent arbitrária. Aqui f se anula no subespaço diagonal de dimensão metade da dimensão total; a prova por caracteres foi incluída. |
| Uma equação no radical | Em geral é disjunção. Nas sete fibras, posto 14 dá radical de dimensão dois; a meia-rotação força L(z)=0 e resta L(r)=1. |
| Certificado | Reexecutado sobre ANFs originais: sete formas somam zero e sete lados direitos somam um. Apenas família η(c)=0x1, dimensão afim 120. |

A carta é agora um rascunho: remove aplicações não demonstradas e declarações de submissão/autoria não confirmadas. Contagens históricas sem registro correspondente não integram o resumo atual de evidências.

## Conferência bibliográfica

**Lei Sun; Zexia Shi; Jian Liu; Fang-Wei Fu.**
*On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions.*
**Designs, Codes and Cryptography 94, artigo 93 (2026)**.
Publicado em **13 de abril de 2026**.
DOI: [10.1007/s10623-026-01848-4](https://doi.org/10.1007/s10623-026-01848-4).
Fonte primária: [Springer](https://link.springer.com/article/10.1007/s10623-026-01848-4).

Autores, título, data e identificação editorial confirmados. A referência de páginas 1023–1045 no suplemento foi substituída pelo artigo 93. **Atualização:** o PDF integral foi fornecido pelo usuário e sua leitura foi concluída. A comparação por teorema está em [COMPARACAO_SUN_2026.md](COMPARACAO_SUN_2026.md). O Corolário 2 já cobre todos os n=2p^a; o Teorema 6 tem um limite dependente de cada suporte. Não se pode apresentar fatores compostos como novidade por si só.

**Cusick–Sanger (2017):** [texto primário](https://arxiv.org/pdf/1708.09313), Teorema 3.8. Para n=2p, p primo ímpar, bent homogênea precisa ter grau par. Exclui grau três nesse alcance; não autoriza dizer que a técnica “falha” para todo fator composto.

**Zhang–Gao (2013):** [texto primário](https://arxiv.org/pdf/1303.2282), também fornecido pelo usuário nesta revisão. O Teorema 3.1 usa hipóteses de forma e exclusão de suportes para obter k(d−1)<n/2; a Proposição 3.2 dá exclusões para famílias específicas de SANFs. Não é uma exclusão universal de todos os suportes cúbicos. O Teorema 3.7 e a Observação 3.8 tratam o caso quadrático por coprimalidade e destacam o termo antipodal necessário. As iniciais no suplemento foram corrigidas para X. Zhang e G. Gao. O símbolo de união de suportes na extração textual não deve ser confundido com XOR: a operação definida por zero apenas quando ambos os bits são zero é OR.

**Concluído:** acesso ao PDF e comparação dos enunciados de Sun–Shi–Liu–Fu. **Ainda não estabelecido:** prioridade em toda a literatura ou ineditismo de cada certificado em n=32. A checagem da Eq. (21) identificou um termo linear omitido na fórmula impressa para uma órbita completa; isso não é uma refutação global do artigo.

## Reprodução local

Comandos:

```bash
python avanco_t32/verificador_integrado.py
python avanco_t32/verificar_7_fibras.py
```

Todos os estágios passaram: 136697 interseções (124313 centrais e 12384 adicionais), bases pequenas, redução finita, controle bent n=12, controle quártico n=8, exemplo n=16, fibras e transferência em n=32. O verificador separado das sete fibras também passou.

Saídas reais em [auditoria_2026_10_04](auditoria_2026_10_04/). Não são execuções Colab nem certificação formal dos lemas algébricos. O controle n=12 tem peso 2080 e espectro ±64; a transferência n=32 retorna W_H(0)=85032960 e peso 2104967168.

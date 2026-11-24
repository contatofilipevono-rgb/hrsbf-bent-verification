# H(16,4): dualidade diagonal, cortes por órbitas e quociente por multiplicadores

Atualização independente, 24/11/2026. Este é um relatório de redução e auditoria, **não uma prova de inexistência de H(16,4)**. As cartas brutas partem de (c_{115}=0), (L(c)=c_{99}) e das convenções de A10. Não se presume (K=c_{57}) no ramo (c_{99}=0).

| Arquivo | Conteúdo |
|---|---|
| [A13](A13_diagonal_duality.md) | Dualidade diagonal, catálogo de perfis, 32 fibras excluídas de B0_11, auditoria C5 |
| [A14](A14_orbit_transfer.md) | Dois cortes explícitos, transferência de paridade por órbitas, equivalências e propagação afim |
| [Verificador A13](verify_h16_diagonal_reduction.py) | Certificado autônomo de 32 exclusões |
| [Verificador A14](verify_h16_two_cuts_and_multipliers.py) | Certificado de dois cortes e de 52 representantes; opção de propagação afim |

Reprodução (Python 3, NumPy 2):

```sh
python verify_h16_diagonal_reduction.py
python verify_h16_two_cuts_and_multipliers.py
python verify_h16_two_cuts_and_multipliers.py --propagate
```

O modo `--full` do segundo script também reproduz o certificado A13. Os testes foram executados com aritmética inteira exata. A redução A14 separa 96 fibras brutas restantes de B0_11 em 36 representantes, e 64 de B1_11 em 16. A parte K=1 de B0_00, cuja cobertura histórica requer auditoria, tem outros 16 representantes. As quatro células mistas foram recertificadas sob as premissas iniciais. Nenhuma conclusão de fechamento total é anunciada.

As notas A13/A14 e os scripts documentam os controles, as parametrizações e os limites; a novidade bibliográfica e a revisão humana permanecem por estabelecer.

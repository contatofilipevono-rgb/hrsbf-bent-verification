# Conclusão formal de H(12,4) — 21 de outubro de 2026

**A integração final foi concluída e auditada.** O kernel Lean 4.35.0 aceitou `H12Final.no_bent_quartic` e suas consequências espectrais. A família concreta contém todas as 2^43 funções determinadas pelos 43 coeficientes das órbitas quárticas cíclicas em doze variáveis. Nenhuma delas é bent.

## Enunciado exato

```lean
theorem H12Final.no_bent_quartic :
  ∀ c : BitVec 43, ¬ H12Descent.BentAC (H12.quarticFunction c)
```

Não há hipóteses adicionais de filtros, leis lineares ou refutações não instanciadas no enunciado. `all_chart_refutations` fornece concretamente as três raízes certificadas ao teorema de correção geral.

Também foram aceitos `no_flat_quartic` e `walsh_witness`: para cada vetor de coeficientes existe uma frequência a < 4096 com W_f(a)^2 ≠ 4096. Portanto não existe espectro de módulo constante 64 nessa família. A equivalência entre autocorrelação bent e Walsh plano é estabelecida por `H12Fourier.bent_iff_flat`.

## Identificação da família e escopo

A conferência independente, feita sobre a fonte cujo hash coincide com o registro certificado, confirma 43 órbitas disjuntas, fechadas pela rotação de uma posição, cobrindo exatamente os 495 suportes de peso quatro em doze posições. A função concreta usa os coeficientes 0–42 uma vez cada, ligados às respectivas somas XOR de monômios. Assim se identifica a família concreta com H(12,4).

O módulo final não inclui um novo teorema abstrato de representação de ANFs arbitrárias: a identificação da base explícita deve permanecer visível na apresentação do resultado. O resultado formal é o caso quártico em doze variáveis. Não afirma H(16,4), dimensões gerais nem inexistência para todo grau no máximo quatro. Não estabelece prioridade bibliográfica.

## Execução e auditoria

- [Run 39520500414, tentativa 2](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/39520500414/attempts/2), job 119018064985.
- Commit executado: `344ab2e1b330d4a6be3f00603e9423db39cf3354`, branch `fix/lean-resume-stability`. Nenhum merge do PR 6 foi realizado.
- `CERTIFIED_OBJECT_UNION_READY 2091` confirmou o reaproveitamento/reconstrução com hashes dos módulos certificados das três cartas. Depois foram compilados e reproduzidos pelo kernel os dois novos módulos `H12Fourier` e `H12Final`.
- O kernel encerrou a integração em 2026-10-21T04:48:34Z, 01h48 de Brasília. O salvamento independente e a conferência efetiva do cache terminaram depois, às 05:03:42Z.
- Todos os quatro relatórios finais de axiomas contêm somente `propext`, `Classical.choice` e `Quot.sound`; nenhum `sorryAx`, `ofReduceBool` ou erro foi aceito.
- A auditoria pós-execução conferiu os hashes das fontes exatas do commit executado, dos dois objetos finais e de seus logs de compilação/kernel. Releu a cópia independente: 364 objetos da carta 2 e 2.912 arquivos, com hashes e caminhos verificados. Os objetos finais também estão preservados no Git.

## Evidências para conferência

- [Fonte final certificada](certified_final_sources/H12Final.lean) e [ponte de Fourier certificada](certified_final_sources/H12Fourier.lean).
- [Relatório do verificador](run39520500414_attempt2_integration_report.json), [auditoria pós-execução](run39520500414_attempt2_AUDIT.json) e [conferência da codificação concreta](FINAL_CONCRETE_ENCODING_AUDIT.json).
- [Enunciados impressos e axiomas](H12Final_build_FINAL.log), [log do kernel final](H12Final_kernel_FINAL.log), [log do kernel de Fourier](H12Fourier_kernel_FINAL.log) e [log completo do job](run39520500414_attempt2_job.log).
- [Manifesto da cópia binária](run39520500414_attempt2_snapshot_manifest.json), [identidade remota/cache](FINAL_REMOTE_IDENTITY.json) e [metadados de preservação](run39520500414_attempt2_preservation.json).

Artefato GitHub: ID 12321886289, 681.655.422 bytes, SHA256 `2cc9b4aadfe6bfd5f89721b5a72f9768854f4d46c475763dd29953f8153b331c`. O ZIP completo está preservado na conversa em `outputs/final_integration/run39520500414_attempt2/run39520500414_attempt2_artifact.zip`. Arquivos grandes permanecem no artefato e na conversa; fontes, logs, hashes, manifesto e os dois pequenos objetos finais estão no repositório.

SHA256 do tar independente: `e8e89f57b1fe8f93dcacd99ee05536dfff2d335bbe0a26d5467e185d8a18a7ba`.

Cache final confirmado: `lean-h12-integration-v3-4265d1685051507075653a065b172f3d8445060ff2dae6c54b7e649067c6e5da-39520500414-2`, ID 9256537852, 3.633.326.716 bytes. Cache é temporário; a conclusão se apoia nas provas e evidências preservadas, não em sua retenção futura.

## Reprodução e próximos passos

O código exato da execução está no commit acima. As três cartas já têm seus pacotes e logs certificados, vinculados pelos digests de `integration_plan.json`. Os módulos finais podem ser rechecados com as dependências compiladas; reconstruir todas as dependências do zero pode exigir horas. Não se promete uma reconstrução integral em minutos.

A etapa de integração e conferência do enunciado está encerrada. A revisão humana da apresentação, da identificação concreta e das referências para o artigo segue como trabalho editorial distinto. O acompanhamento automático deve ficar pausado; não iniciar novas rodadas das cartas ou da integração.

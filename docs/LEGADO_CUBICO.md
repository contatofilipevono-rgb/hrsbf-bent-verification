# Etapa cúbica anterior: divisibilidade e certificados t=32

Este guia trata do **método anterior** que exclui dimensões pares não divisíveis por 32. O [teorema antipodal atual, Figshare v3](https://doi.org/10.6084/m9.figshare.34165260.v3), cobre todas as dimensões pares positivas; o limite deste método anterior não é uma questão aberta do caso homogêneo cúbico atual.

A [versão integral do README anterior](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/blob/9766e7eeda018ff505b648106b75da34818aac23/README.md) conserva as descrições e contagens originais no commit anterior à reorganização.

## Materiais preservados

- [Manuscrito por divisibilidade](../paper_hrsbf.tex), [suplemento](../supplementary_material.tex) e [dossiê](../dossie_completo_auditoria_hrsbf.md).
- [Notebook principal](../HRSBF_Auditoria_Colab.ipynb), bases t=2,4,8,16 e condições de Ward.
- [Estudos e certificados t=32](../avanco_t32/), com exclusões de subfamílias e quocientes específicos.
- [Notebook dos certificados t=32](../avanco_t32/Certificados_T32_Colab.ipynb).
- [Verificador standalone](../verificador_standalone.py) e [suite de fronteiras](../master_suite_fronteiras.py).

## Reprodução da etapa anterior

Na raiz do repositório, com Python 3:

```sh
python verificador_standalone.py
python master_suite_fronteiras.py
```

Para os certificados específicos de t=32:

```sh
cd avanco_t32
python verificar_7_fibras.py
python verificar_fibra_antidiagonal.py
python verificar_classes.py
python verificar_derivadas_diagonais.py
python verificar_subespaco_eta_paridade.py
python verificar_subespaco_eta_dim18.py
python verificar_subespaco_eta_dim21.py
python verificar_subespaco_eta_dim22.py
```

Esses comandos conferem os objetos da etapa anterior, não substituem a prova geral do suplemento antipodal. Tempos de execução e contagens detalhadas estão no README histórico; não foram medidos novamente em 08/11.

[Voltar aos resultados atuais](RESULTADOS_ATUAIS.md).

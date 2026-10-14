# Status matemático sintetizado — V2

## Confirmações computacionais locais

- Semente original n=8 bent, 24 monômios quárticos; posto C_phi=22, nulidade 6, espectro de bivectores no núcleo 4:3,8:60.
- `|Aut(D^4 f)|=1920`; `|G_{<=2}(f)|=40` sem translações não nulas; ambos os estabilizadores lineares relevantes são triviais.
- Em n=8, enumeração RS: 1023 formas quárticas não nulas; 211 bent-completáveis RS; 64 Grassmann-free bent-completáveis, repartidas em 32+32.
- Valores rotulados de dígrafos fracamente conexos r=2..7: 3, 54, 3834, 1027080, 1067308488, 4390480193904. A contagem 880471142 para r=7 é conhecida (OEIS A003085).
- Fórmula enumerativa de Burnside: verificada aritmeticamente por script para r=2..6, sob hipótese da classificação EA global.

## Advertências importantes

- O teorema de ultra-rigidez global necessita de auditoria linha a linha do salto de simetria local para conjugação por permutações de vértices.
- É falsa a afirmação: “para todo Q de grau <=2, F_G+Q é EA-indecomponível se e somente se G é fracamente conexo”. Contraexemplo: r=2, G vazio, Q=(x_{1,0}x_{2,0},0).
- O critério substituto por grafo de dependências K(G,Q), embora demonstrado em adendo, exige revisão independente da prova e dos casos limites.
- Não considerar comprovadas em Lean as conclusões globais: a formalização integral não foi apresentada/compilada nesta auditoria.
- Resultados de classificação EA e contagem de classes dependem uns dos outros; não usar concordância numérica como validação de originalidade.

## Direções com melhor custo/benefício

1. Descrever exatamente o grupo EA quando G tem vértices isolados.
2. Caracterizar componentes EA e decomposição canônica a partir do grafo de dependências K(G,Q).
3. Obter prova humana curta do grupo local de ordem 40, evitando dependência exclusiva de busca.

## Fonte

Consulte `FONTES_GITHUB_PINNED.md`. O pacote atual contém o material local mais os links/hashes Git, mas não o snapshot GitHub integral.

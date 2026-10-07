# Literatura e oportunidades para a v2 — 2026-10-07

## Escopo e proveniência

Pesquisa dirigida em fontes primárias; não é revisão sistemática exaustiva nem certificação de prioridade. V1 congelada em `d70ebc8a5a6c8a4901263af24ff71cbdb2a12e93`, branch `preprint-v1-final-2026-10-06`. Esta nota pertence exclusivamente à pesquisa v2. A regra antipodal da v1 é usada como resultado de entrada, sem reabrir sua prova. Nenhum resultado global em grau 4 ou 5 é afirmado.

## Literatura que pode ajudar

| Fonte primária | Evidência consultada | Uso concreto na v2 |
|---|---|---|
| Canteaut–Charpin, *Decomposing bent functions*, IEEE TIT 49(8), 2004–2019 (2003), DOI [10.1109/TIT.2003.814476](https://www.rocq.inria.fr/secret/Anne.Canteaut/Publications/Canteaut_Charpin03.pdf) | Texto do artigo: relações entre restrições, derivadas e dual; especialmente seções III e V | Formular o obstáculo quártico por espectros em classes laterais do dual. Não substituir essa condição por uma alegação de balanceamento de todas as segundas derivadas. |
| Tang–Qi–Zhou–Fan, *Two infinite classes of rotation symmetric bent functions with simple representation*, [arXiv:1508.05674](https://arxiv.org/pdf/1508.05674) | Teorema 3.1 e sua construção explícita | Controle positivo em qualquer grau; excluir a primeira família da busca de contraexemplos à transferência por repetição ímpar, conforme dedução abaixo. |
| Pašalić–Polujan–Kudin–Zhang, *Design and analysis of bent functions using M-subspaces*, [arXiv:2304.13432](https://arxiv.org/pdf/2304.13432) | Introdução e critério de pertencimento à classe completada de Maiorana–McFarland | Distinguir restrição afim numa única subvariedade de anulação global das segundas derivadas nas direções de um subespaço. |
| Zhou–Li–Zeng–Xu, *A generic construction of rotation symmetric bent functions*, AMC 15(4), 721–736 (2021), [10.3934/amc.2020092](https://www.aimsciences.org/article/doi/10.3934/amc.2020092) | Resumo e bibliografia oficiais; construção por modificação de suporte | Fonte candidata de controles quárticos. É necessário extrair as hipóteses do teorema completo antes de implementar; não presumir que saia da família anterior. |
| Zhang–Gao, *On the conjecture about the nonexistence of rotation symmetric bent functions*, [arXiv:1303.2282](https://arxiv.org/pdf/1303.2282) | Teorema 3.1, Proposição 3.2 e Observação 3.4 | Comparar exclusões esparsas com critérios SANF. A Proposição 3.2 trata suportes específicos, não uma exclusão universal de quaisquer três órbitas. A Observação 3.4 alerta contra identificar todas as órbitas monomiais por equivalência afim. |
| Sun–Shi–Liu–Fu, *On the conjecture about the nonexistence of homogeneous rotation symmetric bent functions*, DCC 94, artigo 93 (2026), [10.1007/s10623-026-01848-4](https://link.springer.com/article/10.1007/s10623-026-01848-4) | Resumo oficial; texto integral bloqueado por assinatura nesta consulta | Comparação obrigatória antes de alegar novidade nos resultados quinticos. O resumo anuncia exclusões parciais via SANF, derivadas e não linearidade; não permite decidir sozinho se o resultado esparso é novo. |

## Onde os resultados da v1 podem ajudar

### 1. Classificação, inclusive fora de Maiorana–McFarland

Polujan–Kudin–Pašalić, *Rotation-symmetric bent functions outside the completed Maiorana-McFarland class*, IEEE TIT 72(6), 4341–4351 (2026), DOI 10.1109/TIT.2026.3685133. O [resumo institucional](https://repozitorij.upr.si/Iskanje.php?lang=eng&niz0=Sadmir+Kudin&stl0=Avtor&type=napredno) relata classificação EA das cúbicas RS em dez variáveis e uma classe fora de M#. Também trata famílias de grau máximo e quárticas. Nesta consulta, a aplicação usa o resumo, não uma auditoria de todas as tabelas do artigo.

A regra da v1 aplica-se aos representantes RS cúbicos independentemente de pertencerem a M#. Assim, pode servir de verificação estrutural das listas e das novas construções: o coeficiente antipodal deve ser 1. Isto é uma consequência do nosso teorema, não um resultado atribuído aos autores citados. Não se deve exigir essa forma de um representante EA arbitrário que perdeu simetria de rotação.

### 2. Restrição diagonal explícita e normalidade fraca

**Dedução nesta nota, sem reivindicação de prioridade.** Seja n=2m, D={(u,u)} e f RS de grau no máximo 3. A meia-rotação emparelha os monômios da ANF. Em D, cada par tem avaliações iguais e cancela em característica 2. Um suporte não vazio fixo pela meia-rotação deve ser união de pares antipodais. Até grau 3, os únicos suportes possíveis são os pares de grau 2. Portanto, se a é o coeficiente de P_n,

    f(u,u) = f(0) + a * sum_i u_i.

Para f bent, a=1 pela v1. Logo D fornece explicitamente uma restrição afim não constante de dimensão n/2: um certificado de normalidade fraca no sentido usual. Acrescentar a forma linear sum_{i<m} x_i torna essa restrição constante e preserva bentness, mas pode perder a simetria de rotação.

Este certificado NÃO mostra que D é um M-subespaço. O critério de M-subespaço exige D_a D_b f(x)=0 para todo x ambiente e a,b em D, não somente para x em D. Essa distinção permite compatibilidade com exemplos fora de M#.

### 3. Busca e códigos de Reed–Muller

Fixar o bit antipodal em 1 reduz pela metade o espaço de coeficientes RS de grau ≤3 numa busca de construção que aceita o teorema. Retirar P_n de qualquer bent RS desse grau produz função não bent, por contraposição direta. Não aplicar esse filtro a uma experiência destinada a verificar a própria necessidade antipodal: isso seria circular.

Na interpretação padrão por cosets de RM(1,n), recordada por Canteaut–Charpin, bentness corresponde à distância máxima à classe das funções afins. A v1 fornece uma condição necessária aos representantes RS de grau ≤3 desses cosets extremos. O coeficiente quadrático não muda ao adicionar funções afins. Isso é uma restrição estrutural nessa subclasse, não uma nova cota de código nem uma alegação de segurança criptográfica.

## Família que não deve consumir busca por contraexemplos

**Dedução nossa a partir da primeira construção de Tang et al.; sem reivindicação de prioridade.** Escreva n=t*r, t par e r ímpar, m=n/2. Considere

    f(x)=P_n(x)+gamma(x_i+x_{i+m}: 0<=i<m).

Restrinja a x_i=y_{i mod t}. Como m equivale a t/2 módulo t, cada par antipodal em P_t aparece r vezes em P_n e, portanto, P_n restringe a P_t. O vetor de entradas de gamma é a repetição r vezes de

    (y_j+y_{j+t/2}: 0<=j<t/2).

Defina eta(v)=gamma(v repetido r vezes). A restrição é exatamente

    P_t(y)+eta(y_j+y_{j+t/2}: 0<=j<t/2),

que é bent pela mesma construção. O argumento vale para qualquer grau de gamma e não exige que eta mantenha o grau original. Logo esta família não produz contraexemplo à bentness da restrição por repetição ímpar. Isto não prova a transferência para toda função RS quártica. A segunda família do artigo não foi coberta por este argumento.

## Experiência exata quintica e limite de novidade

`search_quintic_sparse.py` enumera todas as somas de até três dentre as 273 órbitas monomiais quinticas distintas em n=16, incluindo a função zero: 3.391.298 candidatos. Nenhum satisfaz as condições necessárias de balanceamento de fibras. Bastam as fibras z=0x1, 0x11 e 0xff para excluir todos. O resultado detalhado e hashes estão em `quintic_sparse_support_2026-10-07.json`.

Além de testemunhas em cada grupo de rejeição, o programa compara os bitstrings das 35 fibras de cada um dos 273 geradores comprimidos com tabelas verdade completas, calculadas por implementação independente. Como a avaliação é linear nos coeficientes ANF, essa igualdade da base verifica a representação usada em toda a enumeração. Isso não é uma segunda enumeração independente de todos os candidatos.

A conclusão é uma exclusão computacional de suporte ≤3 em n=16. Não resolve os 2^273 candidatos, não prova não existência quintica geral e não foi certificada como inédita. Antes de publicação: concluir comparação com Sun et al. e demais critérios SANF; buscar explicação algébrica das poucas triplas que passam a primeira fibra.

## Próximas prioridades por ganho e custo

1. Formalizar a restrição diagonal como corolário separado da v2 e confrontar terminologia/prioridade de normalidade fraca.
2. Usar construções publicadas como controles positivos dos programas; preservar busca sem filtro antipodal para auditoria independente.
3. Estudar as 35 triplas que passam z=1 e obter certificados curtos para os dois filtros restantes.
4. Extrair uma família quártica efetivamente distinta antes de gastar GPU procurando falha de transferência.
5. Manter o n=12/A100 como experiência v2, sem custo/execução presumidos e sem condicionar a v1 a ela.

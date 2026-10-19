# Relatório de rigor e estado das entregas

## Identificação correta

Este trabalho é a V1 do preprint antipodal/cúbico, não a prova de H(12,4). A versão de base é o manuscrito v1.3 da branch de submissão de 15/10, mais recente que o PDF Figshare v1.0 de 06/10. Foram usados os registros efetivamente certificados, não apenas a data dos arquivos. As versões históricas continuam preservadas.

## Afirmações preservadas

- Teorema universal: n>0 par; f RS bent; grau≤3; coeficiente antipodal 1.
- Corolário: nenhuma homogênea cúbica RS bent em qualquer dimensão positiva par.
- Ausência de enumeração como premissa essencial da prova.
- Definição por coeficiente ANF canônico e condição convencional de módulo Walsh.
- Rota global por meia-volta e repetição; folding geral fora da cadeia.

## Mudanças demonstradas e classificação

**A, completamente demonstrada:** prova alternativa do equilíbrio sob ordem ímpar por radical e média; passagem direta de polar zero para afinidade; apresentação conjunta da contradição da fibra; uso direto de W_g(b,b) na análise das fibras. Essas mudanças podem substituir a exposição anterior matematicamente. A classe A não significa que uma nova derivação tenha sido compilada em Lean.

**Não implementado como certificado novo:** formalização específica da prova alternativa do radical. O teorema original, de mesmo enunciado, permanece certificado na fonte fixa.

**Rejeitadas:** extensão automática a grau quatro; remoção de diagonal constante no equilíbrio de fibras; equivalência entre “grau três” e “homogênea cúbica”; generalização do resultado quártico de 12 variáveis a outras dimensões; declarar folding geral separadamente certificado.

## Verificação adversarial

Foram examinados todos os quantificadores e casos n=2, espaço fixo zero, polar degenerado, constantes, termos lineares, m=1 e ciclos curtos. Não foi encontrada lacuna matemática na cadeia da versão simplificada. Essa conclusão é uma revisão interna, não um teorema de correção do manuscrito e não arbitragem externa.

Verificações executadas nesta tarefa:

- Identidade da árvore `formalization/` à fonte `6dd1836...`: PASS.
- Dois estados CI históricos e commits: reconferidos na API GitHub, ambos success.
- Leitura das definições e interfaces finais: realizada.
- Scan preservado de atalhos de prova: executado e registrado separadamente.
- 2.196 formas quadráticas de dimensões 1 a 4: identidade de Gauss exata.
- 40 quadráticas invariantes sob uma ação de ordem três, com conjugação linear não trivial: transferência conferida, incluindo 16 casos equilibrados.
- 256 funções em três variáveis: equivalência entre polar zero e afinidade conferida.
- Compilação real dos dois documentos TeX: concluída; sem caixas excedendo margens e sem referências indefinidas.
- Novo build Lean integral: NÃO executado nesta tarefa; não seria proporcional refazer a carga histórica apenas por mudança editorial. A demonstração alternativa continua sem script próprio certificado.

Veja `EDITORIAL_CHECKS.json`, logs de compilação, `PARECER_DO_REVISOR_SIMULADO.md` e `CERTIFICACAO_E_REPRODUCAO.md`. Os testes pequenos não justificam os quantificadores universais; o texto demonstra esses passos.

## Literatura

Foram reconferidas as fontes primárias de Cusick–Sanger e Zhang–Gao via arXiv e os registros existentes de leitura de Sun. O PDF local de Sun permanece disponível; este trabalho não reivindica uma nova auditoria exaustiva de todo o campo em 2026. As comparações em nível de teorema da revisão anterior ficam preservadas na referência v1.3. Foram removidos do fluxo principal catálogos laterais que não são necessários à prova. Não há certificado de ineditismo absoluto.

## Entregas

Artigo inglês completo de cinco páginas e apêndice inglês de três páginas, ambos com fontes compiláveis. Os seis relatórios exigidos acompanham os PDFs. As provas formais, dependências fixadas e verificadores históricos estão na mesma branch herdada; não foram substituídos ou enfraquecidos.

Não foi feita submissão a periódico, arXiv ou Figshare. O versionamento ocorre exclusivamente em branch editorial isolada, sem merge em main. As execuções GitHub de H(12,4) e suas chaves de cache permanecem intactas.

## Resposta à pergunta central

A demonstração humana mais curta obtida nesta revisão é a prova estrutural do artigo de cinco páginas: a fórmula de Gauss unifica o controle das quadráticas; média no radical transfere equilíbrio; nilpotência cíclica fornece rigidez; Parseval e a identidade trilinear produzem a contradição em uma única fibra; meia-volta e repetição concluem todas as dimensões pares. Não se afirma minimalidade absoluta entre todas as provas possíveis.

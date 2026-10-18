# Estado do checkpoint: kernel e cobertura

Todos os 164.288 testemunhos de rejeição de Walsh passaram na compilação e na reprodução independente pelo kernel Lean. A rejeição parte da tabela verdade da função quártica original. Os 41 módulos de dados e o agregador estão em `H12WitnessCertificate`.

A auditoria `reports/LEAN_CHECKPOINT_COVERAGE.json` confere as fontes e os registros de 147 módulos: 28 módulos principais, 42 de testemunhos e 77 de extensões e pilotos. O número de módulos inclui implementações alternativas dos mesmos trechos; não representa 147 partes disjuntas da busca.

O maior ramo conectado instanciado possui 21 nós, 121 transições e 32 candidatos nas folhas. As versões com sistemas completos e com equações fixas passaram no kernel. Os pilotos se sobrepõem: suas contagens não podem ser somadas. A quarta carta, já incompatível com um filtro necessário, também recebeu uma refutação completa ligada às definições originais.

A prova global em Lean permanece pendente. `H12AffineState.no_bent_of_affine_state_refutations` exige explicitamente as refutações das três cartas necessárias. Nenhuma dessas hipóteses foi ocultada ou substituída pelos pilotos.

A nova implementação conserva as equações quadráticas da raiz e transforma um ambiente de 36 formas afins. As identidades de composição, as eliminações, as divisões em dois ramos, a passagem aos coeficientes originais e a rejeição das folhas estão provadas genericamente. Os candidatos das folhas usam os testemunhos já certificados, sem repetir as transformadas completas.

Próxima etapa: gerar e verificar, em blocos retomáveis, a carta de índice 2 (caso 8), que contém 70.976 candidatos conhecidos. A geração dos fontes não será tratada como prova. Cada módulo deverá passar pela compilação e pelo kernel; o teorema da raiz só poderá ser usado após a conclusão de todos os blocos.

Para conferir os registros deste checkpoint: `python tools/audit_lean_checkpoint.py`. Para repetir as provas, usar os verificadores Lean e as bibliotecas opcionais indicadas nos relatórios. O pacote anterior permanece preservado; o novo pacote terá seu próprio manifesto.

As avaliações bibliográficas estão em `KHOLOSHA_PAL_REVIEW.md` e `ZHANG_APPENDIX_REVIEW.md`. A autodualidade e a fórmula de Poisson não bastam para deduzir impossibilidade a partir de grau restrito menor ou igual a dois. Os controles positivos propostos são úteis, mas sua aprovação não prova ausência universal de falsos negativos. Não foram realizados novos testes CUDA nesta etapa.

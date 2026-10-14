# Entrega V2 — material para revisão pelo Gemini

Data: 14/10/2026. Status: EM AUDITORIA; não é aprovação para publicação.

## Comece aqui
- [Pacote original ZIP](ENTREGA_PESQUISA_V2_2026-10-14.zip)
- [PDF original](NOVO_TEOREMA_V2.pdf)
- [Fonte TeX](NOVO_TEOREMA_V2.tex)
- [Relatório original](RELATORIO_FINAL.md)
- [Certificados](CERTIFICADOS_V2/)
- [Acervo V1, V2 e V3-C](../../README.md)

Os 31 arquivos do ZIP foram preservados byte a byte. O manifesto lista 30 arquivos, além do próprio manifesto. Os três scripts Python foram executados nesta revisão sem falhas. Isso não certifica automaticamente os teoremas globais.

## Erro confirmado no Teorema 1.1
A fórmula do radical omite os blocos com u_i=0. A expressão correta é:
Rad_Phi(u) = soma direta das linhas F2 u_i para u_i != 0, mais soma direta dos blocos V_i para u_i=0.
Se s é o número de blocos não nulos, dim Rad_Phi(u)=8r-7s.
Para r=2 e u=(a,0), a!=0, a dimensão é 9, não 1. Para u=0, o radical é V.
A prova de recuperação de blocos e a etapa da decomposição que a invoca precisam ser reconstruídas. Isto não prova que as conclusões finais sejam falsas.

## Pendências de validação
1. Reconstruir a recuperação intrínseca dos blocos e rever todas as dependências.
2. Reparar a prova de decomposição EA contra fatores arbitrários.
3. Entregar verificação independente de Burnside: construir a ação quadrática e calcular postos sobre F2, sem reutilizar como oráculo as fórmulas propostas. Não localizamos nos scripts entregues a alegada comparação em matrizes 240x240/828x828 e nas 540 combinações.
4. O arquivo Lean não foi compilado nesta revisão. LocalSeedCertificate assume as ordens 1920/40 e a rigidez local; não há construção de certificado concreto dessas hipóteses no módulo. Compilar não equivale a provar integralmente os cinco teoremas.
5. Rever as cotas e os restos assintóticos com provas uniformes; exemplos finitos não demonstram limites assintóticos.
6. Conferir originalidade com a literatura e integrar somente resultados demonstrados.

## Evidência adicional desta revisão
Reproduzidos: ordens 1920 e 40, 211 quárticas RS bent-completáveis, contagens dos scripts.
Verificação adicional sobre as matrizes reconstruídas: C3 comuta com P5 e com todo K_Y^0; K_Y^0 tem 16 elementos; delta3 é aditiva em todos os pares de K_Y^0.
Estas verificações são finitas e não substituem as demonstrações globais.

## Missão para o Gemini
Leia os arquivos completos, ataque os enunciados com contraexemplos, corrija as provas e entregue código independente, logs reais e mapa de dependências. Separe demonstrado, certificado finito, conjectural e não testado. Não repita as alegações de rigor máximo dos relatórios originais sem auditoria.

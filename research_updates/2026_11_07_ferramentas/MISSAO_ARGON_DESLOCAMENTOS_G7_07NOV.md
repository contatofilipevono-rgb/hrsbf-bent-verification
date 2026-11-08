# Missão Argon — mapear exatamente a falha do Teorema 4.2

**Atualização antes da entrega:** Codex já gerou o catálogo dos 6.561 casos: 6.201 solúveis em G7 e 360 insolúveis, todos distintos. Arquivos CATALOGO_DESLOCAMENTOS_G7_07NOV.json.zlib, CATALOGO_DESLOCAMENTOS_G7_07NOV_RESUMO.json e catalogo_deslocamentos_g7_07nov.py. Priorize agora um verificador INDEPENDENTE desses dados (sem importar o código do gerador), seguido da Etapa 3 para tentar encontrar uma regra. Não gastar tempo repetindo a mesma implementação. As etapas abaixo especificam a família e a cobertura que devem ser auditadas. A pergunta universal já foi refutada; não tentar prová-la.

O Teorema 4.2 da entrega anterior é FALSO. Não tente salvar o enunciado original por uma prova nova. Astra encontrou um contraexemplo exato em S_span, com gamma2(Delta)=0 e G7 insolúvel; Codex verificou o certificado de nove equações e o levantamento inteiro. Sua tarefa é descobrir, por um catálogo finito completo, quais deslocamentos criam ou eliminam essa obstrução.

## Dados obrigatórios

Na pasta C:/Users/Valer/Documents/Codex/2026-11-02/fa/outputs, leia:
- ASTRA_CONTRAEXEMPLO_G7_SSPAN_07NOV.json;
- CONTROLE_CODEX_CONTRAEXEMPLO_ASTRA_G7_07NOV.json;
- PARECER_CODEX_ARGON_DUAS_FORMAS_07NOV.md;
- CADERNO_TECNICAS_BENT.md, técnicas 31–32;
- audita_argon_duas_formas.py e checa_contraexemplo_astra_g7.py.

Não modificar os originais. Pasta nova: outputs/argon_deslocamentos_g7_v3. Esta missão tem prioridade sobre MISSAO_ARGON_CATALOGO_GRAU7_VERIFICAVEL_07NOV.md.

## Família completamente delimitada

Em dez variáveis, ordem x1,x2,y1,...,y8, mantenha fixos do contraexemplo:

    A0=[40,132,320,528]
    B0=[20,40,132,384,520]
    Omega_res=[72,80,144].

Uma máscara representa um monômio exterior pelos bits ligados. Verifique, sem presumir, A0 wedge B0 wedge Omega_res=0.

Varie u1,u2,v1,v2, cada um no conjunto {0,y1,...,y8}; são exatamente 9^4=6.561 quádruplas. Construa

    At=A0+x1 wedge v1+x2 wedge v2;
    Bt=B0+x1 wedge u1+x2 wedge u2;
    Delta=At wedge Bt+x1 wedge x2 wedge Omega_res.

Confirme gamma2(Delta)=0 para cada instância. Reconstrua Phi1,Phi2 e Omega CANÔNICOS, sem confundir Omega com Omega_res. A relação é Omega=Omega_res+v1 wedge u2+v2 wedge u1.

## Etapa 1 — controles que precisam passar antes do catálogo

1. Reproduzir o contraexemplo com u1=y8,u2=0,v1=y6,v2=y4. Seu G7 deve ser INSOLÚVEL e o certificado de nove linhas deve passar.
2. Testar o caso com os quatro deslocamentos zero; não presumir o resultado.
3. Conferir as equações por dois caminhos: pares de monômios e tabela de verdade seguida de Möbius inteiro.
4. Incluir o erro antigo como teste negativo: P=abcd,Omega=ae invalida a identidade com sigma1. Seu verificador deve rejeitar essa identidade.

## Etapa 2 — decidir G7 completo em TODOS os 6.561 casos

Monte o sistema linear Delta wedge R3=tau1(Delta), com TODAS as 120 incógnitas cúbicas de dez variáveis. Não restrinja R3 ao span das duas quadráticas.

Para casos solúveis, grave uma solução particular. Para casos insolúveis, grave um certificado dual que soma equações a 0=1. Permita compressão e compartilhamento de certificados, conservando uma associação verificável de cada instância ao seu certificado.

O verificador final deve reconstruir o sistema e conferir as testemunhas/certificados sem chamar o solver usado para encontrá-los. Registre separadamente tamanho da família de parâmetros e número de Delta distintos; quádruplas diferentes podem produzir o mesmo objeto.

Estime custo antes de rodar. Teste 16 casos e meça. Se a previsão for excessiva, preserve o piloto e entregue a estimativa; não substitua enumeração completa por amostra sem dizer. Não use GPU nem instalações.

## Etapa 3 — extrair uma regra verificável

Compare os casos solúveis e insolúveis por postos das três polares modificadas, dependência dos quatro deslocamentos e suas classes no radical. Primeiro teste se os invariantes separam os resultados. Se dois casos com mesmos invariantes derem respostas diferentes, entregue o par explícito: isso refuta a regra proposta.

Não apresente uma tabela como teorema universal fora desta família. Se sugerir um enunciado corrigido, escreva as hipóteses exatas e marque CONJECTURA até existir prova. Solução de G7 não é I6: não declare que G6 ou I7 foram satisfeitos.

## Entregáveis

LEIA_PRIMEIRO.md (até vinte linhas); CATALOGO.json com cobertura real; CERTIFICADOS.json; verificar_catalogo_sem_solver.py; resultados da comparação dos dois caminhos; e UMA hipótese corrigida ou um contraexemplo a uma hipótese tentadora.

Pontos de atenção: conferir combinações de geradores, não só geradores individuais; em famílias quadráticas conferir também todos os termos cruzados; não tratar timeout como insolubilidade; não remover controles para obter PASSOU; não publicar nem alterar fontes; sem reivindicação de novidade. Esta missão não resolve Q1 nem p17.

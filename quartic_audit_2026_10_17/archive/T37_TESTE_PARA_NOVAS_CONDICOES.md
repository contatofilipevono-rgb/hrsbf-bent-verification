# T37: um teste que encontra informação além das nove condições

## Resultado concreto

Foi identificada uma condição necessária que **não é consequência das nove anteriores**. Ela vem do suporte de peso 12 `u=0x33ff`:

`h_f(0x33ff)/8 ≡ 0 (mod 2)`.

Bentness exige a condição mais forte `h_f(0x33ff) ≡ 0 (mod 32)`. Aqui usamos apenas seu primeiro bit para obter um polinômio cúbico de 4.748 monômios após as três leis lineares. O critério de divisibilidade é clássico; o avanço deste teste é demonstrar informação adicional sobre os candidatos que já passam nos nove filtros.

## Testemunha exata

A palavra de coeficientes

`0x18649e30a3513dbc1231f902c2da`

passa nas três leis lineares, nas condições quarta e quinta e nos quatro testes periódicos de peso 12. Os valores inteiros nesses quatro suportes são:

| suporte | h_f |
|---|---:|
| 0x3f3f | −96 |
| 0x5f5f | −288 |
| 0x6f6f | −160 |
| 0x7777 | −288 |

Todos são divisíveis por 32. Porém `h_f(0x33ff)=−120`, que não é divisível por 16 nem por 32. Portanto a nova condição rejeita uma função aprovada nas nove anteriores. Essa é uma prova de não implicação, não uma inferência estatística.

A mesma função também viola uma condição de peso 11 no suporte 0x5e9f: seu valor inteiro é 168, não divisível por 16.

## Teste de descoberta e validação

Foram geradas 512 funções que satisfazem os nove filtros. As primeiras 256 serviram para selecionar alternativas; as outras 256 ficaram reservadas para validação.

| alternativa | descoberta: rejeitadas em 256 | validação: rejeitadas em 256 |
|---|---:|---:|
| suporte 0x33ff, polinômio menor | 139 | 129 |
| suporte 0x5e9f, maior rejeição na descoberta | 151 | 122 |

A condição 0x33ff é a opção inicial mais simples entre as obstruções não nulas testadas com uma testemunha adicional: tem 4.748 monômios, contra 24.908 na outra alternativa. A separação descoberta/validação também evita apresentar o melhor resultado selecionado como se tivesse sido confirmado na mesma proporção.

Cada uma das 512 funções falhou em pelo menos uma das 389 obstruções. **Essas contagens não são taxas globais**, não provam rejeição de todos os candidatos e não alteram o limite global certificado de T35.

## Verificação e próximo experimento

`VERIFICAR_NOVA_CONDICAO_T37.py` reconstrói todas as 5.775 partições do suporte em três quartetos, aplica as três leis lineares e confere o polinômio completo. Também reconstrói a função testemunha pelos monômios originais e calcula diretamente os seis coeficientes inteiros usados acima. Usa apenas Python padrão e os certificados da mesma pasta.

O próximo passo útil é simplificar a condição 0x33ff sob a forma normal T34 e incorporá-la à análise conjunta. Só uma prova do efeito global dessa combinação permitiria anunciar um percentual de exclusão melhor. Repetir apenas amostras maiores não substitui essa etapa.

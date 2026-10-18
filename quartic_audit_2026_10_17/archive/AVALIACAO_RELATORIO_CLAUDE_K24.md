# Avaliação do relatório do Claude: auditoria, k=24 e proposta espectral

O relatório sustenta um avanço computacional individual, sujeito à entrega do certificado correspondente. Ele não contém uma prova de inexistência de bent em H(16,4). A conclusão de incompatibilidade global não está demonstrada.

## Pontos corretos

- A fração T40 e a correção do arredondamento estão corretas. A apresentação segura é exclusão de pelo menos 99,94316569188364%.
- O lema de diferenças finitas é válido quando as diferenças nas direções consideradas são quadráticas. A identidade de translação das diferenças justifica a extensão da base para o subespaço inteiro; não é necessário pressupor que o polinômio original inteiro seja cúbico.
- O piso da cota por valores absolutos dos 127 caracteres é 3/16384 de passagem global. Isso limita essa forma de certificado, sem impor um piso à densidade verdadeira dos sobreviventes. O máximo de exclusão certificável nessa forma é 99,981689453125%.
- A contagem de frequências periódicas está correta: 2 órbitas de período 1, 1 de período 2, 3 de período 4 e 30 de período 8. Uma enumeração local independente confirmou as 36. Há outras 4080 órbitas de período 16.
- Também há exatamente 1652 órbitas de suportes próprios com peso pelo menos 9. O suporte completo exige tratamento separado.

## O que falta no resultado k=24

O histograma relatado é compatível com uma amplitude próxima de 2^-12. Para incorporar esse resultado à cota global, são necessários a base das 24 direções, os índices do bloco principal, o modelo do polinômio, o histograma completo, a identificação de qualquer condicionamento e a aritmética exata da cota.

Em particular, o caso do ramo c99=0 e caráter 11 foi anteriormente tratado em fibras condicionadas em c57. O relatório precisa identificar a fibra efetivamente executada ou demonstrar cobertura de ambas. Um resultado de uma fibra não substitui automaticamente a média do caráter no ramo inteiro.

O posto mínimo 48 sozinho fornece beta ao quadrado menor ou igual a 2^-24 + (1-2^-24)2^-24, cuja raiz é aproximadamente 3,45e-4. A amplitude mais forte relatada, aproximadamente 2,45e-4, depende do histograma completo, não apenas do mínimo. A parte superior do histograma não foi fornecida no texto.

## Lacunas na proposta de prova global

1. Uma matriz com 116 colunas tem posto no máximo 116. Uma prova de incompatibilidade linear exige posto da matriz aumentada maior que o da matriz de coeficientes. Além disso, seria necessário demonstrar uma redução linear equivalente: as condições de Walsh e as contagens não são automaticamente lineares nos 116 coeficientes.

2. Os 11 parâmetros agregados não determinam uma função do núcleo. A parametrização contém fibras de dimensão 102. Qualquer redução a esses parâmetros precisa controlar a dependência nas coordenadas restantes.

3. A forma W(u)=K_u(a,b)-32w(u), com um único contador não ponderado, não foi justificada para as 36 frequências. A identidade geral correta é

   W_f(u) = soma_O C_O(u)(1-2y_O),
   C_O(u) = soma_{x em O} (-1)^(u·x),

   em que O percorre as órbitas de entradas e y_O=f(x) é constante em O. Os pesos C_O(u) variam. As simplificações especiais de u=0 e u=1^16 não se transferem automaticamente às outras frequências.

4. Zero sobreviventes numa amostra, sem tamanho e protocolo declarados, não implica zero sobreviventes no espaço inteiro. O resultado deve ser relatado como observação amostral.

5. As 36 condições de amplitude são necessárias. Sua incompatibilidade com H(16,4) ainda precisa ser demonstrada. Não há resultado UNSAT, certificado de prova ou evidência para o prazo de segundos no relatório.

## Encaminhamento

Vale testar primeiro a combinação exata de W(0) e W(1^16), usando os mesmos valores de f nas órbitas e contadores separados por paridade do peso das entradas. Depois, acrescentar frequências com pesos orbitais corretos e medir o ganho incremental. Um resultado SAT fornece candidatos para novos filtros; timeout é inconclusivo; UNSAT requer verificação apropriada antes de se declarar inexistência.

O melhor limite local já verificado permanece o T47: exclusão de pelo menos 99,96808978000678%. O T49, com uma condição adicional, é candidato a uma melhoria e ainda depende de verificação independente. A inexistência global em H(16,4) permanece aberta neste trabalho.

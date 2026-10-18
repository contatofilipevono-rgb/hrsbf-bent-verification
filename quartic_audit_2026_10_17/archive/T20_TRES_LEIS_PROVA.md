# As três leis de T20 por congruências de Walsh

17/10/2026. Esta nota completa a demonstração das três condições lineares registradas em T20. A prova combina argumentos teóricos com certificados finitos de identidades numa base completa; não depende da varredura A100. A novidade bibliográfica ainda deve ser estabelecida.

## Enunciado

Para uma bent f∈H(16,4), na numeração de órbitas do pacote:

1. c115=0;
2. c57+c113=0;
3. Σ_{j∈S}c_j=0, onde

S={0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,99,106,115}.

Os três vínculos são independentes e deixam exatamente 2¹¹³ das 2¹¹⁶ palavras de coeficientes como candidatas. Assim, excluem 7/8 do espaço por condições necessárias. Não demonstram inexistência no restante.

As primeiras duas condições e a divisibilidade 64 | A₀ foram provadas em `T20_DUAS_LEIS_PROVA.md`, com A_z=Σ_u(−1)^{f(u,u+z)}. A novidade desta nota é a explicação da terceira condição.

## 1. Dois códigos de valores nas órbitas

Há 4.080 órbitas de entradas de período completo 16. As demais entradas, exatamente 256, são os vetores (u,u). Escolha uma representante por órbita completa e seja v_f∈F₂⁴⁰⁸⁰ o vetor dos valores de f nessas representantes.

A fibra complementar (u,u+1) tem 16 órbitas, todas de tamanho 16, sob a rotação. Seja z_f∈F₂¹⁶ seu vetor de valores nas representantes. Para os 116 geradores G_j, os vetores v_j e z_j satisfazem:

- seus pesos são pares;
- |supp(v_j)∩supp(v_k)| e |supp(z_j)∩supp(z_k)| são pares para j≠k;
- wt(v_j)≡wt(z_j) mod 4.

Essas identidades constam em `global_orbit_certificate.json`. O verificador independente reconstrói as 4.080 órbitas, os 116 geradores e todos os produtos internos necessários. Nenhuma função candidata é amostrada para estabelecer essas identidades.

Para qualquer combinação f=Σ_jc_jG_j, a expansão inteira do XOR dá

wt(Σ_jc_jv_j)≡Σ_jc_jwt(v_j)−2Σ_{j<k}c_jc_k|supp(v_j)∩supp(v_k)| mod 4.

Os termos de interseção são pares e desaparecem módulo quatro. A mesma identidade vale para z. Portanto,

\[
\operatorname{wt}(v_f)\equiv\operatorname{wt}(z_f)\pmod4.
\]

## 2. Uma congruência universal

Agrupar a soma de Walsh pelas órbitas completas e pelas entradas diagonais fornece

W_f(0)=A₀+16(4080−2wt(v_f)),

enquanto A255=16(16−2wt(z_f)). Logo

W_f(0)−A₀−A255=65024−32[wt(v_f)−wt(z_f)].

Como 128 divide 65024, a congruência dos pesos implica

\[
\boxed{W_f(0)\equiv A_0+A_{255}\pmod{128}.}
\]

Ela vale para **toda** quártica homogênea RS em 16 variáveis, não apenas para eventuais bent.

## 3. Identificação da terceira lei

O código dos z_j é auto-ortogonal e possui pesos pares. Assim,

A255/64 ≡ wt(z_f)/2 ≡ Σ_j c_j wt(z_j)/2 mod 2.

Os geradores com wt(z_j)/2 ímpar são exatamente

L={0,4,8,14,18,22,42,46,52,56,71,81,85,94,98,106}.

Após as duas primeiras leis, escreva a=c57=c113 e b=c99. A soma da forma quadrática diagonal é

| a | b | A₀ |
|---:|---:|---:|
| 0 | 0 | 256 |
| 0 | 1 | 64 |
| 1 | 0 | 128 |
| 1 | 1 | −64 |

Portanto A₀/64≡b mod 2. Se f é bent, W_f(0)=±256 e é divisível por 128. Pela congruência universal,

0≡(A₀+A255)/64≡c99+Σ_{j∈L}c_j mod 2.

Isso é a terceira lei de T20 após c115=0. Acrescentar c115 ao suporte não altera a condição. A independência dos três vínculos é imediata, por exemplo pelas coordenadas 115, 113 e 0. ∎

## Verificação e alcance

`VERIFICAR_TERCEIRA_LEI_T20.py` utiliza somente Python padrão. Ele confere a base, a auto-ortogonalidade, a transferência de pesos módulo quatro e os quatro casos diagonais. O arquivo `T20_TRES_LEIS_VERIFICACAO.json` registra o resultado.

O certificado é finito, mas cobre a base inteira e os produtos internos; a extensão a todas as 2¹¹⁶ funções decorre das identidades algébricas acima. Não é apenas evidência estatística. Ainda não há uma formalização em Lean nem uma prova da inexistência global. A originalidade do enunciado ou da demonstração não foi reivindicada.

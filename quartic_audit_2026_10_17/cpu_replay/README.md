# Certificado global de cobertura afim e rejeições de Walsh

O verificador completo usa somente Python padrão. A partir deste diretório:

```sh
python verify_model.py
python verify_certificate.py
```

`verify_certificate.py` verifica a cobertura algébrica dos quatro sistemas necessários e todos os 164.288 testemunhos, sem percorrer os 2^38 candidatos e sem GPU. Nesta máquina levou aproximadamente 70 segundos. O relatório é `SYMBOLIC_CERTIFICATE_AUDIT.json`. A justificação das condições necessárias está em `../MATHEMATICAL_EXPLANATION.md`.

## Dados

| Caso periódico | Zeros dos filtros | Passam W(0) | Bent |
|---:|---:|---:|---:|
| 2 | 46.912 | 1.980 | 0 |
| 3 | 46.400 | 492 | 0 |
| 8 | 70.976 | 836 | 0 |
| 15 | 0 | 0 | 0 |
| Total | 164.288 | 3.308 | 0 |

As contagens diferem das 949.760/15.779 da GPU porque aqui já são impostas condições necessárias adicionais de período quatro. Não se trata da antiga busca condicionada por cinco leis.

- `DECOMPOSITION.json`: árvore de 67.658 nós e seus testemunhos de combinações polinomiais.
- `full_thread*.csv`: todos os zeros dos filtros nos quatro sistemas, com uma frequência que rejeita bentness.
- `verify_certificate.py`: cobertura simbólica e conferência independente de cada rejeição pela ANF original.
- `verify_model.py`: confere postos afins, substituições exatas e todas as constantes do programa C.
- `FULL_AUDIT.json` e `FULL_PORTABLE_AUDIT.json`: auditorias completas de duas execuções em CPU.
- `replay.c`: código C com caminhos Windows e POSIX. O caminho Windows foi executado; a versão POSIX ainda precisa ser compilada e executada em Linux.
- `generate_model.py`: gera o modelo a partir dos geradores e dos certificados lineares preservados.
- `model.json`, `model_data.h`: dados explícitos das quatro bases afins e filtros.
- `CASE15_IDENTITY.json`: a quarta raiz é contraditória por um único filtro após a substituição.

## Repetir a varredura em CPU

Requer GCC/Clang, suporte a threads e instruções de popcount, quando selecionadas pelo compilador. Em Linux, a configuração proposta, ainda não testada nesta máquina, é:

```sh
cc -O3 -march=native -pthread replay.c -o replay
./replay 20 4 pilot > pilot.log
python verify_replay.py pilot
./replay 30 8 repeated > repeated.log
python verify_replay.py repeated --require-full --out repeated_audit.json
```

O primeiro argumento é o número de bits altos percorridos. **Somente 30 cobre integralmente os quatro sistemas.** O segundo é o número de threads, de 1 a 32. O terceiro é o prefixo dos arquivos. Cada execução faz 8.192 controles de pontos afins e atualizações Gray antes de iniciar a varredura. Erros de criação de threads e escrita são tratados como falha.

Em Windows, o compilador `leanc` da distribuição Lean 4.35.0 foi usado:

```text
leanc -O3 -march=native replay.c -o replay.exe
replay.exe 30 8 repeated > repeated.log
```

O certificado simbólico não depende de repetir essa compilação. Sua lista de testemunhos é conferida diretamente pelo Python. O verificador global ainda não foi formalizado no Lean: não confundir esses relatórios com um teorema Lean completo de inexistência.

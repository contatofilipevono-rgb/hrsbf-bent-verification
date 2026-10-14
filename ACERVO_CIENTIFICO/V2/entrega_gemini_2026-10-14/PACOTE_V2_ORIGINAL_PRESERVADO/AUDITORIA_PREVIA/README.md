# Reprodução independente dos controles da V2

Este pacote inclui um parecer técnico, um verificador de espectros da contração
C_phi e um enumerador exaustivo dos completamentos bent RS de grau inferior
em oito variáveis. O código foi gerado independentemente do repositório V2,
com base nas fórmulas do adendo informado pelo usuário.

## Dependências

```bash
python -m pip install numpy numba
```

## Execução

```bash
python verificar_contracoes.py
python enumerar_completamentos_bent.py
```

A segunda rotina utiliza compilação JIT e pode levar um tempo adicional
na primeira execução. Os ensaios não substituem uma formalização integral
em Lean 4 nem certificam o teorema de ultra-rigidez.

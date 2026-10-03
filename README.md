# 🔬 Resolução da Conjectura de Stănică–Maitra para HRSBF Cúbicas ($n \not\equiv 0 \pmod{32}$)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/HRSBF_Auditoria_Colab.ipynb)

Este repositório contém os artefatos de **auditoria matemática e computacional reproduzível** que demonstram a não-existência incondicional de Funções Bent Homogêneas Simétricas por Rotação (HRSBF) de grau 3 para todas as dimensões pares $n \not\equiv 0 \pmod{32}$ ($n \in \{2m, 4m, 8m, 16m\}$, para todo $m \ge 1$ ímpar).

---

## 🚀 Como Executar no Google Colab (1 Clique)

Para auditar e executar todas as verificações computacionais sem instalar nada em seu computador, basta clicar no botão abaixo:

👉 **[ABRIR NOTEBOOK NO GOOGLE COLAB](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/HRSBF_Auditoria_Colab.ipynb)**

No Google Colab:
1. Vá no menu **Ambiente de execução** (Runtime);
2. Clique em **Executar tudo** (Run all) ou pressione `Ctrl + F9`.
3. Todas as 136.697 condições de divisibilidade de Ward, matrizes de transferência analíticas e checagens exaustivas serão auditadas em segundos.

---

## 📁 Estrutura dos Arquivos

| Arquivo | Descrição |
|:---|:---|
| **[`HRSBF_Auditoria_Colab.ipynb`](HRSBF_Auditoria_Colab.ipynb)** | Caderno Jupyter interativo pronto para o Google Colab com explicações e código executável. |
| **[`verificador_standalone.py`](verificador_standalone.py)** | Verificador em **100% Python padrão** (zero dependências externas), executa as 136.697 checagens em < 1 segundo. |
| **[`verificador_hrsbf.py`](verificador_hrsbf.py)** | Verificador acelerado por vetorização NumPy (inclui busca exaustiva por Gray-code e FWHT). |
| **[`dossie_completo_auditoria_hrsbf.md`](dossie_completo_auditoria_hrsbf.md)** | Dossiê formal unificado de auditoria com todas as demonstrações algébricas detalhadas. |
| **[`paper_hrsbf.tex`](paper_hrsbf.tex)** | Manuscrito científico completo em formato LaTeX. |
| **[`supplementary_material.tex`](supplementary_material.tex)** | Material suplementar formal em formato LaTeX. |

---

## 💻 Como Executar Localmente

### Opção 1: Verificador Standalone (Zero Dependências)
Requer apenas Python >= 3.10 padrão:
```bash
python verificador_standalone.py
```
*Tempo de execução típico:* ~0,98 segundos.

### Opção 2: Verificador com NumPy
Requer Python >= 3.10 e NumPy:
```bash
python verificador_hrsbf.py
```
*Tempo de execução típico:* ~35 segundos.

---

## 📊 Resumo dos Resultados Computacionais

* **Teorema de Ward ($t=16$, 43 geradores):**  
  $\binom{43}{1} + \binom{43}{2} + \binom{43}{3} + \binom{43}{4} = 43 + 903 + 12.341 + 123.410 = \mathbf{136.697}$ condições testadas sobre os 4.080 representantes de órbitas de $\mathbb{F}_2^{16} \setminus V_8$.  
  **Resultado:** **0 falhas**. Logo, $\mathrm{wt}(g) \equiv 0 \pmod{256} \implies W_g(0) \equiv 0 \pmod{512} \ne \pm 256$ (bent impossível).
* **Bases Finitas $t \in \{2, 4, 8\}$:**  
  Todas as funções no span satisfazem $W_g(0) \ne \pm 2^{t/2}$ (**0 bent**).
* **Fronteira Estrutural em $t = 32$:**  
  A matriz de transferência para a órbita elementar $H(x) = \sum_{i=0}^{31} x_i x_{i+1} x_{i+2}$ fornece $W_H(0) = 85.032.960$, $\mathrm{wt}(H) = 2.104.967.168$, resultando em $\mathrm{wt}(H)/32 \equiv \mathbf{512} \pmod{2048}$. Como o resto é não-nulo ($512 \ne 0$), a extensão direta de Ward cessa em $t = 16$.

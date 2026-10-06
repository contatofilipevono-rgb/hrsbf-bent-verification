# 🔬 Inexistência de Funções Bent Homogêneas Simétricas por Rotação Cúbicas para $v_2(n) \le 4$
## Resolução da Conjectura de Stănică–Maitra em Dimensões Pares $n \not\equiv 0 \pmod{32}$ e Certificados de Obstrução em $t=32$

Este repositório contém os artefatos de **auditoria matemática e computacional reproduzível** que demonstram a não-existência de Funções Bent Homogêneas Simétricas por Rotação (HRSBF) de grau 3 para todas as dimensões pares com $v_2(n) \le 4$, ou seja, $n \not\equiv 0 \pmod{32}$ ($n \in \{2m, 4m, 8m, 16m\}$, para todo $m \ge 1$ ímpar), bem como certificados exatos de obstrução algébrica em $t=32$ variáveis.

---

## 🚀 Como Executar no Google Colab (1 Clique)

Disponibilizamos dois cadernos Jupyter prontos para execução em nuvem no Google Colab com zero instalação local:

### 1. Auditoria Principal ($n \not\equiv 0 \pmod{32}$ e Fronteiras Finitas)
Audita as 136.697 condições de divisibilidade de Ward, bases de $t \in \{2, 4, 8, 16\}$, controles positivos de $n=12$ e o limiar de transferência analítica:

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/HRSBF_Auditoria_Colab.ipynb)  
👉 **[ABRIR NOTEBOOK PRINCIPAL NO GOOGLE COLAB](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/HRSBF_Auditoria_Colab.ipynb)**

### 2. Certificados de Obstrução em $t = 32$ Variáveis (Fibras Quadráticas e Classes de Quociente)
Audita o certificado de 7 fibras ($0=1$ sobre $\mathbb{F}_2$, excluindo $2^{120}$ funções), a obstrução da fibra antidiagonal (núcleo de dimensão 149, excluindo $2^{149}$ funções) e as 30.038 equações das 631 classes de quociente:

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/avanco_t32/Certificados_T32_Colab.ipynb)  
👉 **[ABRIR NOTEBOOK DE $t=32$ NO GOOGLE COLAB](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/avanco_t32/Certificados_T32_Colab.ipynb)**

### 3. Worker automático Colab ↔ GitHub

Mantém uma sessão do Colab consultando `jobs/queue.json`, executando scripts Python do repositório e enviando status e resultados de volta ao GitHub:

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/Colab_GitHub_Worker.ipynb)  
👉 **[ABRIR WORKER AUTOMÁTICO NO GOOGLE COLAB](https://colab.research.google.com/github/contatofilipevono-rgb/hrsbf-bent-verification/blob/main/Colab_GitHub_Worker.ipynb)**

O worker executa somente arquivos `.py` existentes dentro deste repositório. A fila inicial contém um teste de GPU + `verificador_standalone.py`.

---

## 📁 Estrutura dos Arquivos

| Arquivo / Diretório | Descrição |
|:---|:---|
| **[`HRSBF_Auditoria_Colab.ipynb`](HRSBF_Auditoria_Colab.ipynb)** | Notebook Colab com auditoria completa do caso $n \not\equiv 0 \pmod{32}$ e fronteiras. |
| **[`avanco_t32/Certificados_T32_Colab.ipynb`](avanco_t32/Certificados_T32_Colab.ipynb)** | Notebook Colab dedicado aos certificados de obstrução em $t=32$. |
| **[`avanco_t32/`](avanco_t32/)** | Scripts e dados dos certificados em 32 variáveis (`verificar_7_fibras.py`, `verificar_classes.py`, etc.). |
| **[`avanco_t32/verificar_desacoplamento_paridade.py`](avanco_t32/verificar_desacoplamento_paridade.py)** | Prova do Lema de Desacoplamento por Paridade em $n=32$ ($2^{35}-1$ funções excluídas analiticamente). |
| **[`avanco_t32/verificar_derivadas_diagonais.py`](avanco_t32/verificar_derivadas_diagonais.py)** | Fecha por autocorrelação diagonal as 24 classes que restavam no recorte $\mathrm{wt}(\eta)\le2$. |
| **[`avanco_t32/audit_constraints_rotation.py`](avanco_t32/audit_constraints_rotation.py)** | Controles algébricos da ação afim de rotação (65.536 direções, 4.115 colares, tabelas completas). |
| **[`master_suite_fronteiras.py`](master_suite_fronteiras.py)** | Master Suite Turnkey em Python Puro: audita todas as 4 fronteiras em < 5 segundos. |
| **[`verificador_standalone.py`](verificador_standalone.py)** | Verificador em 100% Python padrão (zero dependências externas), executa as 136.697 checagens em < 1 s. |
| **[`verificador_hrsbf.py`](verificador_hrsbf.py)** | Verificador acelerado por vetorização NumPy (inclui busca exaustiva por Gray-code e FWHT). |
| **[`dossie_completo_auditoria_hrsbf.md`](dossie_completo_auditoria_hrsbf.md)** | Dossiê formal unificado de auditoria com demonstrações algébricas detalhadas. |
| **[`paper_hrsbf.tex`](paper_hrsbf.tex)** | Manuscrito científico completo em formato LaTeX. |
| **[`supplementary_material.tex`](supplementary_material.tex)** | Material suplementar formal em formato LaTeX. |

---

## 💻 Como Executar Localmente

### Opção 1: Certificados em 32 Variáveis ($t = 32$)
```bash
cd avanco_t32
python verificar_7_fibras.py
python verificar_fibra_antidiagonal.py
python verificar_classes.py
python verificar_derivadas_diagonais.py
```
*Tempo total:* ~15 a 20 segundos em CPU convencional (zero pacotes externos necessários).

### Opção 2: Verificador Standalone do Teorema Principal
```bash
python verificador_standalone.py
```
*Tempo de execução típico:* ~0,98 segundos.

### Opção 3: Master Suite Turnkey
```bash
python master_suite_fronteiras.py
```
*Tempo de execução típico:* ~4,4 segundos.

---

## 📊 Resumo dos Resultados Computacionais e Escopo Rigoroso

* **Teorema de Ward ($t=16$, 43 geradores):**  
  $\binom{43}{1} + \binom{43}{2} + \binom{43}{3} + \binom{43}{4} = \mathbf{136.697}$ condições testadas sobre os 4.080 representantes de órbitas de $\mathbb{F}_2^{16} \setminus V_8$.  
  **Resultado:** **0 falhas**. Logo, $\mathrm{wt}(g) \equiv 0 \pmod{256} \implies W_g(0) \equiv 0 \pmod{512} \ne \pm 256$ (bent impossível).
* **Bases Finitas $t \in \{2, 4, 8\}$:**  
  Todas as funções no span satisfazem $W_g(0) \ne \pm 2^{t/2}$ (**0 bent**).
* **Fronteira Estrutural em $t = 32$:**  
  A extensão universal da divisibilidade por $2^{16}$ cessa em $t = 32$, pois a órbita elementar fornece resto $512 \pmod{2048} \ne 0$.
* **Certificados Parciais em $t = 32$:**  
  - Certificado de 7 fibras: 7 equações somam $0=1$, excluindo a família inteira de dimensão 120 ($2^{120}$ funções).
  - Obstrução antidiagonal: 6 formas lineares independentes excluem um subespaço de dimensão 149 ($2^{149}$ funções).
  - Quocientes de peso $\le 2$: **631 de 631 classes excluídas**. As primeiras 607 são certificadas por fibra antidiagonal/contradições lineares; as 24 restantes por testemunhos de autocorrelação diagonal não nula.
  - *Escopo delimitado:* Esses certificados em 32 variáveis são resultados parciais para as famílias examinadas; o caso geral $n \equiv 0 \pmod{32}$ permanece em aberto.

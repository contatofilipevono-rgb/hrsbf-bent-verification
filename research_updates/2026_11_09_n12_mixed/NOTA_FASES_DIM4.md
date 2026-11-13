# Formas quadráticas das fases nos blocos de dimensão quatro

O verificador `dim4_phase_profiles.py` recebe as listas `V1_exclusivo_mapas.json` e `V2_exclusivo_mapas.json` produzidas por Fable. Reconstrói cada mapa na base independente do repositório a partir da tabela dos rótulos. Então resolve as paridades lineares dos momentos e elimina as relações lineares que vêm das condições módulo 4. A contagem se refere aos mapas positivos fornecidos nas duas listas.

Em V1, sobram uma quadrática de posto 2 e três equações lineares em cada um dos 120 mapas. Em 96 mapas, a quadrática é balanceada, o que dá metade das fases após a redução linear. Nos outros 24, ela zera em três quartos do espaço. Isso dá 1.900.544 fases.

Em V2, 656 mapas ficam com sistemas lineares. Nos outros 112 sobram duas quadráticas. Entre as três combinações não nulas das duas equações, exatamente uma tem soma de Gauss negativa e módulo (2^{d-1}) no espaço residual de dimensão (d). Essa quadrática tem posto 2 e é constante nas classes do radical, portanto sua anulação fixa dois bits afins. A outra equação restringe-se a uma condição linear não constante nesse subespaço. A solução conjunta é um subespaço afim de codimensão três e tem (2^{d-3}) fases. A soma de V2 é 2.326.528.

As contagens são verificadas mapa a mapa. A explicação das dimensões lineares por família polar e a dedução estrutural da lista de mapas positivos continuam abertas.

SHA-256 dos insumos:

- V1: `1c4b463362692317f0da9edbd96376f1f8d6e7e886c23079b22bf76c3da9f72b`
- V2: `a3e725fd2a69d48092a6091e5bf23cbe57211e05a66cb6ad7ecd2490b2ccd9ed`

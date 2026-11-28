# B0_00, K=0. Recertificação das lacunas

O domínio da recertificação é a raiz de K=0 com C5. Os arquivos `cert_k0_eta*.json` registram os certificados concluídos. A lista de origem em `k0_recert_source.json` vem dos logs dos runs 46072471870 e 46077594419 e contém o hash de raiz e os intervalos de prefixos. O manifesto `k0_gaps_manifest.json` contém o placar.

A primeira reprodução direcionada inspeciona 473 folhas antes abertas. O retry de eta=1 subdivide somente suas 21 folhas originais, valida a projeção de W quando ela confere e usa contagens exatas de seis fibras e checagem DRAT. Se o solver retornar SAT, o status indica um modelo das equações codificadas. Se retornar UNKNOWN ou um job for interrompido, a folha permanece aberta no manifesto.

Use `python ../validate_k0_gap_certificates.py .` a partir de `certs` para conferir a cobertura dos relatórios presentes. A aceitação estrutural verifica os registros de evidência. A reprodução matemática usa os scripts e as provas anexadas às execuções.

- [Reprodução das 473 folhas](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/46152367503)
- [Retomada de eta=1](https://github.com/contatofilipevono-rgb/hrsbf-bent-verification/actions/runs/46153316781)

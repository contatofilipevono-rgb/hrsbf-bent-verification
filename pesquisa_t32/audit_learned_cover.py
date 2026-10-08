#!/usr/bin/env python3
"""Fresh holdout that attempts to refute a learned four-fiber cover."""
import json
from pathlib import Path
import numpy as np
from pesquisa_fibras_loop import make_tables
from verify_fibras_loop import directly_evaluate


def audit():
    orbits, basis, indices = make_tables(16, 5)
    cover = [5, 3, 15, 1]
    seed = 2026100699
    rng = np.random.default_rng(seed)
    selected_basis = basis[:, indices[cover].reshape(-1)].astype(np.float32)
    survivors = 0
    examples = []
    for _ in range(8):
        coefficients = rng.integers(0, 2, (8192, len(basis)), dtype=np.uint8)
        weights = ((coefficients.astype(np.float32) @ selected_basis).astype(np.int32) & 1)
        weights = weights.reshape(8192, len(cover), 256).sum(axis=2)
        rows = np.flatnonzero(np.all(weights == 128, axis=1))
        survivors += len(rows)
        for row in rows[:max(0, 3-len(examples))]:
            coeff = coefficients[row]
            mask = sum(int(value) << i for i, value in enumerate(coeff))
            table = np.bitwise_xor.reduce(basis[coeff.astype(bool)], axis=0)
            all_weights = table[indices].sum(axis=1)
            bad = np.flatnonzero(all_weights[1:] != 128) + 1
            witness = None
            if len(bad):
                z = int(bad[0])
                direct = sum(directly_evaluate(coeff, orbits, int(x)) for x in indices[z])
                if direct != int(all_weights[z]) or direct == 128:
                    raise RuntimeError('Independent ANF witness failed')
                witness = {'z': z, 'weight': direct, 'required': 128}
            examples.append({'coefficients': hex(mask), 'weights': weights[row].tolist(),
                             'independent_anf_exclusion_witness': witness})
    return {'n': 16, 'degree': 5, 'cover': cover, 'fresh_dense_draws': 65536,
            'fresh_seed': seed, 'survivors': survivors, 'examples': examples,
            'interpretation': 'Finite holdout; neither zero nor positive survivors settles bentness.'}


if __name__ == '__main__':
    result = audit()
    Path('validacao_cobertura_ampliada.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))

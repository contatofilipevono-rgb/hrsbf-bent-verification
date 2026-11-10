"""Coordinates and polynomial interpolation over F4 for six cyclic bits."""

def mul(a, b):
    value = ((a if b & 1 else 0) ^ ((a << 1) if b & 2 else 0))
    return value ^ 7 if value & 4 else value


def square(a):
    return mul(a, a)


def trace(a):
    return a ^ square(a)


def coordinates(z):
    even = (z & 1) ^ (2 * (z >> 2 & 1)) ^ (3 * (z >> 4 & 1))
    odd = (z >> 1 & 1) ^ (2 * (z >> 3 & 1)) ^ (3 * (z >> 5 & 1))
    return (z >> 1 ^ z >> 3 ^ z >> 5) & 1, even ^ mul(3, odd), even


ODD = {coordinates(z): z for z in range(64) if z.bit_count() & 1}
PROJECTIVE = [(0, 1)] + [(1, k) for k in range(4)]
POINTS = [ODD[0, u, v] for u, v in PROJECTIVE]


def fit(values):
    rows = [[u, v, mul(square(u), square(v)), int(u != 0) * v,
             int(v != 0) * u, value] for (u, v), value in zip(PROJECTIVE, values)]
    for j in range(5):
        k = next(k for k in range(j, 5) if rows[k][j])
        rows[j], rows[k] = rows[k], rows[j]
        inverse = next(a for a in range(1, 4) if mul(a, rows[j][j]) == 1)
        rows[j] = [mul(a, inverse) for a in rows[j]]
        for k in range(5):
            if k != j:
                scalar = rows[k][j]
                rows[k] = [a ^ mul(scalar, b) for a, b in zip(rows[k], rows[j])]
    return [r[-1] for r in rows]

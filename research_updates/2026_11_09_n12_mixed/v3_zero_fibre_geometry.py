"""Classify the possible zero fibres for the fixed profile (0,0,0,3,0,5,6,0)."""
from lower_dim_model import active_indices, anf


def rotate(value, width):
    return ((value << 1) | (value >> (width - 1))) & ((1 << width) - 1)


def z_orbit(z):
    orbit = [z]
    while (z := rotate(z, 6)) != orbit[0]:
        orbit.append(z)
    return orbit


def piece(z, points):
    mask = 0
    for u in points:
        zz, uu = z, u
        for _ in range(6):
            mask |= 1 << (zz + 64*uu)
            zz, uu = rotate(zz, 6), rotate(uu, 3) ^ (zz >> 5)
    return mask


def point_orbit(y):
    z, u = y & 63, y >> 6
    points = [y]
    while True:
        z, u = rotate(z, 6), rotate(u, 3) ^ (z >> 5)
        if z + 64*u == y:
            return points
        points.append(z + 64*u)


def main():
    pairs = {}
    for z in range(64):
        orbit = z_orbit(z)
        if len(orbit) != 6 or z != min(orbit):
            continue
        r = (z >> 3) ^ (z & 7)
        pairs[z] = [(u, u ^ r) for u in range(8) if u < (u ^ r)]
    fixed = sum(1 << (9*x + 64*u) for x in (0, 1, 2, 4, 7) for u in range(8))
    moments = (63, 111, 175, 222, 123, 126)

    def signature(support):
        coefficients = anf(support, 9)
        return sum(((coefficients >> i) & 1) << j for j, i in enumerate(moments))

    assert all(i.bit_count() == 6 for i in moments)
    assert signature(fixed) == 1
    entries = {}
    for z, choices in pairs.items():
        values = []
        for p in choices:
            shape = piece(z, p)
            value = signature(shape)
            entries.setdefault(value, []).append((z, p, shape))
            values.append((p[0], value))
        print(z, values)
    surviving = []
    for even, records in entries.items():
        if even & 1:
            continue
        for z, p, shape in records:
            for zz, q, other in entries.get(even ^ 1, []):
                assert z == zz
                surviving.append((z, sum(1 << u for u in p + q), fixed | shape | other))
    assert sorted((z, u_mask) for z, u_mask, _ in surviving) == [
        (3, 105), (3, 150), (7, 60), (7, 102), (7, 153), (7, 195), (23, 105), (23, 150)]
    orbit = [min(point_orbit(y)) for y in range(512)]
    for z, u_mask, support in surviving:
        if z == 7:
            # A rank-one Q at z=7 has kernel u0+u2=0.
            assert u_mask not in (90, 165)
            continue
        intersection = sum(1 << y for y in active_indices(support) if (support >> (y ^ z)) & 1)
        parity_labels = set()
        for y in active_indices(intersection):
            parity_labels ^= {orbit[y]}
        assert intersection.bit_count() == 8
        assert parity_labels in ({0, 192}, {64, 448})
        print((z, u_mask), 'shift', z, 'odd orbit labels', sorted(parity_labels))


if __name__ == '__main__':
    main()

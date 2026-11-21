"""Verifica a obstrução CRT para dois blocos após fixar controles físicos."""

from functools import cache


@cache
def pares_de_valores(modulo, valoracao, expoente_segundo_momento):
    """Enumera os possíveis valores x e -y mais próximos de zero."""
    momento = 1 << expoente_segundo_momento
    escala = 1 << valoracao
    return tuple(
        (x, y)
        for x in range(1, 2 * momento, 2)
        for y in range((-x) % modulo, 2 * momento, modulo)
        if x + y <= 2 * momento
        and escala * x * y - abs(x - y) <= escala * momento
    )


def perfis_possiveis(controles):
    modulo = 1 << (8 - controles)
    residuos = {(-1 + modulo * s) % 127 for s in range((1 << controles) + 1)}
    dimensao = 32 - controles
    for d1 in range(1, dimensao // 2 + 1):
        d2 = dimensao - d1
        for v1 in range(1, 9):
            v2 = 9 - v1
            if not (2 * v1 <= d1 <= 4 * v1 and 2 * v2 <= d2 <= 4 * v2):
                continue
            primeiro = pares_de_valores(modulo, v1, d1 - 2 * v1)
            segundo = pares_de_valores(modulo, v2, d2 - 2 * v2)
            if any(
                (x1 * x2 + 1) % modulo == 0
                and all(
                    produto % 127 in residuos
                    for produto in (x1 * x2, -x1 * y2, -y1 * x2, y1 * y2)
                )
                for x1, y1 in primeiro
                for x2, y2 in segundo
            ):
                yield (d1, d2, v1, v2)


def main():
    for controles in range(6):
        perfis = tuple(perfis_possiveis(controles))
        esperado = () if controles < 5 else ((4, 23, 1, 8),)
        if perfis != esperado:
            raise AssertionError((controles, perfis, esperado))
        print(f"r={controles} | perfis compatíveis com as cotas = {perfis}")


if __name__ == "__main__":
    main()

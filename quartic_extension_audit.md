# Quartic extension: first structural audit

## Goal

Test whether the cubic proof architecture can extend from homogeneous degree 3 to homogeneous degree 4 rotation-symmetric bent functions.

## Immediate obstruction

The odd-order fixed-space reduction used in the cubic theorem is degree-sensitive.

For a bent f of degree at most 3 and a nonzero fixed direction a, D_a f is a balanced quadratic. The odd-order invariant-quadratic lemma transfers its balance to the fixed space, so every nonzero derivative of the restriction is balanced and the restriction is bent.

For degree at most 4, D_a f is generally cubic. The invariant-quadratic lemma no longer applies. Passing to D_b D_a f lowers the degree to at most 2, but bentness does NOT imply that second derivatives are balanced. Therefore the naive replacement

    first derivative -> second derivative -> quadratic fixed-space lemma

is invalid.

This is a genuine logical barrier, not a computational limitation.

## Autocorrelation reformulation

Bentness gives, for every nonzero a,

    A_f(a)=sum_x (-1)^{D_a f(x)}=0.

For fixed a, define q_{a,b}(x)=D_bD_a f(x), a quadratic when deg f<=4. The autocorrelation of the cubic derivative D_a f is

    A_{D_a f}(b)=sum_x (-1)^{D_bD_a f(x)}.

These values are not individually forced to vanish by bentness of f.

However, their Walsh/Fourier structure is constrained because D_a f is balanced and because all D_a f arise from one bent f. A viable quartic extension must exploit an aggregate identity among the quadratic character sums A_{D_a f}(b), rather than assume their individual vanishing.

## Fixed-space target

Let T have odd order m and U=Fix(T), as in the cubic proof. To prove that f|_U is bent it is enough to show, for every nonzero a in U,

    sum_{u in U} (-1)^{D_a f(u)}=0.

For cubic D_a f this was obtained directly from the invariant-quadratic lemma. For quartic D_a f is cubic, so the new problem can be isolated:

> Odd-order cubic balance transfer problem.
> If c is a T-invariant balanced cubic Boolean function, under what additional conditions arising from c=D_a f with f bent does c|_U remain balanced?

An unrestricted transfer theorem is unlikely: odd-order invariance alone does not force a balanced cubic to remain balanced on U.

## Higher-derivative route

For a in U and b in U, q_{a,b}=D_bD_a f is T-invariant and quadratic. Thus the existing fixed-space lemma DOES control the zero-frequency character sum of q_{a,b} on V versus U.

This means the entire autocorrelation function of c|_U can potentially be related to the autocorrelation of c on V for directions b in U. If enough of those autocorrelations are controlled by the bent parent f, then restriction bentness may still follow.

The next exact target is therefore to derive identities for

    A_{D_a f}(b)=sum_x (-1)^{D_aD_b f(x)}

when f is bent, and determine whether their restriction to a,b in U has a forced pattern strong enough to imply balance of D_a(f|_U).

## Status

- Cubic proof does not extend formally to degree 4.
- No strong computation is needed yet.
- The obstruction is now localized to a precise missing theorem: transfer of balance for cubic derivatives of a bent parent across an odd-order fixed space.
- Any quartic attack should solve or bypass this transfer problem before analyzing quartic orbit folding.

No claim about nonexistence of homogeneous quartic RS bent functions is made here.

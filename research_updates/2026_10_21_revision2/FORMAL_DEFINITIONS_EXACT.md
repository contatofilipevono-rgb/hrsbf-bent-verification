# Exact definitions from the certified source archive

Coordinate i is bit i (least significant bit has index zero). The listing normalizes line endings for display; source hashes refer to the original certified bytes.

## monomialValue — H12PeriodFour.lean

```lean
def monomialValue (s x : Nat) : Bool := (x &&& s) == s
```

## orbitValue — H12PeriodFour.lean

```lean
def orbitValue (o : List Nat) (x : Nat) : Bool :=
  o.foldl (fun a s => a ^^ monomialValue s x) false
```

## quarticFunction — H12PeriodFour.lean

```lean
def quarticFunction (c : BitVec 43) (x : Nat) : Bool :=
  (c.getLsbD 0 && orbitValue (quarticOrbits[(0 : Fin 43).val]!) x) ^^
  (c.getLsbD 1 && orbitValue (quarticOrbits[(1 : Fin 43).val]!) x) ^^
  (c.getLsbD 2 && orbitValue (quarticOrbits[(2 : Fin 43).val]!) x) ^^
  (c.getLsbD 3 && orbitValue (quarticOrbits[(3 : Fin 43).val]!) x) ^^
  (c.getLsbD 4 && orbitValue (quarticOrbits[(4 : Fin 43).val]!) x) ^^
  (c.getLsbD 5 && orbitValue (quarticOrbits[(5 : Fin 43).val]!) x) ^^
  (c.getLsbD 6 && orbitValue (quarticOrbits[(6 : Fin 43).val]!) x) ^^
  (c.getLsbD 7 && orbitValue (quarticOrbits[(7 : Fin 43).val]!) x) ^^
  (c.getLsbD 8 && orbitValue (quarticOrbits[(8 : Fin 43).val]!) x) ^^
  (c.getLsbD 9 && orbitValue (quarticOrbits[(9 : Fin 43).val]!) x) ^^
  (c.getLsbD 10 && orbitValue (quarticOrbits[(10 : Fin 43).val]!) x) ^^
  (c.getLsbD 11 && orbitValue (quarticOrbits[(11 : Fin 43).val]!) x) ^^
  (c.getLsbD 12 && orbitValue (quarticOrbits[(12 : Fin 43).val]!) x) ^^
  (c.getLsbD 13 && orbitValue (quarticOrbits[(13 : Fin 43).val]!) x) ^^
  (c.getLsbD 14 && orbitValue (quarticOrbits[(14 : Fin 43).val]!) x) ^^
  (c.getLsbD 15 && orbitValue (quarticOrbits[(15 : Fin 43).val]!) x) ^^
  (c.getLsbD 16 && orbitValue (quarticOrbits[(16 : Fin 43).val]!) x) ^^
  (c.getLsbD 17 && orbitValue (quarticOrbits[(17 : Fin 43).val]!) x) ^^
  (c.getLsbD 18 && orbitValue (quarticOrbits[(18 : Fin 43).val]!) x) ^^
  (c.getLsbD 19 && orbitValue (quarticOrbits[(19 : Fin 43).val]!) x) ^^
  (c.getLsbD 20 && orbitValue (quarticOrbits[(20 : Fin 43).val]!) x) ^^
  (c.getLsbD 21 && orbitValue (quarticOrbits[(21 : Fin 43).val]!) x) ^^
  (c.getLsbD 22 && orbitValue (quarticOrbits[(22 : Fin 43).val]!) x) ^^
  (c.getLsbD 23 && orbitValue (quarticOrbits[(23 : Fin 43).val]!) x) ^^
  (c.getLsbD 24 && orbitValue (quarticOrbits[(24 : Fin 43).val]!) x) ^^
  (c.getLsbD 25 && orbitValue (quarticOrbits[(25 : Fin 43).val]!) x) ^^
  (c.getLsbD 26 && orbitValue (quarticOrbits[(26 : Fin 43).val]!) x) ^^
  (c.getLsbD 27 && orbitValue (quarticOrbits[(27 : Fin 43).val]!) x) ^^
  (c.getLsbD 28 && orbitValue (quarticOrbits[(28 : Fin 43).val]!) x) ^^
  (c.getLsbD 29 && orbitValue (quarticOrbits[(29 : Fin 43).val]!) x) ^^
  (c.getLsbD 30 && orbitValue (quarticOrbits[(30 : Fin 43).val]!) x) ^^
  (c.getLsbD 31 && orbitValue (quarticOrbits[(31 : Fin 43).val]!) x) ^^
  (c.getLsbD 32 && orbitValue (quarticOrbits[(32 : Fin 43).val]!) x) ^^
  (c.getLsbD 33 && orbitValue (quarticOrbits[(33 : Fin 43).val]!) x) ^^
  (c.getLsbD 34 && orbitValue (quarticOrbits[(34 : Fin 43).val]!) x) ^^
  (c.getLsbD 35 && orbitValue (quarticOrbits[(35 : Fin 43).val]!) x) ^^
  (c.getLsbD 36 && orbitValue (quarticOrbits[(36 : Fin 43).val]!) x) ^^
  (c.getLsbD 37 && orbitValue (quarticOrbits[(37 : Fin 43).val]!) x) ^^
  (c.getLsbD 38 && orbitValue (quarticOrbits[(38 : Fin 43).val]!) x) ^^
  (c.getLsbD 39 && orbitValue (quarticOrbits[(39 : Fin 43).val]!) x) ^^
  (c.getLsbD 40 && orbitValue (quarticOrbits[(40 : Fin 43).val]!) x) ^^
  (c.getLsbD 41 && orbitValue (quarticOrbits[(41 : Fin 43).val]!) x) ^^
  (c.getLsbD 42 && orbitValue (quarticOrbits[(42 : Fin 43).val]!) x)
```

## derivativeSign — H12Descent.lean

```lean
def derivativeSign (f : Nat → Bool) (u x : Nat) : Int :=
  if f x == f (x ^^^ u) then 1 else -1
```

## BentAC — H12Descent.lean

```lean
def BentAC (f : Nat → Bool) : Prop :=
  ∀ u, u < 4096 → u ≠ 0 → ((List.range 4096).map (derivativeSign f u)).sum = 0
```

## total — H12Walsh.lean

```lean
def total (xs : List α) (f : α → Int) : Int := (xs.map f).sum
```

## sign — H12Walsh.lean

```lean
def sign (b : Bool) : Int := if b then -1 else 1
```

## dotBits — H12Walsh.lean

```lean
def dotBits : Nat → Nat → Nat → Bool
  | 0, _, _ => false
  | n+1, a, x => dotBits n a x ^^ (a.testBit n && x.testBit n)
```

## character — H12Walsh.lean

```lean
def character (a x : Nat) : Int := sign (dotBits 12 a x)
```

## walsh — H12Walsh.lean

```lean
def walsh (f : Nat → Bool) (a : Nat) : Int :=
  total (List.range 4096) (fun x => sign (f x) * character a x)
```
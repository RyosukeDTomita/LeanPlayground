import Mathlib

/-!
# NNG 互換シム

Natural Number Game (NNG4) はブラウザ上では独自型 `MyNat` と独自補題を使う。
`one_eq_succ_zero` / `two_eq_succ_one` / `add_succ` などは NNG 固有で、Mathlib に同名は無い。

このファイルは Mathlib の `Nat` (= `ℕ`) 上に同名の補題を用意し、
ブラウザの解答(tactic 列)をそのままコンパイルできるようにするシム。

- `add_zero` (`a + 0 = a`) は Mathlib のグローバル補題をそのまま使う(ここでは定義しない)。
- `succ` は各レベルファイルで `open Nat (succ)` して使う。
-/

namespace NNG

theorem one_eq_succ_zero : (1 : ℕ) = Nat.succ 0 := rfl
theorem two_eq_succ_one : (2 : ℕ) = Nat.succ 1 := rfl
theorem three_eq_succ_two : (3 : ℕ) = Nat.succ 2 := rfl
theorem four_eq_succ_three : (4 : ℕ) = Nat.succ 3 := rfl

-- a + succ b = succ (a + b)。Mathlib では Nat.add_succ という名前になっている。
theorem add_succ (a b : ℕ) : a + Nat.succ b = Nat.succ (a + b) := Nat.add_succ a b

end NNG

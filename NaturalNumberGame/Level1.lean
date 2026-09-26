import Mathlib

/-!
# Tutorial World — Level 1: `rfl`

> If `x` and `q` are arbitrary natural numbers, then `37x + q = 37x + q`.

左辺と右辺が定義上まったく同じなので、反射律 `rfl` で閉じる。
-/

example (x q : ℕ) : 37 * x + q = 37 * x + q := by
  rfl

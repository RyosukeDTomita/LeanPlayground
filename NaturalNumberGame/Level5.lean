import NaturalNumberGame.NngShim

open Nat (succ)
open NNG

/-!
# Tutorial World — Level 5: `add_zero`

> `a + (b + 0) + (c + 0) = a + b + c`

`add_zero : a + 0 = a` で `+ 0` を消していく。

補足: 自動 `rfl` をしない `rewrite`(= NNG の `rw` と同じ挙動)を使い、末尾 `rfl` を残す。
-/

example (a b c : ℕ) : a + (b + 0) + (c + 0) = a + b + c := by
  rewrite [add_zero]
  rewrite [add_zero]
  rfl

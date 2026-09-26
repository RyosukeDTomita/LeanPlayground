import NaturalNumberGame.NngShim

open Nat (succ)
open NNG

/-!
# Tutorial World — Level 7: `add_succ` (`succ_eq_add_one`)

> `succ n = n + 1`

`1` を `succ 0` に開き、`add_succ` で `n + succ 0 = succ (n + 0)` とし、
`add_zero` で `+ 0` を消すと両辺が一致する。

補足: 自動 `rfl` をしない `rewrite`(= NNG の `rw` と同じ挙動)を使い、末尾 `rfl` を残す。
-/

example (n : ℕ) : succ n = n + 1 := by
  rewrite [one_eq_succ_zero]
  rewrite [add_succ]
  rewrite [add_zero]
  rfl

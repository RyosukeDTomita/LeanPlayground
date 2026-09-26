import NaturalNumberGame.NngShim

open Nat (succ)
open NNG

/-!
# Tutorial World — Level 4: `rw` を逆向きに使う

> `2 = succ (succ 0)`

Level 3 と同じゴールを、今度は右辺の `succ (succ 0)` 側を畳んで示す。
`rewrite [← ...]` で補題を逆向き(右辺→左辺)に適用する。

補足: 自動 `rfl` をしない `rewrite`(= NNG の `rw` と同じ挙動)を使い、末尾 `rfl` を残す。
-/

example : (2 : ℕ) = succ (succ 0) := by
  rewrite [← one_eq_succ_zero]
  rewrite [two_eq_succ_one]
  rfl

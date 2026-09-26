import NaturalNumberGame.NngShim

open Nat (succ)
open NNG

/-!
# Tutorial World — Level 6: `add_zero` に引数を渡す

> `a + (b + 0) + (c + 0) = a + b + c`

Level 5 と同じゴール。`add_zero c` のように引数を明示すると、
書き換える `+ 0` を狙って選べる。

補足: 自動 `rfl` をしない `rewrite`(= NNG の `rw` と同じ挙動)を使い、末尾 `rfl` を残す。
-/

example (a b c : ℕ) : a + (b + 0) + (c + 0) = a + b + c := by
  rewrite [add_zero c]
  rewrite [add_zero b]
  rfl

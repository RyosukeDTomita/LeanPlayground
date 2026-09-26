import NaturalNumberGame.NngShim

open Nat (succ)
open NNG

/-!
# Tutorial World — Level 8: `2 + 2 = 4`

> `(2 : ℕ) + 2 = 4`

`nth_rewrite 2 [...]` で2つ目の `2` だけを `succ 1` に開き、`add_succ` / `add_zero` で
`succ (succ 2)` まで畳んでから、`succ 2 → 3`、`succ 3 → 4` と戻して両辺を一致させる。

補足: 自動 `rfl` をしない `rewrite`(= NNG の `rw` と同じ挙動)を使い、末尾 `rfl` を残す。
`nth_rewrite` はもともと自動 `rfl` をしないためそのまま。
-/

example : (2 : ℕ) + 2 = 4 := by
  nth_rewrite 2 [two_eq_succ_one]  -- 2つ目の `2` だけを `succ 1` に変える
  rewrite [add_succ]
  rewrite [one_eq_succ_zero]
  rewrite [add_succ]
  rewrite [add_zero]
  rewrite [← three_eq_succ_two]
  rewrite [← four_eq_succ_three]
  rfl

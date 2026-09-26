import NaturalNumberGame.NngShim

open Nat (succ)
open NNG

/-!
# Tutorial World — Level 3: `two_eq_succ_one`

> `2 = succ (succ 0)`

数字 `2` を `succ 1` に、`1` を `succ 0` に書き換えると両辺が一致する。

補足: NNG(ブラウザ)の `rw` は書き換えるだけだが、Lean 標準の `rw` は書き換え後に
自動で `rfl` を試す。さらに `Nat` では `2` と `succ 1` が定義的に等しいため、`rw` だと
1手目で早々にゴールが閉じてしまう。NNG と同じ手順・末尾 `rfl` を残すため、ここでは
自動 `rfl` をしない `rewrite`(= NNG の `rw` と同じ挙動)を使う。
-/

example : (2 : ℕ) = succ (succ 0) := by
  rewrite [two_eq_succ_one]
  rewrite [one_eq_succ_zero]
  rfl

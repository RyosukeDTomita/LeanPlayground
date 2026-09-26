import Mathlib

/-!
# Tutorial World — Level 2: `rw`

> If `x` and `y` are natural numbers, and `y = x + 7`, then `2 * y = 2 * (x + 7)`.

仮説 `h : y = x + 7` を使って、ゴールの `y` を `x + 7` に書き換えれば、
両辺が一致して証明が閉じる。書き換えには `rw` を使う。

注: これは NNG4 Tutorial World の標準的な Level 2。ブラウザの問題文が違う場合は
下の `example` の型と仮説を差し替えること。
-/

example (x y : ℕ) (h : y = x + 7) : 2 * y = 2 * (x + 7) := by
  rw [h]

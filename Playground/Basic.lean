-- Lean 入門用のサンプル。定義と定理(証明)の両方を置いている。

def hello : String := "world"

-- 自然数の加法の交換則。Lean 標準ライブラリの補題で証明する。
theorem add_comm_example (a b : Nat) : a + b = b + a := by
  omega

-- 簡単な命題論理の証明。
theorem and_swap (p q : Prop) : p ∧ q → q ∧ p := by
  intro h
  exact ⟨h.right, h.left⟩

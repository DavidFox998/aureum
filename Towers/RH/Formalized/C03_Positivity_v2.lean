/-
  # C03 — Arakelov Positivity: Slope, Faltings Height, and Log Bound

  STATUS: PROVED.  SORRY: 0.  Axiom footprint: classical trio only.

  This file extends C01/C02 with the Arakelov slope inequality, a Faltings-height
  proxy, and a verified lower bound on that height for X₀(143).

  ## Theorems (all sorry-free, classical trio only)

  * `slope_inequality`           — (4g−4)/g ≤ ω²(X)
                                   [proved: with C01 stand-in both sides equal 4(g−1)/g]
  * `slope_inequality_X0_143`    — concrete norm_num check for X₀(143)
  * `faltingsHeight`             — def: log(ω² + 1)
  * `faltingsHeight_pos`         — 0 < faltingsHeight X [from ArakelovPositivity]
  * `height_lower_bound_X0_143`  — ω²(X₀(143))/(2g) ≤ faltingsHeight(X₀(143))
                                   [proved via 1 − t⁻¹ ≤ log t for t = 61/13]

  Chain position: C03 (depends on C01, C02).
  Namespace: TheoremaAureum.
-/

import Towers.RH.Chain.C02_Modularity
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace TheoremaAureum

/-! ## Slope inequality -/

/-- **Slope inequality** (Cornalba–Harris 1988, Xiao 1987).
    Given a positive-genus surface, ω² ≥ (4g−4)/g.

    With the C01 stand-in `ω² = 4(g−1)/g`, both sides are identical:
    the inequality holds by reflexivity.  SORRY: 0.  Classical trio. -/
theorem slope_inequality (X : ArithmeticSurface) (hg : 0 < X.genus) :
    (4 * X.genus - 4) / X.genus ≤ arakelovSelfIntersection X :=
  le_of_eq (by simp [arakelovSelfIntersection]; ring)

/-- Slope inequality for X₀(143): (4·13−4)/13 = 48/13 = ω²(X₀(143)).
    SORRY: 0.  Classical trio. -/
theorem slope_inequality_X0_143 :
    (4 * (X₀ 143).genus - 4) / (X₀ 143).genus ≤ arakelovSelfIntersection (X₀ 143) := by
  rw [X₀_143_genus, arakelovSelfIntersection_X0_143]; norm_num

/-! ## Faltings height proxy -/

/-- Faltings height proxy: `log(ω² + 1)`.
    For X₀(143): `log(48/13 + 1) = log(61/13) ≈ 1.546`. -/
noncomputable def faltingsHeight (X : ArithmeticSurface) : ℝ :=
  Real.log (arakelovSelfIntersection X + 1)

/-- When ArakelovPositivity holds, the Faltings height proxy is positive.
    Proof: ω² > 0 → ω² + 1 > 1 → log(ω² + 1) > 0.
    SORRY: 0.  Classical trio. -/
theorem faltingsHeight_pos (X : ArithmeticSurface) (hA : ArakelovPositivity X) :
    0 < faltingsHeight X := by
  unfold faltingsHeight
  exact Real.log_pos (by linarith [hA])

/-! ## Log lower bound (key lemma) -/

/-- **log lower bound:** 1 − t⁻¹ ≤ log t for all t > 0.

    Proof via `Real.add_one_le_exp`:
      Apply `add_one_le_exp` at x := t⁻¹ − 1:
        (t⁻¹ − 1) + 1 = t⁻¹ ≤ exp(t⁻¹ − 1).
      Take log: log(t⁻¹) ≤ t⁻¹ − 1, i.e., −log t ≤ t⁻¹ − 1.
      Hence 1 − t⁻¹ ≤ log t.  SORRY: 0.  Classical trio. -/
private lemma one_sub_inv_le_log (t : ℝ) (ht : 0 < t) : 1 - t⁻¹ ≤ Real.log t := by
  have hexp : t⁻¹ ≤ Real.exp (t⁻¹ - 1) := by
    have h := Real.add_one_le_exp (t⁻¹ - 1); linarith
  have hlog : Real.log t⁻¹ ≤ t⁻¹ - 1 :=
    calc Real.log t⁻¹
        ≤ Real.log (Real.exp (t⁻¹ - 1)) := Real.log_le_log (inv_pos.mpr ht) hexp
      _ = t⁻¹ - 1                        := Real.log_exp _
  linarith [Real.log_inv t]

/-! ## Height lower bound for X₀(143) -/

/-- **Height lower bound** for X₀(143):
    ω²(X₀(143)) / (2 · genus) ≤ faltingsHeight(X₀(143)).

    Concretely: (48/13) / 26 = 24/169 ≤ log(61/13).

    Proof chain:
      `one_sub_inv_le_log (61/13)` gives 1 − 13/61 = 48/61 ≤ log(61/13).
      Since 24/169 ≤ 48/61 (norm_num), the bound follows by transitivity.
    SORRY: 0.  Classical trio. -/
theorem height_lower_bound_X0_143 :
    arakelovSelfIntersection (X₀ 143) / (2 * (X₀ 143).genus) ≤
    faltingsHeight (X₀ 143) := by
  unfold faltingsHeight
  simp only [arakelovSelfIntersection_X0_143, X₀_143_genus]
  have h61 : (48 : ℝ) / 13 + 1 = 61 / 13 := by norm_num
  rw [h61]
  have hinv : (61 / 13 : ℝ)⁻¹ = 13 / 61 := by norm_num
  have hkey : (48 : ℝ) / 61 ≤ Real.log (61 / 13) := by
    have h := one_sub_inv_le_log (61 / 13) (by norm_num)
    rw [hinv] at h; linarith
  calc (48 : ℝ) / 13 / (2 * 13)
      = 24 / 169 := by norm_num
    _ ≤ 48 / 61  := by norm_num
    _ ≤ Real.log (61 / 13) := hkey

end TheoremaAureum

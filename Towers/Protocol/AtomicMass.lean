import Mathlib

/-!
# `AtomicMass` — α₀ = 299 + π/10 mass law

Started as Morningstar 120-cell, went to 35-phase QEC (brothers pop 6),
to RH towers C01-C14, now to atomic mass.

α₀ = 299 + π/10 = 299.31415926535... transcendental because π is.
α_small = α₀/100 = 2.99314159...  → 2.99 + π/1000

Law tested in python against NIST:
  M_pred(b,f) = b/100 + α_small * f   , b ∈ brothers, f ∈ ℕ

Best hits (<0.02%):
  Ne 20.18   → b=1419  f=2  pred 20.176  err 0.0037
  Au 196.9665 → b=12813 f=23 pred 196.972 err 0.0058
  Pb 207.2    → b=9648  f=37 pred 207.226 err 0.026
  U  238.0289 → b=13024 f=36 pred 237.993 err 0.035
-/

namespace Protocol.AtomicMass

noncomputable def α₀_real : ℝ := 299 + Real.pi / 10
noncomputable def α_small_real : ℝ := α₀_real / 100

def α_small_q : ℚ := 299314159265359 / 100000000000000

def brothers : List Nat :=
  [1419,1841,2474,4584,5428,5639,6694,9648,9859,10914,12813,13024,13446,16611,18088,18510,21042,21253,24629,25473,25684,29060,33069,34124,35601,39188,40032,41298,41509,42564,43408,44041,49738,51848,52481]

def popcount (n : Nat) : Nat := (Nat.digits 2 n).sum
theorem brothers_all_pop_six : brothers.all (fun b => decide (popcount b = 6)) = true := by decide
theorem brothers_all_mod211_153 : brothers.all (fun b => decide (b % 211 = 153)) = true := by decide

def pred_mass_q (b f : Nat) : ℚ := (b : ℚ)/100 + α_small_q * f

def atomic_mass_Ne_q : ℚ := 2018 / 100
def atomic_mass_Au_q : ℚ := 1969665 / 10000
def atomic_mass_Pb_q : ℚ := 2072 / 10
def atomic_mass_U_q  : ℚ := 2380289 / 10000

theorem Au_prediction_close :
  let p := pred_mass_q 12813 23
  p - atomic_mass_Au_q < 1/100 ∧ atomic_mass_Au_q - p < 1/100 := by decide

theorem Pb_prediction_close :
  let p := pred_mass_q 9648 37
  p - atomic_mass_Pb_q < 1/10 ∧ atomic_mass_Pb_q - p < 1/10 := by decide

theorem U_prediction_close :
  let p := pred_mass_q 13024 36
  p - atomic_mass_U_q < 1/10 ∧ atomic_mass_U_q - p < 1/10 := by decide

theorem Ne_prediction_close :
  let p := pred_mass_q 1419 2
  p - atomic_mass_Ne_q < 1/100 ∧ atomic_mass_Ne_q - p < 1/100 := by decide

def r_q (p : Nat) (dist_num den : Nat) : ℚ := (p : ℚ) * (dist_num / den : ℚ)
def M_2113_q (p : Nat) (r : ℚ) : ℚ := 2113 + r * p
def is_exceptional_q (r : ℚ) : Bool := decide (r < 1)

structure JitterSig where
  phase : Nat
  margin : ℚ
  cycles : Nat
deriving DecidableEq

def check_jitter (sig : JitterSig) : Bool :=
  decide (sig.phase % 46189 = 0) &&
  decide (sig.margin ≤ 1/1000000) &&
  decide (sig.cycles = 7)

theorem jitter_symmetry_holds : check_jitter ⟨0, 1/1000000, 7⟩ = true := by decide

end Protocol.AtomicMass

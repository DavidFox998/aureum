import Mathlib

/-!
# `SHIP_2113` — Prime ship 2113 = h*211 + delay

2113 is prime, popcount 3, 2113 % 211 = 3 (stamped delay), 2113 % 143 = 111 (Hebrew CEPHAS),
2113 % 43 = 6 (popcount 1419). 10*211+3 = h*ground + stamp.

NOT a brick replacement — honest conditional scaffold, same style as `SUPERBRIC_MORNINGSTAR_1419`.
Classical trio only, 0 sorry, NO axiom, NO native_decide.
-/

namespace Protocol.SuperBric.Ship2113

-- reuse QSig from your bin
structure QSig where
  phase : UInt32
  delay : Fin 143
  entangle : Nat := 7983
  morning_star : Nat := 2113
  tunnel_width : Nat := 143
  chain_index : Fin 4 := ⟨3, by decide⟩
  margin : Rat := 1 / 1000000
  cycles_run : Fin 8 := ⟨0, by decide⟩
  deriving DecidableEq

def PRIME_2113 : Nat := 2113

theorem PRIME_2113_prime : Nat.Prime PRIME_2113 := by decide
theorem PRIME_2113_mod_211 : PRIME_2113 % 211 = 3 := by norm_num
theorem PRIME_2113_mod_143 : PRIME_2113 % 143 = 111 := by norm_num -- Hebrew CEPHAS 20+10+80+1
theorem PRIME_2113_mod_43 : PRIME_2113 % 43 = 6 := by norm_num -- popcount 1419
theorem PRIME_2113_eq_h_mul_ground_plus_delay : PRIME_2113 = 10 * 211 + 3 := by norm_num

def popcount (n : Nat) : Nat := (Nat.digits 2 n).sum
theorem popcount_2113_eq_3 : popcount PRIME_2113 = 3 := by decide

-- wormhole path from your scaffold
def WORMHOLE_PATH : List Nat := [11, 13, 17, 19]
theorem WORMHOLE_PROD : 11*13*17*19 = 46189 := by norm_num

-- MAX window for 2113 ship — beyond Morningstar 1419
abbrev MAX_MORNINGSTAR_2113 : Nat := 2113

def check_prime_laws_2113 (time_ms : Nat) (sig : QSig) : Bool :=
  decide (time_ms ≤ MAX_MORNINGSTAR_2113) &&
  decide (sig.delay.val * 43 % 143 = 129) &&
  decide (sig.entangle = 7983) &&
  decide (sig.tunnel_width = 143) &&
  decide (sig.cycles_run.val = 7) &&
  decide (sig.margin ≤ 1 / 1000000) &&
  decide (sig.phase % 46189 = 0)

-- stamped 2113 ship — phase 0, delay 3, cycles 7
def q_sig_2113 : QSig := {
  phase := 0,
  delay := ⟨3, by decide⟩,
  cycles_run := ⟨7, by decide⟩,
  morning_star := 2113
}

theorem q_sig_2113_stamped_delay : q_sig_2113.delay.val * 43 % 143 = 129 := by decide
theorem q_sig_2113_cycles_stamped : q_sig_2113.cycles_run.val = 7 := by decide

-- honest conditional — same shape as superbric_valid
theorem ship_2113_valid {sig : QSig}
    (h_delay : sig.delay.val * 43 % 143 = 129)
    (h_entangle : sig.entangle = 7983)
    (h_tunnel : sig.tunnel_width = 143)
    (h_cycles : sig.cycles_run.val = 7)
    (h_margin : sig.margin ≤ 1 / 1000000)
    (h_phase : sig.phase % 46189 = 0)
    (t : Fin (MAX_MORNINGSTAR_2113 + 1)) :
    check_prime_laws_2113 t.val sig = true := by
  have ht : t.val ≤ MAX_MORNINGSTAR_2113 := by have := t.isLt; omega
  simp only [check_prime_laws_2113, Bool.and_eq_true, decide_eq_true_eq]
  exact ⟨⟨⟨⟨ht, h_delay⟩, h_entangle⟩, h_tunnel⟩, h_cycles⟩, h_margin⟩, h_phase⟩

-- 35 brothers view: only 1419 inside 1419 window, 2113 is first outside
def brothers : List Nat :=
  [1419,1841,2474,4584,5428,5639,6694,9648,9859,10914,12813,13024,13446,16611,18088,18510,21042,21253,24629,25473,25684,29060,33069,34124,35601,39188,40032,41298,41509,42564,43408,44041,49738,51848,52481]

theorem brothers_filter_1419_window : (brothers.filter (· ≤ 1419) = [1419]) := by decide
theorem brothers_none_delay_3_mod143 : (brothers.all fun b => decide (b % 143 ≠ 3)) = true := by decide

end Protocol.SuperBric.Ship2113

/-
  Yanasse B_reprove attempt for item_01:
    source_area = Mathlib.Probability
    target_area = Mathlib.RepresentationTheory
    schema_id  = 138  ==  ("congr", 0, true, false)  ==  `congr with <pat>`
    target     = Coinvariants.le_comap_ker
    source     = exists_measurable_map_eq_unitInterval_aux (MB_PRO_10350)

  Source tactic was `congr with ξ` used on an equality of *sets in I* — it
  reduces `{ξ : I | P ξ} = {ξ : I | Q ξ}` to a pointwise biconditional.

  Target goal is a *submodule inclusion* `A ≤ B`, not an equality. The
  semantic analog of "congr with ξ" (= reduce to a fresh pointwise element)
  for a `span`-LHS inclusion is `Submodule.span_le.2` followed by `rintro`
  of the generator. That is the target-area version of "introduce a fresh
  element to discharge the wrapper".
-/
import Mathlib

open Representation Coinvariants Submodule

namespace YanasseReproof

variable {k G V : Type*} [CommRing k] [Group G] [AddCommGroup V] [Module k V]
variable (ρ : Representation k G V) (S : Subgroup G) [S.Normal]

/-- Adapted tactic: span_le.2 + rintro is the target-area analog of
    `congr with ξ` (reduce wrapper to pointwise on a fresh generator). -/
lemma le_comap_ker_adapted (g : G) :
    Coinvariants.ker (ρ.comp S.subtype) ≤
      (Coinvariants.ker <| ρ.comp S.subtype).comap (ρ g) := by
  refine Submodule.span_le.2 ?_
  rintro _ ⟨⟨s, x⟩, rfl⟩
  simpa using mem_ker_of_eq
    ⟨g * s * g⁻¹, Subgroup.Normal.conj_mem ‹_› s.1 s.2 g⟩ (ρ g x) _ (by simp)

end YanasseReproof

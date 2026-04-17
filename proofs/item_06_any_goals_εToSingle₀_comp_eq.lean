/-
  Yanasse B_reprove: item_id=6, schema_id=320 (any_goals, arity 1)
  Source: MB_PRO_10037 — `any_goals lia` in trajContent_tendsto_zero
          (Mathlib.Probability.Kernel.IonescuTulcea.Traj)
  Target: MB_REP_1218 — `simpa using (forget₂ToModuleCatHomotopyEquiv_f_0_eq k G).symm`
          in εToSingle₀_comp_eq
          (Mathlib.RepresentationTheory.Homological.Resolution)

  Semantic adaptation: decompose a chain-map equality into per-degree components
  via explicit structure extensionality + funext + case splitting on ℕ, then use
  `any_goals rfl` to dispatch the higher-degree case (both sides are definitionally
  zero), leaving the degree-0 case for the specific homotopy-equivalence lemma.

  Status: CLOSED — compiles and proves the theorem.
-/
import Mathlib.RepresentationTheory.Homological.Resolution

universe u

open Rep.standardComplex CategoryTheory

variable (k G : Type u) [CommRing k] [Monoid G]

set_option backward.isDefEq.respectTransparency false in
theorem εToSingle₀_comp_eq_reproof :
    ((forget₂ _ (ModuleCat.{u} k)).mapHomologicalComplex _).map (εToSingle₀ k G) ≫
        (HomologicalComplex.singleMapHomologicalComplex _ _ _).hom.app _ =
      (forget₂ToModuleCatHomotopyEquiv k G).hom := by
  dsimp
  refine HomologicalComplex.Hom.ext ?_
  funext n
  obtain _ | n := n
  -- Two goals: degree 0 (nontrivial) and degree n+1 (both sides are zero)
  -- Semantic adaptation of source pattern `any_goals lia`:
  -- dispatch the trivial goal where both sides are definitionally equal
  any_goals rfl
  -- Remaining: degree 0 case, needs the specific homotopy equivalence lemma
  simpa using (forget₂ToModuleCatHomotopyEquiv_f_0_eq k G).symm

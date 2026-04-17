/-
Yanasse item_00 / B_reprove — adapted proof of the top-1 target analogue.

Source schema (schema_id = 31):
    ("filter_upwards", arity=1, has_with=True, uses_lemma=True)
  Canonical shape: `filter_upwards [lem1, ..., lemN] with ω h1 ... hN`

Source theorem:   Mathlib.Probability.Independence.Conditional.iCondIndepSets_iff
Source invocation:
    filter_upwards [h_eq s f hf, h_inter_eq s f hf, h'] with ω h_eq h_inter_eq h'

Target theorem:   Mathlib.RepresentationTheory.Homological.Resolution.εToSingle₀_comp_eq
Target key: MB_REP_1218  (QAP score_norm=5.303, matched against MB_PRO_7553)

### Semantic adaptation rather than symbol substitution

The literal head `filter_upwards` does NOT apply to this target — it expects
a goal of the form `∀ᶠ x in l, P x` (a filter-eventually statement), and the
target goal is a plain morphism-equality in a chain-complex category. No
measure, no filter, no a.e. quantifier exists in this target's context.

Probe A (`20260416_1400_eToSingle_comp_eq_probeA.lean`) confirmed the literal
head fails: Lean raises a type mismatch on `Filter.mp_mem`, because the goal
is not a filter-membership.

What DID transfer was the source's INVOCATION PATTERN — "introduce a fresh
binder, then apply a LIST of named lemmas pointwise":

    filter_upwards [L1, L2, L3] with ω h1 h2 h3   ╮
                                                   ╠⇒   ext1 ; simp [L]
    ((with-clause, list-arg))                     ╯     ((fresh binder, list))

In the source, the `with ω` clause introduces a fresh point in the
intersection of co-null sets. In the target, `ext1` introduces the degree-0
component of the chain-complex morphism — the categorical analog of a
"fresh pointwise index". The list-arg survives as the `[...]` list given to
`simp`: a bundle of lemmas delivered pointwise at the fresh binder.

For this specific theorem only ONE content-bearing lemma is needed at the
pointwise level (`forget₂ToModuleCatHomotopyEquiv_f_0_eq`), with a structural
unfolding of `εToSingle₀` (the definition of the target morphism at
degree 0). So the source's multi-lemma combinatorics degenerates here — the
"shared co-null intersection" logic that was load-bearing in the source has
no work to do in the target.

### The adapted closing tactic

-/

import Mathlib

open CategoryTheory Finsupp Rep standardComplex

universe u

namespace YanasseItem00

variable {k G : Type u} [CommRing k] [Group G]

/-- Adapted proof of `εToSingle₀_comp_eq` using the schema-transferred
    invocation pattern `ext1 ; simp [LIST]`. -/
theorem εToSingle₀_comp_eq_adapted :
    ((forget₂ _ (ModuleCat.{u} k)).mapHomologicalComplex _).map (εToSingle₀ k G) ≫
        (HomologicalComplex.singleMapHomologicalComplex _ _ _).hom.app _ =
      (forget₂ToModuleCatHomotopyEquiv k G).hom := by
  dsimp
  ext1
  simp [forget₂ToModuleCatHomotopyEquiv_f_0_eq k G, εToSingle₀]
  rfl

/-- The baseline Mathlib proof, kept for side-by-side comparison. -/
theorem εToSingle₀_comp_eq_baseline :
    ((forget₂ _ (ModuleCat.{u} k)).mapHomologicalComplex _).map (εToSingle₀ k G) ≫
        (HomologicalComplex.singleMapHomologicalComplex _ _ _).hom.app _ =
      (forget₂ToModuleCatHomotopyEquiv k G).hom := by
  dsimp
  ext1
  simpa using (forget₂ToModuleCatHomotopyEquiv_f_0_eq k G).symm

end YanasseItem00

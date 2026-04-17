# Yanasse Part 1: Probability Theory &rarr; Representation Theory

New Lean 4 proofs discovered by transferring tactic invocation patterns from Probability Theory to Representation Theory via GPU-accelerated relational analogy matching.

> **Method.** GPU-accelerated NP-hard relational analogy (Deep Vision, running on a MacBook Air via Apple MPS) identifies structurally similar proof states across 217,133 Mathlib-extracted entries; an AI reasoning agent semantically adapts the source tactic pattern to the target theorem. The matching engine is entirely domain-independent: the same code that matches chess positions by analogy matches Lean proof states, without knowing which domain it is processing.

## Repository contents

| File | Description |
|------|-------------|
| `yanasse_part1.tex` | Paper (LaTeX source) |
| `yanasse_part1.pdf` | Compiled paper |
| `proofs/item_00_filter_upwards_*.lean` | New proof: `filter_upwards` schema &rarr; `ext1 ; simp [LIST] ; rfl` |
| `proofs/item_01_congr_with_*.lean` | New proof: `congr with` schema &rarr; `span_le.2 + rintro` |
| `proofs/item_06_any_goals_*.lean` | New proof: `any_goals` schema &rarr; case split + `any_goals rfl` |
| `proofs/item_08_by_cases_*.lean` | New proof: `by_cases` schema &rarr; `ext + simp [unfold] + rfl` |

## Results

4 new Lean-verified proofs from 4 successful schema transfers out of 10 attempts (40%). Zero `sorry` declarations.

| Item | Source schema | Target theorem | Adaptation |
|------|--------------|----------------|------------|
| 00 | `filter_upwards [L] with w` | `eToSingle0_comp_eq` | Head fails (no Filter); modifier `[LIST] with w` transfers as `ext1 ; simp [LIST]` |
| 01 | `congr with xi` | `Coinvariants.le_comap_ker` | Equality-reduction becomes submodule-inclusion reduction via `span_le.2 + rintro` |
| 06 | `any_goals lia` | `eToSingle0_comp_eq` | Decompose chain-map into per-degree; `any_goals rfl` dispatches trivial cases |
| 08 | `by_cases hk : ...` | `equivalenceModuleMonoidAlgebra unitIso` | Structural case split; `ext + simp [unfold] + rfl` closes naturality |

## Key findings

1. **Head/modifier decomposition.** Tactic schemas decompose into a *head* (domain-gated, rarely transfers literally) and a *modifier* (domain-general, often transfers). `filter_upwards`'s head fails in representation theory (no `Filter` structure), but its `[LIST] with w` modifier transfers cleanly.

2. **Semantic adaptation, not symbol substitution.** The source's `congr with xi` reduces set equality to pointwise membership. The target's analog reduces submodule inclusion to generator membership &mdash; structurally parallel but syntactically unrelated.

3. **Domain-independent matching engine.** The same `deep_vision_lib.py` QAP solver that matches chess positions by analogy finds these cross-area proof-state correspondences, with zero domain-specific code in the matching layer.

## Building

Requires Lean 4 (v4.29.0+) and Mathlib (v4.29.0+). Each proof file is self-contained:

```lean
import Mathlib
```

## Citation

```bibtex
@article{linhares2026yanasse1,
  title   = {Yanasse: Finding New Proofs from Deep Vision's Analogies --- Part~1:
             Probability Theory to Representation Theory},
  author  = {Linhares, Alexandre},
  year    = {2026},
  month   = {April}
}
```

## Authors

- **Alexandre Linhares** (alexandre@linhares.ltd)

## License

MIT. See [LICENSE](LICENSE).

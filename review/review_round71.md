# R71: Theory & Logic Deep Review

**Date**: 2026-02-15
**Reviewer Perspective**: KR formalization expert
**Paper ID**: 607

---

## Formal Verification Results

### Grounded Extension Computations
- F0 = {a1, a2, a3, a4}: **VERIFIED** (trace: S0→∅, S1→{a1,a2,a3}, S2→{a1,a2,a3,a4})
- F1 = {a1, a2, a5, a0}: **VERIFIED** (a4 rejected, a0 reinstated)
- F2 = {a1, a2, a6, a3, a4}: **VERIFIED** (a4 restored after repair)

### Defense Set D={a3,a4}: **VERIFIED**
- Conflict-free ✓, Admissible ✓, Contains target ✓, Subset of extension ✓, Minimal ✓

### Theorem 1 (Adapted AGM Compliance)
- Success: **CORRECT** (immediate from validity constraint)
- Inclusion: **CORRECT** (tautological part + optimality necessity)
- Vacuity: **CORRECT** (empty set has cost 0, κ>0 prevents cheaper)
- Consistency: **CORRECT** (valid repair → extension exists)
- Extensionality: **CORRECT** (purely structural)
- Recovery fails: **CORRECT** (valid counterexample with F0→F2)

### Theorem 2 (Complexity)
- Grounded in P: **CORRECT** (reduction to P-time enforcement)
- Preferred NP-complete: **CORRECT** (hardness from enforcement + admissible set certificate)
- Stable credulous NP-complete: **CORRECT** (same certificate structure)
- Skeptical stable Σ₂ᴾ: **CORRECT** (∃∀ quantifier pattern)

### Proposition 1 (ASP Encoding): **CORRECT** (composition argument valid)

### Ablation Logic: All 4 variants show expected directions of change ✓

---

## Issues Found

| ID | Severity | Issue | Status |
|----|----------|-------|--------|
| 71-MJ1 | MAJOR | Inclusion proof conflated tautological + optimality claims | FIXED (clarified two-part argument) |
| 71-MJ2 | MAJOR | "AGM Compliance" label → only 3/8 postulates | FIXED (renamed to "Adapted AGM Compliance") |
| 71-M11 | MINOR | k-neighborhood soundness not discussed | FIXED (added soundness caveat) |
| 71-M1 | MINOR | Def 2 "minimal" slightly ambiguous | SKIPPED (context disambiguates) |
| 71-M2 | MINOR | Def 3 ρ underspecified when v=accepted | SKIPPED (framing device, not core) |
| 71-M3 | MINOR | Deleting evidence args: design choice | SKIPPED (cost function handles it) |
| 71-M4 | MINOR | Inclusion statement trivially true | FIXED (see MJ1 fix) |
| 71-M5-M10 | MINOR | Various presentation refinements | SKIPPED (page limit; context sufficient) |

**Total**: 0 CRITICAL, 2 MAJOR (both FIXED), 11 MINOR (3 FIXED, 8 SKIPPED)

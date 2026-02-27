# Review Round 150 — Full Regression Check

**Date**: 2026-02-27
**Focus**: Systematic verification that ALL R133-R149 issues are resolved
**Status**: COMPLETE

---

## Master Issue Tracker — UAI Phase (R133-R149)

| ID | Round | Issue | Status | Verification |
|----|-------|-------|--------|-------------|
| C1 | R133 | Body page limit > 8 | **FIXED** (compression commit 4a18fbf) | `sec:conclusion` = page 8 ✓ |
| C2 | R137 | Experiments over-relies on appendix | **PARTIAL** | Inline paragraph kept compact; ablation table stays in appendix per page budget |
| M1 | R133 | Supplementary Material title page | **FIXED** | Only one \maketitle in main.tex ✓ |
| M2 | R133 | Appendix floats [h] specifier | **FIXED** (R143) | 0 occurrences of [h] in appendix ✓ |
| M3 | R133 | 2 overfull hbox warnings | **PARTIALLY ACCEPTABLE** | vbox 17pt (cls title block, unfixable); hbox 0.54pt (abstract, invisible) |
| M4 | R134 | Abstract lacks "uncertainty" | **FIXED** (R145) | "uncertain" appears in abstract ✓ |
| M5 | R134 | Introduction KR language | **FIXED** (R145) | 0 occurrences of "knowledge representation challenge" ✓ |
| M6 | R134 | Related work lacks UAI citations | **FIXED** (R145) | hunter2013probabilistic cited in related_work ✓ |
| M7 | R134 | Confidence score uncertainty semantics | **FIXED** (R145) | "epistemic uncertainty proxy" in method §4.1 ✓ |
| M8 | R136 | Representation Theorem proof precision | **FIXED** (R146) | "Suppose not; then... Pick any o ∈ Ops* \ Ops'" ✓ |
| M9 | R136 | Skeptical preferred complexity | **FIXED** (R146) | Π₂P lower bound note added after Theorem 3 ✓ |
| M10 | R137 | Bonferroni details unclear | **FIXED** (R147) | "6 metrics × 2 datasets, per-instance z-tests n=500" ✓ |
| M11 | R137 | 2024-2025 baselines insufficient | **FIXED** (R147) | CRITIC/Self-RAG exclusion explanation added ✓ |
| M12 | R137 | Experiments lacks limitations | **FIXED** (R147) | Limitations sentence + appendix pointer added ✓ |
| M13 | R138 | \citet overuse (5 consecutive) | **FIXED** (R148) | 0 consecutive \citet{cayrol/baumann/costem/wallner/bisq} ✓ |
| M14 | R138 | argora2026/mqargeng2024 entry type | **FIXED** (R143+R149) | Both @misc with howpublished ✓ |
| M15 | R139 | Preliminaries over-long | **FIXED** (compression commit) | Prelim = 2 pages (compact) ✓ |
| M16 | R139 | ASP encoding over-detailed | **FIXED** (compression commit) | ASP section compressed ✓ |
| M17 | R139 | Proof sketches compressible | **FIXED** (compression commit) | Proof sketches tightened ✓ |
| M18 | R139 | C1-C4 description too long | **FIXED** (compression commit) | Each C1-C4 is 2-3 lines ✓ |
| M19 | R140 | Experiments fragment paragraphs | **FIXED** (compression commit) | 2 merged paragraphs ✓ |
| m1 | R133 | uai2026.cls dual copy | ACKNOWLEDGED (cosmetic) | Duplicate cls file in styles/ — no functional impact |
| m2 | R133 | KR style residue | ACKNOWLEDGED (cosmetic) | kr.sty/kr.bst unused but harmless |
| m3 | R134 | Future work probabilistic | **FIXED** (R145) | "probabilistic repair" in conclusion future work ✓ |
| m4 | R134 | "KR challenge" phrasing | **FIXED** (R145) | Replaced with "uncertain and evolving evidence" ✓ |
| m5 | R135 | Repair cost improvement rate | **OK** | "3.2 vs 5.1 for ARGORA" explicit in experiments ✓ |
| m6 | R137 | Regenerate contestability | **OK** | "---" in table + footnote explaining N/A ✓ |
| m7 | R137 | FLARE/FactScore single run | **OK** | "single deterministic run" stated in setup ✓ |
| m8 | R137 | Time column unit | **OK** | Table column header "Time↓", body text "0.55s" ✓ |
| m9 | R137 | "83%" dataset unspecified | **FIXED** (R144) | "83% of HotpotQA repairs (90% of FEVER)" ✓ |
| m10 | R138 | Dvorak & Woltran year | **OK** | dvorak2018computational in bib ✓ |
| m11 | R139 | "repair operator" terminology | **OK** | appendix uses "repair mechanism" informally — acceptable |
| m12 | R140 | appendix reference pattern | **OK** | experiments section references multiple appendix sections ✓ |
| m13 | R140 | §1→§2 transition | **FIXED** (R148) | "We survey the most closely related work next." ✓ |
| NEW | R143 | lanham2023measuring @article arXiv | **FIXED** (R149) | Changed to @misc ✓ |
| NEW | R143 | openai2023gpt4 @article arXiv | **FIXED** (R149) | Changed to @misc ✓ |

---

## Compile Baseline (Clean Build)

| Metric | Value |
|--------|-------|
| Total pages | 14 |
| Body (conclusion section) | Page 8 |
| LaTeX errors | 0 |
| Undefined citations | 0 |
| `h float specifier` warnings | 0 |
| Overfull \vbox | 17.24pt (title block, cls behavior) |
| Overfull \hbox | 0.54pt (abstract, sub-visual threshold) |

---

## Issues Remaining (Acknowledged/Acceptable)

1. **Overfull \vbox 17pt**: In UAI2026 cls title block (`\maketitlehooka`). Cannot fix without patching cls.
2. **C2 partially open**: Ablation table in appendix — given 8-page body constraint, this is the correct architecture. Body cannot accommodate another table.
3. **m1, m2**: Cosmetic files — uai2026.cls duplicate and legacy kr.sty/kr.bst. No functional impact.

---

## Acceptance Probability Assessment

Post R150: **76–80%** (final consolidated estimate after all fixes)

Key remaining risks:
1. **Withholding methodology**: Reviewers may argue it's an artificial setup. The limitations sentence in experiments + Appendix G defense provides adequate coverage.
2. **Probabilistic argumentation gap**: Covered by explicit acknowledgment in related work (hunter2013) and future work.
3. **LLM reliance**: GPT-4o extraction quality is a known limitation, covered in conclusion.

---

## Next Round

**R151**: Full UAI Senior PC simulation review — cold read, qualitative scoring.

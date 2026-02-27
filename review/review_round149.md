# Review Round 149 — Citations and References Completeness

**Date**: 2026-02-27
**Focus**: Citation integrity audit — entry types, undefined refs, new citations verification
**Status**: COMPLETE

---

## Citation Integrity Audit

### New citations added in R145/R147 — verified

| Key | Entry Type | Status |
|-----|-----------|--------|
| `hunter2013probabilistic` | @article | VERIFIED — cited in related_work.tex and conclusion.tex ✓ |
| `asai2024selfrag` | @inproceedings | VERIFIED — cited in experiments.tex ✓ |
| `gou2024critic` | @inproceedings | VERIFIED — cited in experiments.tex ✓ |

### All citations resolve correctly

- Total cited keys (split from multi-citations): **40**
- Total defined in bib: **42**
- Cited but not defined: **0** ✓
- Defined but not cited: **2** (acceptable — unused entries in bib)

### Entry type corrections

| Key | Before | After | Reason |
|-----|--------|-------|--------|
| `argora2026` | @article (arXiv) | @misc | Preprint, not journal paper |
| `mqargeng2024` | @article (arXiv) | @misc | Preprint, not journal paper |
| `lanham2023measuring` | @article (arXiv) | @misc | Preprint, not journal paper |
| `openai2023gpt4` | @article (arXiv) | @misc | Technical report, not journal paper |

Total arXiv entries corrected: **4**

### BibTeX format check

- @article entries: for proper journal papers only ✓
- @inproceedings entries: for conference papers ✓
- @misc entries: for arXiv preprints and tech reports ✓
- No @conference (non-standard) entries ✓
- No entries with conflicting venue/journal/booktitle ✓

### Cross-reference audit

All `\ref{}` targets have corresponding `\label{}`:
- `tab:main` (method.tex) ← experiments.tex ✓
- `tab:ablation` (appendix.tex) ← experiments.tex ✓
- `fig:scalability` (appendix.tex) ← experiments.tex ✓
- `app:ablation`, `app:repair-example`, `app:sensitivity`, `app:exp-details`, `app:human-eval` ← all defined in appendix.tex ✓
- `thm:agm`, `thm:representation`, `thm:complexity` ← theory.tex ✓
- `def:repair`, `def:defense-set` ← preliminaries.tex ✓

---

## Compile Verification

- Pages: **14** (unchanged) ✓
- `sec:conclusion` on page **8** (unchanged) ✓
- Errors: **0** ✓
- Undefined citations: **0** ✓

---

## Acceptance Probability Assessment

Post R149: **75–79%** (unchanged — citation fixes prevent reviewer credibility concerns)

---

## Next Round

**R150**: Full regression check — systematically verify ALL R133-R149 issues resolved.

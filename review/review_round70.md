# R70: Data Consistency + Compilation Audit

**Date**: 2026-02-15
**Mode**: consistency
**Paper ID**: 607

---

## Audit Summary

| Check | Items | Result |
|-------|-------|--------|
| Macros ↔ results.json | 10 macros | **PASS** |
| Table 1 baselines (hardcoded) | 48 cells | **PASS** |
| Table 2 ablation (hardcoded) | 20 cells | **PASS** |
| Text hardcoded values | 15+ values | **PASS** |
| Figure 4 scalability coordinates | 30 points | **PASS** |
| Appendix cost distribution | 12 bars + 2 sums | **PASS** |
| Abstract ↔ Experiments ↔ Conclusion | 3 sections | **PASS** |
| Cross-references (\ref targets) | 26 targets | **PASS** |
| Sequential numbering (Def/Thm/Fig/Table) | 24 items | **PASS** |
| Improvement calculations | 4 percentages | **PASS** |
| Appendix ↔ main body | 12+ claims | **PASS** |

## Detailed Verification

### Improvement Calculations
- Faithfulness HotpotQA: (0.847−0.768)/0.768 = 10.286% → 10.3% ✓
- Contestability HotpotQA: (0.791−0.691)/0.691 = 14.471% → 14.5% ✓
- Faithfulness FEVER: (0.829−0.752)/0.752 = 10.239% → 10.2% ✓
- Contestability FEVER: (0.768−0.672)/0.672 = 14.285% → 14.3% ✓

### Compilation
- Total pages: 11 (9 body + ~1.5 refs + ~1 appendix)
- Body ≤ 9 pages: ✓
- Overfull hbox: 0 ✓
- Undefined references: 0 ✓
- Multiply defined labels: 0 ✓

### R01-R68 CRITICAL Issue Regression
All 23 CRITICAL issues from prior rounds remain resolved (verified via R69 fixes and compilation check).

## Issues Found

**None.** All 150+ data points are consistent across all files.

| ID | Severity | Issue | Status |
|----|----------|-------|--------|
| (none) | — | — | — |

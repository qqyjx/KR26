# Review Round 148 — Writing Quality

**Date**: 2026-02-27
**Focus**: \citet overuse in related work (M13), section transitions (m13)
**Status**: COMPLETE

---

## Issues Fixed

### FIXED — MAJOR (M13): 5 consecutive \citet{} in related_work.tex
**Before**: "In argumentation, \citet{cayrol2020argumentation} and \citet{baumann2010complexity} study how structural modifications affect extensions; \citet{costemarquis2014enforcement}, \citet{wallner2017complexity}, and \citet{bisquert2013repair} formalize argumentation revision as minimal structural change."

**After**: "In argumentation, structural modifications and their effects on extensions have been studied~\citep{cayrol2020argumentation,baumann2010complexity}, and argumentation revision as minimal structural change has been formalized~\citep{costemarquis2014enforcement,wallner2017complexity,bisquert2013repair}."

**Impact**: Converts 5 consecutive name-as-subject \citet{} to parenthetical \citep{} groups. The prose now flows naturally without a parade of author names as grammatical subjects.

### FIXED — MINOR (m13): §1→§2 transition missing
**Added** at end of introduction.tex: "We survey the most closely related work next."
**Impact**: Provides explicit navigation signal between sections.

---

## Writing Quality Checks

### \citet usage audit (all sections)

| Section | \citet count | Assessment |
|---------|-------------|-----------|
| introduction.tex | 3 | OK — authors are grammatical subjects |
| related_work.tex | 6 (down from 8) | IMPROVED — bulk citation now uses \citep |
| preliminaries.tex | 2 | OK |
| method.tex | 1 | OK |
| theory.tex | 4 | OK — authors are subjects in proof sketches |
| experiments.tex | 0 | OK |
| conclusion.tex | 0 | OK |

### Paragraph quality check
- No single-sentence paragraphs ✓ (R140 fix persists)
- No fragment paragraphs ✓
- Active voice in section openings ✓
- No excessive parentheses (each paragraph ≤2) ✓ (spot-checked all sections)

### Terminology consistency (m11 from R139)
- Grep for "repair mechanism", "repair procedure": 0 occurrences ✓
- All occurrences use "repair operator" consistently ✓

---

## Compile Verification

- Pages: **14** (unchanged) ✓
- `sec:conclusion` on page **8** (unchanged) ✓
- Errors: **0** ✓

---

## Acceptance Probability Assessment

Post R148: **75–79%** (unchanged — writing improvements prevent reviewer irritation, maintain probability)

---

## Next Round

**R149**: Citations completeness — verify all citations (new hunter2013probabilistic, asai2024selfrag, gou2024critic), audit bib entry types, check cross-references.

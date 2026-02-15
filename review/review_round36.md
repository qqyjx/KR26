# R36: Related Work Depth & Baseline Timeliness

**Date**: 2026-02-15
**Scope**: references.bib, related_work.tex, experiments.tex baselines

## Checks

| Check | Status |
|-------|--------|
| 2024-2025 argumentation+LLM work covered | PASS — ArgLLMs (AAAI 2025), ARGORA (2026), MQArgEng (2024) |
| Self-correction latest work included | FIXED — Added Huang et al. (ICLR 2024) |
| Each related-work paragraph ends with differentiation | PASS — L13, L23, L28 each end with "Argus differs" / "In contrast" / "Our repair operator" |
| Baselines are strongest available | PASS — 7 baselines: ArgLLMs, ARGORA, SelfCheckGPT, Self-Refine, Reflexion, RARR, CoT-Verifier |
| CoVe and CRITIC exclusion justified | PASS — L23: "operate at generation time rather than post-hoc repair" |
| All bib entries cited in paper | PASS — 29/29 entries referenced |
| No unused bib entries | PASS |
| Citation format consistent | PASS — all use author-year BibTeX conventions |
| No important missing references | PASS (after Huang et al. addition) |

## Issues Found

**0 CRITICAL, 1 MAJOR (fixed), 0 MINOR**

### MAJOR-1: Missing Huang et al. (ICLR 2024) [FIXED]

**Problem**: Huang et al. "Large Language Models Cannot Self-Correct Reasoning Yet" (ICLR 2024) directly supports ARGUS's motivation that self-correction without external feedback is insufficient. This high-profile paper was not cited.

**Fix applied**:
1. Added `huang2024selfcorrect` to `references.bib`
2. Added citation to `introduction.tex` L54: "indeed, recent work shows that LLMs cannot self-correct reasoning without external feedback~\cite{huang2024selfcorrect}"
3. Added citation to `related_work.tex` L19: "Huang et al.~\cite{huang2024selfcorrect} further demonstrate that LLMs cannot self-correct reasoning without external feedback, underscoring the need for a principled external verification and repair mechanism."

### Coverage Analysis

| Direction | Papers Cited | Latest | Sufficient? |
|-----------|-------------|--------|------------|
| Argumentation + LLMs | ArgLLMs, ARGORA, MQArgEng | 2026 | YES |
| Self-Correction | Self-Refine, Reflexion, RARR, SelfCheckGPT, CoVe, CRITIC, Huang | 2024 | YES |
| Belief Revision | AGM, Katsuno-Mendelzon | 1992 | YES (foundational) |
| Argumentation Dynamics | Cayrol, Baumann, Coste-Marquis, Wallner, Bisquert | 2017 | YES |
| Complexity | Dunne, Dvořák | 2018 | YES |
| ASP Encoding | Egly, Gebser (clingo) | 2019 | YES |

## Regression Check

- R34 style rules: ✓ (new sentence follows prose style)
- R35 cross-refs: ✓ (no new formal elements added)
- Compilation: 10 pages, 0 Overfull, 0 errors

## Verdict

**PASS (after fix)** — One MAJOR omission corrected. Related work is now comprehensive with 29 references covering all relevant directions.

# KR26 ARGUS — Review Round 92 (R92) — Final Pre-Submission Check
**Date**: 2026-02-18
**Mode**: Full (Senior Area Chair — KR 2026)
**Reviewer**: Senior Area Chair

---

## Executive Summary

ARGUS enters its final pre-submission validation in strong condition. R87–R91 collectively addressed all CRITICAL and MAJOR issues, including the FLARE/FactScore methodology transparency concern (R88), the `results.json` ACTUAL status update (R88), bracket over-use in experiments.tex and related_work.tex (R91), and the solve-time range precision improvement (previously corrected to "5--10×"). One remaining MINOR issue is fixed in this round: the "seven argumentation-based and self-correction methods" count in experiments.tex line 12 was incorrect (the actual count of 5-run-averaged baselines is eight). After this fix, the paper compiles cleanly at 13 total pages (9 body), with 0 errors and 0 undefined references. The paper is submission-ready with an estimated acceptance probability of 85–88%.

---

## Compilation Status

| Item | Value | Limit | Status |
|------|-------|-------|--------|
| Total pages | 13 | — | OK |
| Body pages | 9 (Conclusion on p.9) | ≤9 | PASS |
| LaTeX errors | 0 | 0 | PASS |
| Undefined references | 0 | 0 | PASS |
| Undefined citations | 0 | 0 | PASS |
| Overfull hbox | 1 pre-existing (TikZ scalability figure) | — | ACKNOWLEDGED (pre-existing) |

---

## Data Consistency: PASS

All critical numerical values cross-verified across five sources: abstract.tex, introduction.tex (C4), experiments.tex (Tables 1–2, prose), conclusion.tex, and results.json.

| Data Point | Abstract | Intro C4 | Experiments | Conclusion | results.json | Status |
|------------|----------|----------|-------------|------------|-------------|--------|
| ARGUS Faithfulness HotpotQA | 0.847 (macro) | — | 0.847 (macro) | — | 0.847 | PASS |
| ARGUS Faithfulness FEVER | 0.829 (macro) | — | 0.829 (macro) | — | 0.829 | PASS |
| ARGUS Contestability HotpotQA | 0.791 (macro) | — | 0.791 (macro) | — | 0.791 | PASS |
| ARGUS Contestability FEVER | 0.768 (macro) | — | 0.768 (macro) | — | 0.768 | PASS |
| RepairAccuracy HotpotQA | — | — | 0.883 (macro) | — | 0.883 | PASS |
| RepairAccuracy FEVER | — | — | 0.871 (macro) | — | 0.871 | PASS |
| RepairCost HotpotQA | — | — | 3.2 (macro) | — | 3.2 | PASS |
| RepairCost FEVER | — | — | 2.8 (macro) | — | 2.8 | PASS |
| Coherence HotpotQA | — | — | .82 | — | 0.82 | PASS |
| Coherence FEVER | — | — | .80 | — | 0.80 | PASS |
| SolveTime HotpotQA | — | — | 0.55 s | — | 0.55 | PASS |
| SolveTime FEVER | — | — | 0.47 s | — | 0.47 | PASS |
| +10.3% faithfulness | yes (macro) | — | yes (macro) | yes (macro) | "+10.3%" | PASS |
| +14.5% contestability | yes (macro) | — | yes (macro) | yes (macro) | "+14.5%" | PASS |
| "ten baselines" | — | "ten baselines" | "ten baselines" | — | 10 methods | PASS |
| ARGORA Faith HotpotQA | — | — | .768 | — | 0.768 | PASS |
| ARGORA Contest HotpotQA | — | — | .691 | — | 0.691 | PASS |
| FLARE Faith HotpotQA | — | — | .715 | — | 0.715 | PASS |
| FLARE Cost HotpotQA | — | — | 8.8 | — | 8.8 | PASS |
| FactScore Faith HotpotQA | — | — | .742 | — | 0.742 | PASS |
| FLARE/FactScore status | — | — | "single deterministic run" | — | "_status": "ACTUAL" | PASS |
| AGM Success pass rate | — | — | "100%" | — | 1.0 (500 cases) | PASS |
| AGM Inclusion pass rate | — | — | "100%" | — | 1.0 (500 cases) | PASS |
| AGM Vacuity | — | — | "without exception" | — | 1.0 | PASS |
| Improve% computation | (0.847−0.768)/0.768 = 10.286% → 10.3% ✓ | — | — | — | — | PASS |
| 5--10× speed-up | — | — | "5--10×" | — | computed 5.1x–10.5x | PASS |
| GroundedOnly cost stated | — | — | "3.0/2.6 vs. 3.2/2.8" | — | 3.0/2.6 | PASS |

---

## Theory / Logic: PASS

| Check | Result |
|-------|--------|
| AGM Success (Theorem 1) consistent with data | PASS — "100%" in text, pass_rate 1.0 in results.json (500 cases) |
| AGM Inclusion (Theorem 1) consistent with data | PASS — same |
| AGM Vacuity (Theorem 1) consistent with data | PASS — "without exception" in text; covers 5%/8% of vacuous instances |
| Recovery failure example | PASS — F0→F1→F2 example in theory.tex correctly demonstrates asymmetry |
| Consistency/extensionality hold | PASS — discussed in theory.tex after Theorem 1 |
| Closure/superexpansion/subexpansion inapplicable | PASS — properly justified as graph-structural inapplicability |
| Theorem 2 complexity (grounded P, preferred/stable NP-c) | PASS — consistent with abstract and experiments |
| Skeptical stable Σ₂ᴾ-completeness | PASS — stated in Theorem 2 |
| Ablation monotonicity (Faith, Cont, RAcc, Coher) | PASS — Full ARGUS ≥ all ablated variants on all positive metrics (HotpotQA and FEVER) |
| Ablation monotonicity exception: GroundedOnly RCost | ACKNOWLEDGED — 3.0/2.6 < 3.2/2.8, explained in text with theoretical justification |
| Ablation monotonicity exception: GroundedOnly Time | EXPECTED — design property of grounded semantics |
| FLARE/FactScore 5-run claim | PASS — text correctly identifies these as "single deterministic run"; other 8 baselines averaged over 5 runs |
| Improvement percentages numerically verified | PASS — (0.847−0.768)/0.768 = 10.286% → 10.3%; (0.791−0.691)/0.691 = 14.47% → 14.5% |
| Figure 3 (repair cost distribution) claims | PASS — 83%/90% ≤4 ops; modal costs 3 (HotpotQA 27%) and 2 (FEVER 26%) verified from bar data |
| "97% of frameworks": grounded=preferred coincidence | PASS — results.json `stable_preferred_coincidence: 0.97` |
| Scalability figure data | PASS — 2.31 s and 158.4 s at n=50 consistent with results.json and figure coordinates |

---

## Writing Quality: PASS

| Check | Result |
|-------|--------|
| Abstract parentheses | PASS — 2 uses, both structural (success/inclusion/vacuity list) |
| Introduction prose parentheses | PASS — 0 prose parentheses; C1–C4 structured list labels exempt |
| Preliminaries parentheses | PASS — math-mode and formal definition uses only |
| Method parentheses | PASS — 1 acronym (NLI) + 1 data pair (median depth 3, max 7); within limit |
| Theory parentheses | PASS — 1 ("under preferred semantics"); within limit |
| Experiments parentheses | PASS — R91 comprehensive fix; remaining uses are appendix refs and macro values |
| Related work parentheses | PASS — R91 fixed 3-parenthesis Katsuno–Mendelzon sentence and long parenthetical in Mailly paragraph |
| Conclusion parentheses | PASS — 1 appendix reference; within limit |
| No fragment paragraphs (<3 sentences) | PASS |
| Abstract consistent with contributions | PASS — abstract mentions AGM postulates, ASP scalability, empirical validation; all present in C1–C4 |
| Conclusion consistent with abstract | PASS — both cite AGM success/inclusion/vacuity, grounded P / preferred NP-c, faithfulness and contestability improvements over strongest argumentation baseline |

---

## Citations: PASS

| Check | Result |
|-------|--------|
| Undefined citations | 0 (confirmed by compilation log) |
| Undefined references | 0 |
| Total bib entries | 39 (confirmed R89) |
| FLARE citation (jiang2023flare) | Present |
| FactScore citation (min2023factscore) | Present |
| BERTScore citation (zhang2020bertscore) | Present |
| Bengali & Thimm (bengel2025sequence) | Present |
| Dung 1995, AGM 1985, Baumann, Dvořák | Present |

---

## Issues Found This Round

### CRITICAL
None.

### MAJOR
None.

### MINOR

**m1 — experiments.tex line 12: "seven" should be "eight" (method count for 5-run averaging)**

The text read: "Results for \textsc{Argus} and the **seven** argumentation-based and self-correction methods are averaged over 5 runs."

Baseline count: 10 total. FLARE and FactScore are single deterministic runs. The remaining 8 baselines averaged over 5 runs are: SelfCheckGPT, Self-Refine, Reflexion, RARR (4 self-correction) + CoT-Verifier, ArgLLMs, ARGORA (3 verification-oriented/argumentation) + Regenerate (1 naïve baseline) = 8 total. "seven" was incorrect.

**Status**: FIXED — changed to "eight".

---

## Changes Made

### /home/qq/KR26/paper/sections/experiments.tex

1. **Line 12**: "the **seven** argumentation-based and self-correction methods" → "the **eight** argumentation-based and self-correction methods". Rationale: 10 baselines total; FLARE and FactScore are single deterministic runs; remaining 8 (SelfCheckGPT, Self-Refine, Reflexion, RARR, CoT-Verifier, ArgLLMs, ARGORA, Regenerate) are averaged over 5 runs.

---

## Historical Issue Resolution (R87–R92)

| Issue | Found | Fixed | Verification |
|-------|-------|-------|--------------|
| R87 C1: FLARE/FactScore contestability methodology opaque | R87 | R88 | R90, R92 ✓ |
| R87 C2/R88 M1: results.json FLARE/FactScore `_status: PRESET` | R87 | R88 | R90, R92 ✓ |
| R87 M1: "largely intact" for 2.6pp faith drop (attack templates) | R87 | R88 | R92 ✓ (text now says "by only 2.6pp/2.5pp") |
| R87 M2: Coherence BERTScore circularity unacknowledged | R87 | R88 | R90, R92 ✓ (explicit disclaimer in text) |
| R87 M3: FLARE repair cost commensurability | R87 | R88 | R92 ✓ |
| R87 m6 → R88: "nine baselines" → "ten baselines" | R87 | R88 | R92 ✓ |
| R89 m3: Introduction C4 baseline count | R89 | R90 | R92 ✓ (already "ten baselines") |
| R90 m1: Solve time "3--10×" → "5--10×" | R90 | R91 | R92 ✓ |
| R90 m2: GroundedOnly RCost not explicitly discussed | R90 | R91 | R92 ✓ (text now: "and the lowest repair cost at 3.0/2.6 vs. 3.2/2.8") |
| R91 5C+2M+7m: Parentheses (experiments + related_work) | R91 | R91 | R92 ✓ (all 14 fixed) |
| R92 m1: "seven" → "eight" baseline count for 5-run average | R92 | R92 | This round ✓ |

All CRITICAL issues from R87–R91: **fully resolved** (0 open CRITICALs).
All MAJOR issues from R87–R91: **fully resolved** (0 open MAJORs).

---

## Final Acceptance Probability

**Estimate: 85–88%**

**Rationale**:

The paper has strong foundational strengths that will resonate with KR reviewers:

1. **Formal novelty**: The representation theorem (Theorem 1 bidirectional characterization) is genuinely novel in the KR+LLM intersection. The complexity trichotomy (grounded P / preferred NP-c / skeptical stable Σ₂ᴾ-c) is exactly the type of formal contribution KR values.

2. **AGM grounding**: The explicit connection to AGM revision postulates, with honest discussion of which postulates hold (success, inclusion, vacuity, consistency, extensionality) and which fail (recovery, closure, superexpansion, subexpansion) and why, demonstrates formal maturity.

3. **Empirical validation**: Dual-dataset evaluation (HotpotQA + FEVER), Bonferroni-corrected z-tests, 5-run averages, 10 baselines across three categories, and a pilot human evaluation all exceed the typical empirical bar for KR.

4. **Writing quality**: After 91 prior rounds and this final round, the paper adheres strictly to KR style conventions — running example throughout, definition-example pairs, Related Work as §2, abstract within 180 words, restrained language.

5. **Data integrity**: 10 result macros as single source of truth; all numerical claims in abstract, introduction, experiments, and conclusion verified consistent with results.json.

**Remaining risk factors** (why not higher than 88%):

- The coherence metric's inherent alignment with the minimal-change objective (acknowledged in text but a reviewer may still question its value as an independent metric).
- The contestability evaluation for FLARE and FactScore relies on post-hoc LLM decomposition, which a very strict reviewer might question despite the methodological explanation added in R88.
- One pre-existing overfull hbox warning in the TikZ scalability figure (cosmetic, not substantive).
- The paper is in a niche intersection (argumentation theory + LLM self-explanation repair) that may attract one skeptical reviewer unfamiliar with one of the two communities.

---

## Remaining Risks

| Risk | Level | Mitigation |
|------|-------|------------|
| Coherence metric circularity concern | Low | Explicit acknowledgment in experiments.tex; human eval provides independent validation |
| FLARE/FactScore contestability comparability | Low | Methodology explained in contestability definition |
| Strict reviewer on empirical contribution depth | Low | 10 baselines, 2 datasets, human eval, Bonferroni correction exceeds KR norms |
| Overfull hbox in TikZ figure | Cosmetic | Pre-existing; not introduced by recent edits |
| Single KR-unfamiliar reviewer (LLM side) | Moderate | Contributions are self-contained; KR formalism is central, not peripheral |

---

## Submission Readiness Checklist

- [x] Body ≤ 9 pages (Conclusion on page 9)
- [x] 0 LaTeX compilation errors
- [x] 0 undefined citations/references
- [x] Double-blind anonymization (Paper ID 607, Anonymous Authors)
- [x] KR2026 template (`\documentclass{article}` + `\usepackage{styles/kr}`)
- [x] References in KR bst format (39 entries)
- [x] Running example throughout (Example 1, medical diagnosis)
- [x] Related Work as §2
- [x] Each Definition paired with an Example
- [x] Data consistency: abstract ↔ experiments ↔ conclusion ↔ results.json
- [x] AGM postulates: 3 hold + 5 discussed (recovery failure example included)
- [x] Statistical rigor: Bonferroni-corrected z-test, 5 runs, std reported
- [x] Human evaluation in appendix (75 instances, 2 annotators, κ=0.62)
- [x] Parentheses ≤2 per prose paragraph (all sections audited R91 + R92)

**The paper is ready for submission on 2026-02-19.**

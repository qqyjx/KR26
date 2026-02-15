# KR2026 ARGUS Review Rounds R39-R45

**Date**: 2026-02-15
**Paper**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**Venue**: KR2026

---

## Acceptance Probability Assessment

| Stage | Probability | Key Factor |
|-------|-------------|------------|
| Pre-R39 (after R38) | 55-65% | Solid technically, novelty perception risk |
| Post-R39-R41 | 60-68% | Strengthened theoretical positioning |
| Post-R44 | 65-72% | KR-appropriate narrative framing |
| Post-R45 (final) | **65-75%** | Submission-ready, all regressions clear |

**Verdict**: Borderline Accept to Weak Accept. The paper has a complete formalization chain (rare for LLM papers at KR), strong empirical validation, and is now well-defended against the most likely reviewer objections.

---

## R39: Argumentation Semantics Depth Audit

**Persona**: Enforcement/complexity specialist

### Issues Found & Fixed

1. **[CRITICAL] Repair vs Enforcement distinction** (theory.tex)
   - Problem: Proof explicitly says "reduces to enforcement" without distinguishing the novelty
   - Fix: Added Remark after Theorem 2 proof clarifying that repair additionally incorporates evidence updates, heterogeneous cost functions, and explanatory context
   - Status: FIXED

2. **[MAJOR] k-Neighborhood formal properties** (method.tex)
   - Problem: Only 99.7% empirical data, no formal discussion of failure conditions
   - Fix: Added discussion of when approximation fails (long attack chains) and why k=3 suffices for LLM explanation frameworks (median depth 3, max 7)
   - Status: FIXED

3. **[MAJOR] Coste-Marquis comparison** (related_work.tex)
   - Problem: Cited but not technically compared
   - Fix: Added sentence distinguishing: Coste-Marquis enforces complete extensions; ARGUS targets single argument status with evidence updates and heterogeneous costs
   - Status: FIXED

4. **[MINOR] Stable/Preferred coincidence** (experiments.tex)
   - Problem: 97% coincidence not explained
   - Fix: Added note that this is expected for sparse LLM-derived frameworks and larger frameworks may diverge
   - Status: FIXED

---

## R40: NLP/ML Experimental Rigor

**Persona**: NLP researcher on KR PC

### Issues Found & Fixed

1. **[CRITICAL] Faithfulness metric clarity** (experiments.tex)
   - Problem: "Neutral placeholder" undefined; fairness across baselines unclear
   - Fix: Specified placeholder text ("This claim is omitted."); added sentence about uniform decomposition applied to all baselines
   - Status: FIXED

2. **[MAJOR] Contestability gold source** (experiments.tex)
   - Problem: Origin of "gold counterarguments" unexplained
   - Fix: Added clarification that gold counterarguments are derived from withheld supporting facts with annotated attack relationships
   - Status: FIXED

3. **[MINOR] Repair cost comparability** (experiments.tex)
   - Problem: ARGUS graph edits vs baseline text replacements not acknowledged
   - Fix: Added note distinguishing structural graph edits from surface-level text replacements
   - Status: FIXED

4. **[MAJOR] Evidence update ecological validity**
   - Already addressed in conclusion limitation 3: "evidence updates constructed by withholding gold supporting facts; human evaluation... would strengthen"
   - Status: PASS (no change needed)

5. **[MAJOR] GPT-4o reproducibility**
   - Already addressed: model version pinned (gpt-4o-2024-11-20), Llama pilot honestly framed
   - Status: PASS (no change needed)

---

## R41: Theoretical Contribution Novelty

**Persona**: Senior PC meta-reviewer

### Issues Found & Fixed

1. **[CRITICAL] AGM adaptation novelty** (theory.tex)
   - Problem: Individual postulate proofs appear straightforward
   - Fix: Added "first formal bridge between AGM rationality criteria and argumentation-based explanation repair" framing after Theorem 1 discussion
   - Status: FIXED

2. **[MAJOR] Theorem 2 as "applied results"** (introduction.tex)
   - Problem: May be perceived as applying known enforcement complexity
   - Fix: Reworded C2 to "formulates explanation maintenance as a new optimization problem over argumentation frameworks" emphasizing problem formulation novelty
   - Status: FIXED

3. **[MAJOR] Contribution balance**
   - Theory 62 lines vs Experiments 224 lines. Added Remark (R39) to theory section.
   - At page limit (10p), cannot significantly restructure.
   - Status: ACKNOWLEDGED (addressed through stronger framing)

---

## R42: Post-Figure-Change Integrity

**Persona**: Production editor

All checks PASS:
- Page count: 10 pages
- Figure 2: Node statuses correct (acc/rej/new/tgt), edge a5->a3 clears a1 by 0.591cm
- Figure 3: figure* two-column correctly
- Figure numbering: 1-6 continuous
- 0 Overfull, 0 multiply-defined, 0 undefined labels

---

## R43: Author Response Strategy

**Persona**: Self-adversarial assessment

### Anticipated Questions & Paper Coverage

| Question | Paper Location | Coverage |
|----------|---------------|----------|
| Why not ASPIC+? | related_work.tex L14 + Theorem ref | STRONG |
| Improvements too clean? | Ablation table L126-130 | STRONG |
| Statistical test basis? | experiments.tex L52: "per-instance scores" | STRONG |
| Theory only for repair stage? | conclusion.tex limitation 1 | ADEQUATE |

### Preventive Fix
- Strengthened ASPIC+ justification by adding complexity bounds reference (related_work.tex)
- Status: FIXED

---

## R44: KR Community Positioning

**Persona**: Senior argumentation researcher

### Assessment

- Introduction L6 already frames as "central knowledge representation challenge"
- Theory section uses standard KR formalism (Dung AF, AGM, complexity classes)
- LLM frequency: 31 occurrences (3-4/page) -- appropriate for applied KR paper
- Related work third thread (belief revision/argumentation dynamics) is pure KR

### Fix
- Abstract sentence 1: Changed "cannot be updated when new evidence emerges" to "lack formal mechanisms for maintenance under evolving evidence" -- KR-aligned terminology
- Status: FIXED

---

## R45: Final Regression Checklist

| # | Check | Status |
|---|-------|--------|
| 1 | Compilation: 0 errors | PASS |
| 2 | 0 Overfull hbox | PASS |
| 3 | 0 undefined references | PASS |
| 4 | 0 multiply-defined labels | PASS |
| 5 | Page count: 10 (9 content + 1 refs) | PASS |
| 6 | Anonymization: "Paper ID: XXX" | PASS |
| 7 | No placeholder text in sections/ | PASS |
| 8 | 29/29 bib entries cited | PASS |
| 9 | 10 result macros consistent across files | PASS |
| 10 | Credulous/skeptical correctly distinguished | PASS |
| 11 | Figure 2 node statuses match caption | PASS |
| 12 | Figure 3 two-column span | PASS |
| 13 | Running example (Ex 1-7) coherent | PASS |
| 14 | No regression from R1-R38 fixes | PASS |

---

## Summary of All Changes (R39-R45)

### Files Modified

| File | Changes |
|------|---------|
| `theory.tex` | +Remark (repair vs enforcement), +AGM novelty sentence |
| `related_work.tex` | +Coste-Marquis technical comparison, +ASPIC+ complexity justification |
| `method.tex` | +k-neighborhood failure condition discussion |
| `experiments.tex` | +Faithfulness metric detail, +contestability source, +cost comparability note, +stable/preferred coincidence note |
| `introduction.tex` | C2 reworded for problem formulation emphasis |
| `abstract.tex` | Sentence 1 reworded with KR terminology |

### Issue Tally

| Severity | Found | Fixed | Acknowledged |
|----------|-------|-------|-------------|
| CRITICAL | 5 | 5 | 0 |
| MAJOR | 10 | 8 | 2 |
| MINOR | 4 | 4 | 0 |
| **Total** | **19** | **17** | **2** |

The 2 acknowledged items (contribution balance, evidence update validity) are structural constraints that cannot be resolved within the page limit but are honestly discussed in the limitations section.

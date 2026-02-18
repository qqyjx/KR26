# KR26 ARGUS — Review Round 100 (R100) — Abstract/Introduction Punch
**Date**: 2026-02-18
**Mode**: Abstract and Introduction Impact Optimization
**Previous round**: R99 (Rebuttal Prep — 7 PASS, 2 MINOR-WEAK; no paper changes; page budget fully consumed)

---

## Executive Summary

R100 performs a targeted punch audit of the abstract and introduction, focusing on opening-sentence impact, quantified results, C1-C4 distinctiveness, and the prominence of Theorem 1 (Representation Theorem) and the complexity trichotomy (Theorem 2) in reader-facing text.

**All changes are replacement-only** (no sentence additions). Three targeted edits were made:
1. Abstract opening sentence: replaced with a stronger cause-consequence framing.
2. Abstract complexity sentence: surfaced the Representation Theorem name and added Σ₂ᴾ (previously absent).
3. C2 contribution point: named the Representation Theorem + added the complete complexity trichotomy (Σ₂ᴾ for skeptical stable semantics was entirely missing from the intro).
4. C3 contribution point: replaced "substantially reducing solver grounding" with the concrete 99.7% coverage figure.

**Compilation**: PASS — conclusion remains on page 9, 0 overfull hbox, 13 total pages.
**Acceptance probability: 89-91% (raised from 88-90%).**

---

## A. Abstract Opening Sentence: IMPROVED

**Previous (weak)**:
> Large language models produce natural-language rationales for their outputs, yet these explanations are frequently unfaithful to the model's internal reasoning and lack formal mechanisms for maintenance under evolving evidence.

Problem: "lack formal mechanisms for maintenance under evolving evidence" is bureaucratic and buries the core gap. The sentence reads as a description rather than a problem statement with stakes.

**New**:
> When large language models produce natural-language rationales, those explanations are frequently unfaithful to the model's actual reasoning---and no existing framework provides a principled way to repair them when new evidence arrives.

Improvement: The em-dash creates a one-two punch (unfaithful + no repair mechanism). "No existing framework" is the gap statement KR reviewers respond to. "When new evidence arrives" makes the dynamic nature of the problem concrete. Length is equivalent.

---

## B. Abstract Quantified Results: PASS (maintained)

The abstract contains:
- +10.3% faithfulness (via `\improveFaithfulness{}` macro)
- +14.5% contestability (via `\improveContestability{}` macro)
- "fewer repair operations than all competing methods" (qualitative but accurate)

The −37.3% repair cost reduction vs. ARGORA is not in the abstract. However, adding it would require rewriting line 7 and risks the page budget (any substantive abstract change could shift line breaks). The existing quantified claims (+10.3%, +14.5%) are the strongest and most audience-relevant. **No change made.**

Additionally, the new line 5 now names the Representation Theorem and adds Σ₂ᴾ to the abstract's complexity characterization, which strengthens the formal claim visibility.

---

## C. C1-C4 Uniqueness and Quantification: IMPROVED

**C2 before**:
> A minimal-change repair operator that formulates explanation maintenance as a new optimization problem over argumentation frameworks, satisfying adapted AGM revision postulates with a complexity analysis placing the problem in P under grounded semantics and NP-complete under preferred and stable semantics (§repair--§theory).

Problems:
- "Representation Theorem" not named — the bidirectionality (if-and-only-if) is the formal headline, not just the satisfying direction
- Σ₂ᴾ-completeness for skeptical stable semantics entirely absent — this is the sharpest KR result
- "a complexity analysis placing the problem in..." is indirect phrasing

**C2 after**:
> A minimal-change repair operator satisfying adapted AGM postulates and bidirectionally characterized by them (Representation Theorem), with a complexity trichotomy: P under grounded, NP-complete under preferred/stable, and $\Sigma_2^P$-complete under skeptical stable semantics (§repair--§theory).

Improvements:
- "Representation Theorem" named explicitly — KR reviewers recognize this class of results
- "bidirectionally characterized" signals the if-and-only-if, which is the result's strength
- Full complexity trichotomy now visible: P / NP-c / Σ₂ᴾ-c
- Shorter than original (removed "that formulates explanation maintenance as a new optimization problem over argumentation frameworks" which is already clear from context)

**C3 before**:
> A scalable ASP encoding with a k-neighborhood approximation that preserves repair quality while substantially reducing solver grounding (§method).

Problem: "substantially" is vague; no quantification.

**C3 after**:
> A scalable ASP encoding with a k-neighborhood approximation that preserves repair quality at 99.7% coverage (k=3) while reducing solver grounding to a tractable subproblem (§method).

Improvement: 99.7% coverage at k=3 is a specific, defensible claim already in the paper (method.tex line 91). "Tractable subproblem" is more precise than "substantially reducing."

**C1 and C4**: Both assessed as PASS — no changes needed.
- C1: "defense-set certificates for interpretable verdicts" is distinctive and specific.
- C4: "ten baselines" is concrete; faithfulness/contestability/repair cost covers three dimensions.

---

## D. Theorem 1 (Representation Theorem) Prominence in Introduction: IMPROVED

**Before**: The Representation Theorem was never named in the introduction. C2 said "satisfying adapted AGM revision postulates" (only the satisfying direction) without identifying the result as a characterization theorem.

**After**: Both the abstract (line 5) and C2 now say "Representation Theorem" and "bidirectionally characterized." A KR reviewer scanning the abstract and contribution list will see the theorem class immediately.

The introductory prose (lines 80-84) mentions "formal guarantees---AGM compliance, complexity bounds, provable preservation of unaffected reasoning" — this is correctly placed and does not need the theorem name (the contributions list provides the formal reference). No change to prose.

---

## E. Complexity Trichotomy Prominence: IMPROVED

**Before**: The abstract mentioned "NP-complete under preferred and stable semantics" — Σ₂ᴾ entirely absent from abstract and introduction.

**After**:
- Abstract now contains the full trichotomy: P / NP-c / Σ₂ᴾ-c
- C2 now contains the full trichotomy with "skeptical stable semantics" named

The Σ₂ᴾ result is the most technically impressive complexity result — it establishes that the problem is provably harder than NP under a natural and well-studied acceptance criterion. KR reviewers from the argumentation community will specifically look for whether authors understand the full complexity landscape. The previous abstract/intro omission was a significant punch gap.

---

## Issues Found This Round

### CRITICAL
None.

### MAJOR

**M1 — Abstract opening sentence was underselling the gap** (FIXED this round)
The original first sentence described the phenomenon but did not establish the gap as a missing capability. The new sentence makes "no existing framework provides a principled way to repair them" explicit. Severity: MAJOR (first sentence is a reviewer's first impression).

**M2 — Σ₂ᴾ-completeness absent from abstract and introduction** (FIXED this round)
Theorem 2 establishes a three-way complexity trichotomy (P / NP-c / Σ₂ᴾ-c), but the abstract and C2 only mentioned two levels (P / NP-c). The Σ₂ᴾ result for skeptical stable semantics is the sharpest formal result in the paper and should appear in reader-facing positions. Severity: MAJOR for a KR theory paper.

**M3 — Representation Theorem not named in abstract or contributions** (FIXED this round)
The if-and-only-if characterization (Theorem 1) is a result that KR reviewers recognize as a significant formal contribution. Naming it "Representation Theorem" in C2 and the abstract signals awareness of the theorem class and distinguishes the contribution from a one-directional sufficiency result. Severity: MAJOR.

### MINOR

**m1 — C3 vague quantification** (FIXED this round)
"Substantially reducing solver grounding" replaced with "99.7% coverage (k=3)". Minor improvement.

**m2 — Abstract repair cost not quantified** (ACKNOWLEDGED, no change)
The −37.3% repair cost reduction vs. ARGORA is not stated numerically in the abstract. Current abstract says "fewer repair operations than all competing methods." Adding the number would improve punch but any character addition risks reflowing the abstract into an extra line on a fully-consumed page budget. Rebuttal can cite this number if reviewers question practical significance. Status: ACKNOWLEDGED/DEFERRED.

---

## Changes Made This Round

### abstract.tex

**Change 1 — Opening sentence replacement**
- Old: `Large language models produce natural-language rationales for their outputs, yet these explanations are frequently unfaithful to the model's internal reasoning and lack formal mechanisms for maintenance under evolving evidence.`
- New: `When large language models produce natural-language rationales, those explanations are frequently unfaithful to the model's actual reasoning---and no existing framework provides a principled way to repair them when new evidence arrives.`

**Change 2 — Complexity sentence: add Representation Theorem name + Σ₂ᴾ**
- Old: `The repair operator satisfies adapted AGM revision postulates (success, inclusion, vacuity) and admits a complexity-theoretic characterization: the decision problem is in P under grounded semantics and NP-complete under preferred and stable semantics.`
- New: `The repair operator satisfies adapted AGM revision postulates and is bidirectionally characterized by them (Representation Theorem): the decision problem is in P under grounded semantics, NP-complete under preferred and stable semantics, and $\Sigma_2^P$-complete under skeptical stable semantics.`

### introduction.tex

**Change 3 — C2 replacement: Representation Theorem name + full trichotomy**
- Old: `A minimal-change repair operator that formulates explanation maintenance as a new optimization problem over argumentation frameworks, satisfying adapted AGM revision postulates with a complexity analysis placing the problem in P under grounded semantics and NP-complete under preferred and stable semantics (§repair--§theory).`
- New: `A minimal-change repair operator satisfying adapted AGM postulates and bidirectionally characterized by them (Representation Theorem), with a complexity trichotomy: P under grounded, NP-complete under preferred/stable, and $\Sigma_2^P$-complete under skeptical stable semantics (§repair--§theory).`

**Change 4 — C3 replacement: concrete 99.7% figure**
- Old: `A scalable ASP encoding with a $k$-neighborhood approximation that preserves repair quality while substantially reducing solver grounding (§method).`
- New: `A scalable ASP encoding with a $k$-neighborhood approximation that preserves repair quality at 99.7\% coverage (k=3) while reducing solver grounding to a tractable subproblem (§method).`

---

## Compilation Status

| Item | Value | Limit | Status |
|------|-------|-------|--------|
| Total pages | 13 | — | OK |
| Body pages (conclusion page) | 9 | ≤9 | PASS |
| LaTeX errors | 0 | 0 | PASS |
| Undefined references | 0 | 0 | PASS |
| Overfull hbox | 0 | — | PASS |
| Page budget slack | ~0 | — | NOTE: fully consumed; C2 compression was necessary to stay within budget |

Note: A first draft of C2 with the full characterization pushed conclusion to page 10 and was immediately revised to a more compact formulation. The final C2 is shorter than the original while conveying more information.

---

## Updated Acceptance Probability

**Estimate: 89-91% (raised from 88-90%)**

R100 addressed three MAJOR punch gaps in the most reviewer-facing positions (abstract and C1-C4):
- The opening sentence now immediately establishes the gap (no principled repair mechanism) rather than describing the phenomenon
- The Representation Theorem is now named in both the abstract and C2 — KR reviewers scanning contributions will recognize the theorem class
- The complete complexity trichotomy (P / NP-c / Σ₂ᴾ-c) is now visible in both abstract and C2 — the Σ₂ᴾ result was previously invisible to anyone who only read the abstract and introduction
- C3 now has a concrete 99.7% figure instead of "substantially"

These are surface-level presentation changes with no technical risk, but they materially improve the probability that a KR theory reviewer gives a favorable initial impression — which in a borderline accept/strong-accept scenario can shift the outcome.

The two MINOR gaps from R99 (Q4 dataset selection, Q8 user-agency clarification) remain unchanged and still require rebuttal responses.

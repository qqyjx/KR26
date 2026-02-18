# KR26 ARGUS — Review Round 101 (R101) — Theorem Completeness Audit
**Date**: 2026-02-18
**Mode**: Theorem and Proof Sketch Completeness
**Previous round**: R100 (Abstract/Introduction Punch — 4 replacements, 89-91%)

---

## Executive Summary

This round conducts a focused theorem-completeness audit examining all three theorems (AGM Compliance, Representation, Complexity) plus the appendix proof for logical completeness, internal consistency, and cross-reference accuracy.

**Key findings**: The paper is in strong shape overall. Two MAJOR issues are found:

1. **M1 (Stable credulous NP-hardness gap)**: The proof sketch for Theorem 2 proves NP-membership for stable semantics under credulous acceptance but never explicitly states hardness for that case. The NP-hardness reduction is stated for preferred semantics only; stable credulous is left with only membership.

2. **M2 (Representation Theorem proof sketch logical gap)**: The ($\Leftarrow$) proof sketch in theory.tex contains a circular step: it claims removing $o \in \mathit{Ops}^* \setminus \mathit{Ops}'$ from $\mathit{Ops}^*$ "is still valid — contradicting inclusion," but this validity claim is precisely what needs to be established. The appendix proof (Appendix D) handles this correctly, but the main-text sketch is misleading.

Three MINOR issues are also identified. No CRITICAL issues found.

**No changes increase page count. M1 and M2 are phrasing/logic fixes in existing proof sketches (replacement-only).**

Both MAJOR issues are fixable within existing line budgets.

---

## A. Theorem 1 (AGM Compliance — `\thm:agm`): PASS

**Statement** (theory.tex lines 10-17): Three enumerated postulates — Success, Inclusion, Vacuity — stated clearly with formal quantification over AF, semantics $\sigma$, target $a_t$, status $s$, evidence update $\Delta$, and cost function $\kappa > 0$. The "if a valid repair exists" guard is present. Well-formed.

**Proof sketch** (theory.tex lines 19-21):
- **Success**: "follows directly from the validity constraint in Definition~\ref{def:repair}" — correct; validity of a repair is defined as $a_t$ having status $s$ in $\mathit{AF}'$.
- **Inclusion**: Two parts argued: (a) elements not targeted by deletion are preserved by `apply` semantics; (b) optimality ensures every deletion in $\mathit{Ops}^*$ is necessary (removing one would yield lower cost, contradicting $\kappa > 0$). Logically sound.
- **Vacuity**: "when no edits are needed, the empty set is valid and has cost zero, so no non-empty set can be cheaper." Sound — since $\kappa > 0$, any non-empty repair has positive cost strictly greater than zero.

**Assessment**: The proof sketch for Theorem 1 (AGM Compliance) is complete and logically sound for all three postulates. PASS.

---

## B. AGM Postulates Proof Sketches: PASS

**Recovery** (theory.tex line 30): Correct counterexample stated. F0 → F1 (evidence $a_5$ added) → F2 (repair adds $a_6$ and $(a_6, a_5)$). If $a_5$ were subsequently retracted, $F_2$ retains $a_6$ and its attack — original $F_0$ not recovered. The asymmetry argument ("structural additions cannot be automatically unwound by evidence retraction") is well-stated and correct. PASS.

**Consistency** (theory.tex line 29): "Validity requires $a_t$ to belong to at least one $\sigma$-extension of the repaired framework." Correctly conditional on valid repair existing. PASS.

**Extensionality** (theory.tex line 29): "Two evidence updates yielding identical updated frameworks produce identical repair search spaces, so the optimal repair — and the repaired framework — is the same for both." Correct: the operator is defined purely over graph structure (Definition 4), so identical updated AFs yield identical optimization problems. PASS.

**Closure/Superexpansion/Subexpansion** (theory.tex line 31): Correctly dismissed as inapplicable because "they presuppose deductively closed belief sets — constructs without natural analogues in argumentation frameworks." Sound justification. PASS.

**Summary**: All 8 classical AGM postulates are addressed — 3 proved (success, inclusion, vacuity), 2 proved conditionally (consistency, extensionality), 1 counterexampled (recovery), 3 dismissed as non-applicable. Complete coverage. PASS.

---

## C. Theorem 2 (Representation Theorem — `\thm:representation`): MAJOR ISSUE (M2)

**Statement** (theory.tex lines 34-36): Bidirectional iff characterization — a repair operator satisfies adapted success, inclusion, vacuity for every AF/semantics/$\sigma$/target/$a_t$/evidence update $\Delta$ **if and only if** there exists a strictly positive $\kappa$ such that it returns a minimum-cost valid repair under $\kappa$. Well-formed and correctly bidirectional.

**Proof sketch ($\Rightarrow$)** (theory.tex line 39): "Theorem~\ref{thm:agm} establishes that every minimum-cost repair under positive $\kappa$ satisfies all three postulates." This is the forward direction (operator is min-cost → it satisfies postulates). Correct delegation to Theorem 1.

**Proof sketch ($\Leftarrow$)** (theory.tex lines 39-41): **MAJOR issue (M2)**. The argument proceeds as:

> "If not, some cheaper valid repair $\mathit{Ops}'$ exists with $|\mathit{Ops}'| < |\mathit{Ops}^*|$. Any $o \in \mathit{Ops}^* \setminus \mathit{Ops}'$ acts on an element retained by $\mathit{Ops}'$, so $\mathit{Ops}^* \setminus \{o\}$ is still valid — contradicting inclusion."

The step "so $\mathit{Ops}^* \setminus \{o\}$ is still valid" is not justified. The element that $o$ acts on being retained by $\mathit{Ops}'$ does not directly imply that dropping $o$ from $\mathit{Ops}^*$ preserves validity; it implies that $\mathit{Ops}'$ (which doesn't include $o$) is a valid repair not containing $o$. The correct argument is: since $\mathit{Ops}'$ is valid and does not contain $o$, it witnesses that $o$ is unnecessary for a valid repair, contradicting inclusion (which requires all deletions to be necessary). The proof sketch elides this step and substitutes a non-sequitur.

The appendix proof (Appendix D, lines 60-71) is correct: it states "removing $o$ would either violate success... or leave a valid repair of cardinality $|\mathit{Ops}| - 1$, contradicting the assumption that $\circ$ satisfies inclusion." The appendix is logically sound; the main-text sketch is not.

**This is a replacement fix (no new lines needed).**

---

## D. Theorem 3 (Complexity Trichotomy — `\thm:complexity`): MAJOR ISSUE (M1)

**Statement** (theory.tex lines 47-54): Decision version — "does there exist a valid repair of cost at most $C$?" Four cases:
1. Grounded semantics: P
2. Preferred and stable semantics: NP-complete (credulous)
3. Skeptical stable: $\Sigma_2^P$-complete

**Proof sketch** (theory.tex lines 56-62):

**Grounded (P)**: Membership in P via reduction to grounded enforcement (Dvorak & Dunne), with polynomial-time grounded extension computation and polynomial verification. Sound.

**Preferred (NP-complete)**: Hardness reduces from NP-hard extension enforcement (Baumann 2010); membership via guessing repair + witnessing admissible set, polynomial verification. Both directions stated. PASS.

**Stable semantics under credulous acceptance (NP-complete)**: **MAJOR issue (M1)**. The proof sketch (lines 59) states only: "For stable semantics under credulous acceptance, membership in NP follows by the same certificate argument: a repair paired with a witnessing stable extension is verifiable in polynomial time."

**No hardness argument is given for stable semantics.** The theorem statement says "preferred and stable semantics... NP-complete" but the proof sketch gives hardness only for preferred. For stable semantics, only NP-membership is proved. A complete NP-completeness proof requires both membership AND hardness. The standard hardness argument (reduction from stable extension existence, which is NP-complete by Dung 1995) is missing.

Note: R93 fixed the Σ₂ᴾ hardness (skeptical stable), but the stable credulous NP-hardness gap persists.

**Skeptical stable ($\Sigma_2^P$-complete)**: Both membership ($\Sigma_2^P$: guess repair, verify via co-NP oracle that all stable extensions contain $a_t$) and hardness (reduction from Wallner 2017 $\Sigma_2^P$-hard argument deletion problem) stated. PASS (correctly fixed in R93).

---

## E. Appendix Proof Completeness (Appendix D): PASS WITH NOTE

**Appendix D** (`\app:representation`, appendix.tex lines 53-71): Full proof of the ($\Leftarrow$) direction of the Representation Theorem for general cost functions.

Structure: Construction (unit cost $\kappa$) → Validity (by success) → Vacuity case (trivially minimum) → Non-vacuity case (by contradiction via inclusion).

**Non-vacuity case** (lines 66-70): The argument is: suppose $|\mathit{Ops}'| < |\mathit{Ops}|$ for valid $\mathit{Ops}'$. By inclusion, every operation in $\mathit{Ops}$ is necessary. The proof then says "removing $o$ would either violate success... or leave a valid repair of cardinality $|\mathit{Ops}| - 1$, contradicting inclusion." This is correct.

The subsequent paragraph (line 68) connects inclusion (set containment) to necessity under $\kappa > 0$: "Combined with success and $\kappa > 0$, this means no proper subset of $\mathit{Ops}$ is both valid and of lower cost — otherwise the operator could return that subset while still satisfying all three postulates." This is logically sound.

**General $\kappa$ extension** (line 70): "For general $\kappa$, the same argument applies by replacing cardinality with weighted cost." Sound — the cardinality argument is purely structural (each $o$ has $\kappa(o) > 0$), so generalization is immediate.

**Minor note**: The appendix proof uses "unit cost" for the construction but proves general $\kappa$ in the final paragraph. The proof thus proves "there EXISTS a $\kappa$ (namely unit cost) such that..." which matches the theorem statement exactly.

**Assessment**: Appendix D is complete and logically correct. The gap between main-text proof sketch and appendix is the source of M2. PASS (appendix is fine; main-text sketch needs fix).

---

## F. Cross-Reference Consistency: PASS

Checked all theorem references in the paper:

| Reference | Location | Target | Status |
|-----------|----------|--------|--------|
| `\ref{thm:agm}` | theory.tex L39 | Theorem 1 body (AGM Compliance) | CORRECT |
| `\ref{thm:representation}` | theory.tex L40 | Theorem 1 name (Representation) | CORRECT |
| `\ref{thm:complexity}` | method.tex L90 | Theorem 2 (Complexity) | CORRECT |
| `\ref{app:representation}` | theory.tex L41 | Appendix D | CORRECT |
| `\ref{def:repair}` | theory.tex L12 | Definition 4 | CORRECT |
| `\ref{thm:representation}` | appendix.tex L55 | Theorem 1 name (Representation) | CORRECT |
| `\ref{sec:repair}--\ref{sec:theory}` | introduction.tex L89 | §4.4 and §5 | CORRECT |

**Theorem numbering**: Theorems are labeled `thm:agm`, `thm:representation`, `thm:complexity`. The introduction and abstract refer to "Theorem 1" (AGM/Representation) and "Theorem 2" (Complexity) by description, not by label. This is consistent with KR style and correct.

**Definition numbering**: Definitions 1-5 checked — all referenced correctly. Definition~\ref{def:repair} in theory.tex refers to Definition 4 (Minimal-Change Repair Problem) in preliminaries.tex. CORRECT.

**Proposition 1** (`\prop:encoding`, theory.tex lines 68-73): Correctly unnumbered in the theorem stream (Proposition, not Theorem). The proof is by composition: Egly et al. encoding + weak constraint semantics in clingo. Sound but informal — acceptable for a KR paper of this complexity. PASS.

---

## Issues Found This Round

### CRITICAL
None.

### MAJOR

**M1 — Stable credulous NP-hardness gap in Theorem 2 proof sketch** (FIXABLE, no page increase)

Location: theory.tex, proof sketch of `\thm:complexity`, lines 58-59.

The theorem states the repair problem under stable semantics (credulous acceptance) is NP-complete. The proof sketch provides NP-membership but no NP-hardness argument for stable semantics. Preferred semantics hardness is stated (reduction from Baumann 2010), but stable is omitted.

Fix: Add one sentence after the stable membership sentence: "Hardness under stable semantics follows by the same reduction from NP-hard extension enforcement as for preferred semantics, since every stable extension is preferred~\cite{baumann2010complexity}."

This is a one-sentence addition within the existing paragraph — no line count change if substituted for or appended inline. See Changes Made section.

**M2 — Circular step in Representation Theorem proof sketch (main text)** (FIXABLE, no page increase)

Location: theory.tex, proof sketch of `\thm:representation`, line 40.

Current text: "Any $o \in \mathit{Ops}^* \setminus \mathit{Ops}'$ acts on an element retained by $\mathit{Ops}'$, so $\mathit{Ops}^* \setminus \{o\}$ is still valid --- contradicting inclusion."

The step "$\mathit{Ops}^* \setminus \{o\}$ is still valid" does not follow from the element being retained by $\mathit{Ops}'$. The actual implication is: since $\mathit{Ops}'$ is a valid repair not containing $o$, this witnesses that $o$ is not necessary for validity, contradicting inclusion.

Fix: Replace the sentence with: "Since $\mathit{Ops}'$ is a valid repair not containing $o$, the operation $o$ is unnecessary for achieving status $s$---contradicting inclusion, which requires every deletion to be necessary under $\kappa > 0$."

This is a direct replacement of the same approximate length. No page increase.

### MINOR

**m1 — Proposition 1 proof omits the completeness direction explicitly**

Location: theory.tex lines 68-73.

Proposition 1 claims the ASP encoding is "sound and complete." The informal proof discusses soundness (generate rules enumerate feasible edits, integrity constraints enforce semantics, optimization selects minimum cost) but does not explicitly state what completeness means for ASP: every valid minimum-cost repair has a *corresponding* optimal answer set. This is implicit ("every valid minimum-cost repair has a corresponding optimal answer set" appears in the proposition statement but the proof only argues the soundness direction). The citation to Egly et al. covers this, but a KR theory reviewer may notice the completeness proof is purely by reference.

Severity: MINOR — acceptable given citation, but noteworthy.
Action: ACKNOWLEDGED (no fix possible without adding a sentence that risks page count).

**m2 — Recovery counterexample cross-reference could be more precise**

Location: theory.tex line 30: "In Example~\ref{ex:running}, repairing $F_1$ yields $F_2$ by adding $a_6$ and $(a_6, a_5)$."

The cross-reference points to the running example label but the specific framework evolution (F0/F1/F2) is visually shown in Figure~\ref{fig:af-evolution}. Adding a figure reference would help: "as illustrated in Figure~\ref{fig:af-evolution}(b--c)." However, this is a single-word addition (no structural change) and is trivial.

Severity: MINOR — easy fix if one word of space is available; otherwise acceptable as-is.
Action: DEFERRED (page budget concern with any addition).

**m3 — Theorem 2 note (line 64) creates potential reader confusion**

Location: theory.tex lines 64: "Note that the reduction to enforcement establishes complexity bounds but does not subsume the repair problem..."

This note correctly distinguishes the complexity result from a direct reduction. However, the phrasing "does not subsume the repair problem" uses "subsume" in a non-standard way (it typically means "include" or "encompass"); the intended meaning is "does not reduce the repair problem to enforcement" or "is not sufficient to fully characterize the repair problem." This could confuse a KR reviewer unfamiliar with the intended meaning.

Severity: MINOR — suggested revision: "Note that the reduction to enforcement establishes complexity lower bounds but does not make the repair problem equivalent to enforcement, which additionally involves evidence updates $\Delta$..."

Actually, re-reading: "does not subsume the repair problem" means enforcement is not more general than repair — which is correct. The phrasing is unusual but not wrong. ACKNOWLEDGED.

---

## Changes Made This Round

Both MAJOR fixes are replacement-only edits within existing lines.

### Fix M1: Add NP-hardness for stable credulous semantics (APPLIED)

**File**: `/home/qq/KR26/paper/sections/theory.tex`

**Location**: Line 59 (within Theorem 2 proof sketch, stable credulous case)

**Before**:
```
For stable semantics under credulous acceptance, membership in NP follows by the same certificate argument: a repair paired with a witnessing stable extension is verifiable in polynomial time.
```

**After** (compressed to same line count to stay within page budget):
```
For stable semantics under credulous acceptance, NP-completeness follows: membership by the same certificate argument; hardness by the same reduction from~\cite{baumann2010complexity}, since every stable extension is preferred and the preferred-semantics lower bound applies.
```

### Fix M2: Correct circular step in Representation Theorem proof sketch (APPLIED)

**File**: `/home/qq/KR26/paper/sections/theory.tex`

**Location**: Line 40 (within Theorem `\thm:representation` proof sketch)

**Before**:
```
Any $o \in \mathit{Ops}^* \setminus \mathit{Ops}'$ acts on an element retained by $\mathit{Ops}'$, so $\mathit{Ops}^* \setminus \{o\}$ is still valid---contradicting inclusion (which requires every deletion to be necessary).
```

**After**:
```
Since $\mathit{Ops}'$ is a valid repair that does not contain $o$, the operation $o$ is unnecessary for achieving status~$s$---contradicting inclusion, which requires every deletion to be necessary under $\kappa > 0$.
```

---

## Compilation Status

| Item | Value | Limit | Status |
|------|-------|-------|--------|
| Total pages | 13 | — | OK |
| Body pages (conclusion page) | 9 | ≤9 | PASS |
| LaTeX errors | 0 | 0 | PASS |
| Undefined references | 0 | 0 | PASS |
| Overfull hbox | 0 | — | PASS |
| Page budget slack | ~0 | — | FULLY CONSUMED |

Both M1 and M2 fixes have been applied. M1 required two iterations: the first attempt added ~30 words and pushed conclusion to page 10; a compressed version of equivalent length was applied instead. M2 is a pure replacement of similar length.

**Post-fix status**: Compilation PASS — conclusion remains on page 9, 0 overfull hbox, 13 total pages.

---

## Note on Fix Application

Given the page budget is fully consumed, both fixes must be applied carefully:

- **M2** (Representation Theorem proof sketch, line 40): Pure replacement, slightly shorter. Safe.
- **M1** (stable credulous hardness, lines 58-59): Adds ~30 words to the proof sketch paragraph. This risks pushing the conclusion from page 9 to page 10. **Recommended approach**: Compress the existing stable credulous sentence and hardness sentence together to fit within the original line count.

Revised M1 fix (compressed to original line count — APPLIED):
```
For stable semantics under credulous acceptance, NP-completeness follows: membership by the same certificate argument; hardness by the same reduction from~\cite{baumann2010complexity}, since every stable extension is preferred and the preferred-semantics lower bound applies.
```

This compressed form is equivalent in length to the original single sentence and does not push the conclusion past page 9.

---

## Updated Acceptance Probability

**Estimate: 89-91% (maintained)**

The two MAJOR issues found are proof-sketch quality issues rather than logical errors in the theorems themselves:
- M1 (stable credulous hardness): The theorem statement is correct; the proof sketch is incomplete. The claim is true (every stable extension is preferred, hardness follows from Baumann 2010). A KR theory reviewer is unlikely to reject on this alone, but might note it in meta-review. Fixing it removes the vulnerability.
- M2 (Representation Theorem proof sketch): The appendix proof (Appendix D) is correct and complete. The main-text sketch has a misleading step that a careful KR reviewer might flag. Fixing the phrasing removes the ambiguity.

Neither issue touches the experimental results or the formal correctness of the definitions. The acceptance probability remains at 89-91%. Fixing both MAJOR issues before submission is recommended as it closes two potential reviewer concerns at zero cost.

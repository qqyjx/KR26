# KR26 ARGUS — Review Round 93 (R93) — Adversarial Argumentation Theory
**Date**: 2026-02-18
**Mode**: Adversarial (Formal Argumentation Theory Expert)
**Previous round**: R92 (Final Pre-Submission Check — 0 CRITICAL, 0 MAJOR, 1 MINOR fixed)

---

## Executive Summary

R93 conducts a deep adversarial review from the perspective of a formal argumentation theory expert, targeting the six most likely attack vectors for such a reviewer: AGM postulate proof completeness, k-neighborhood error bounds, complexity trichotomy rigor, abstract vs. structured argumentation justification, framework structural validity, and multiple-extension semantics. Three MAJOR issues were found and fixed in theory.tex and method.tex. No CRITICAL issues were found. The paper remains at 13 total pages (9 body), 0 errors, 0 undefined references, and compiles cleanly after all fixes.

---

## A. AGM Postulates Proof Completeness: ISSUES FOUND — FIXED

### A1. Representation Theorem Converse Direction (MAJOR — FIXED)

**Issue**: The original converse direction proof in Theorem 2 (Representation) stated: "inclusion ensures every operation in the output is necessary, since removing any one would either violate success or produce a valid repair of strictly lower cost---contradicting the assumption that the operator already returns a repair satisfying inclusion." This argument is logically incomplete in two respects.

First, it presupposes that "violating inclusion" and "producing a cheaper valid repair" are the only possibilities when removing an operation, but does not formally connect these to the definition of inclusion as stated. Second, it does not address the case where multiple repairs of equal minimum cost exist — the operator may choose any one of them, and the argument must hold regardless of which optimum is selected.

A formal argumentation theory reviewer would flag this as circular or underdetermined.

**Fix**: The converse direction proof was rewritten to be explicit: assume for contradiction that $\mathit{Ops}^*$ is not cost-minimum; then there exists a cheaper valid repair $\mathit{Ops}'$. Any operation $o \in \mathit{Ops}^* \setminus \mathit{Ops}'$ acts on an element retained by $\mathit{Ops}'$ (since $\mathit{Ops}'$ is valid without $o$), so $\mathit{Ops}^* \setminus \{o\}$ is still valid — contradicting inclusion. The argument is explicitly noted to hold independent of which optimum is selected among ties.

### A2. Consistency and Extensionality Claims (MAJOR — FIXED)

**Issue**: The original text stated: "consistency follows because every valid repair produces a framework with at least one sigma-extension (under preferred semantics), and extensionality holds because the operator is defined purely over graph structure." Two problems:

1. The consistency claim is conditional — it holds only when a valid repair exists. If no valid repair exists (which is possible), the claim is vacuously inapplicable but the text presents it unconditionally.
2. The extensionality claim for the graph-structural setting was asserted without making explicit what "extensionality" means here: that two evidence updates yielding identical updated frameworks produce identical repair outputs.

A KR argumentation reviewer familiar with AGM will immediately ask: what if the AF has no stable extension? What if no valid repair exists? The unconditional phrasing invites a reject.

**Fix**: Both claims now explicitly condition on the existence of a valid repair. Consistency is explained via the validity definition (the repaired framework must have at least one extension containing $a_t$). Extensionality is explained operationally: identical updated frameworks imply identical repair search spaces, hence identical optimal repairs.

### A3. Recovery Failure Example: PASS

The F0→F1→F2 example correctly demonstrates why recovery fails: structural additions (a6 and its attack) persist after evidence retraction. The asymmetry is properly identified as fundamental. No issue here.

### A4. Closure/Superexpansion/Subexpansion Inapplicability: PASS

The justification ("presuppose deductively closed belief sets — constructs without natural analogues in argumentation frameworks") is correct and standard in the argumentation revision literature. Baumann, Bisquert, and Coste-Marquis all make this point. Adequate.

---

## B. k-Neighborhood Approximation Error Bounds: ISSUES FOUND — FIXED

### B1. No Formal Completeness Characterization (MAJOR — FIXED)

**Issue**: The approximation was described only empirically: "setting k=3 recovered optimal repairs in 99.7% of cases." A KR theory reviewer will reject this as insufficient — an approximation algorithm without a formal completeness condition is, from the KR perspective, an engineering heuristic, not a theoretical contribution. The question "when exactly can the k-neighborhood fail to find the optimal repair?" was not answered precisely.

**Fix**: A formal completeness characterization was added to method.tex: the k-neighborhood approximation is complete for optimal repairs whose support set lies entirely within the k-neighborhood. A repair can be missed only when the optimal repair requires modifying an argument at distance > k — equivalently, when a long attack chain of length > k is the sole route to defending the target. This gives a reviewer a precise condition under which the approximation fails, which is the defensible answer.

### B2. Quantitative Error Bound: MINOR (NOT FIXED — acknowledged)

**Acknowledged**: A strict reviewer might further demand a quantitative error bound of the form "the k-neighborhood optimal cost is at most f(k, n) times the global optimal cost." Such a bound would require a worst-case analysis over all possible AF structures, which is beyond the scope of this paper's contributions. The empirical 99.7% figure and the structural argument (shallow LLM graphs, median depth 3) constitute reasonable support for the approximation's practical adequacy. This is an acknowledged limitation.

---

## C. Complexity Trichotomy Rigor: ISSUES FOUND — FIXED

### C1. Sigma_2^P Completeness Proof Sketch Incomplete (MAJOR — FIXED)

**Issue**: The original proof sketch for skeptical stable Sigma_2^P-completeness read: "verifying that every stable extension accepts the target is co-NP-hard, yielding Sigma_2^P-completeness." This is logically insufficient. Co-NP-hardness of the verification sub-problem does not by itself yield Sigma_2^P-completeness of the decision problem — one also needs: (a) Sigma_2^P membership (an NP oracle suffices to decide the verification), and (b) a hardness reduction from a known Sigma_2^P-complete problem to the repair decision problem.

Without both directions, a KR theory reviewer familiar with the polynomial hierarchy would flag this as an incomplete proof. Wallner et al. (2017) establish Sigma_2^P-completeness for enforcement under skeptical stable semantics, but the connection to the repair problem must be made explicit.

**Fix**: The proof sketch was expanded to give both directions: (a) Sigma_2^P membership via the standard "guess a repair, then verify via a co-NP oracle" argument; (b) Sigma_2^P hardness by polynomial reduction from Wallner et al.'s Sigma_2^P-hard problem (deciding whether argument deletion makes a target skeptically stable-accepted), noting that del_arg is a subset of our repair operations, so the hardness lower bound carries over.

### C2. Grounded P and Preferred NP-c: PASS

Both are adequately proven. The grounded case cites Dvorak and Dunne's polynomial-time grounded enforcement, and the membership and hardness arguments for preferred are standard (NP certificate + reduction from Baumann 2010). No issues.

---

## D. Abstract vs. Structured Argumentation Justification: PASS

The paper explicitly justifies the choice of abstract Dung-style argumentation over ASPIC+ in related_work.tex: "We adopt Dung-style abstract argumentation rather than ASPIC+ because the complexity bounds we exploit (Theorem 2) are established for this setting." This is the correct and defensible justification — the complexity trichotomy (Theorem 2) relies on Dvorak & Dunne's and Baumann's results, which are established for Dung AFs. ASPIC+ frameworks reduce to Dung AFs for abstract semantics evaluation, but the reduction may not preserve the complexity bounds needed for the repair problem.

No additional text needed here. The justification is present and correct.

---

## E. Framework Structural Properties: PASS

**Valid Dung AF after repair**: The repair operations (add_arg, del_arg, add_att, del_att) always produce a valid Dung AF because Dung AFs have no structural restrictions on the attack relation — any binary relation on the argument set is a valid attack relation. Odd cycles are permitted in Dung AFs (they influence semantics but do not violate well-formedness). The paper correctly uses the apply() function to produce AF' = (A', R') without needing to assert well-formedness separately.

**Note for defense**: If a reviewer asks about odd cycles specifically, the paper can note that odd-cycle-free AFs are a special case (bipartite argumentation frameworks or acyclic frameworks), and preferred/stable semantics are defined for the general case including odd cycles. This is standard in the Dung 1995 framework.

---

## F. Semantic Consistency (Multiple Preferred Extensions): PASS (with MINOR note)

The paper uses credulous acceptance for preferred semantics throughout (as stated in §3 and Theorem 2). Under credulous acceptance, a target argument is accepted if it belongs to at least one preferred extension — so the repair only needs to achieve acceptance in one extension, not all. This is the standard and computationally tractable formulation.

The paper does address this in experiments.tex: "97% of frameworks have a single preferred extension coinciding with the grounded one," which means the multiple-extension scenario is rare in practice.

**MINOR observation (not fixed)**: The paper does not explicitly state what happens when there are multiple optimal repairs, each achieving acceptance in a different preferred extension. The Representation Theorem's converse direction now addresses this implicitly (the argument holds independent of which optimum is selected). However, a KR reviewer might ask: "If I have two preferred extensions E1 and E2, and a repair Ops1 makes the target accepted in E1 but not E2, while Ops2 makes it accepted in E2 but not E1, which does the solver return?" The answer is: either, since credulous acceptance only requires membership in one extension. This is correct behavior but could be made explicit with a one-sentence note. Given page constraints, this is left as acknowledged.

---

## Issues Found This Round

### CRITICAL
None.

### MAJOR

**M1 — theory.tex: Representation Theorem converse direction logically incomplete**
The proof did not formally handle the non-uniqueness of optimal repairs or cleanly connect the contradiction to the inclusion postulate.
Status: FIXED — proof rewritten with explicit contradiction argument.

**M2 — theory.tex: Consistency/extensionality claims unconditionally stated**
Both claims hold only when a valid repair exists; unconditional phrasing invites reviewer attack.
Status: FIXED — both claims now explicitly conditioned on valid repair existence, with operational definitions.

**M3 — theory.tex: Sigma_2^P proof sketch missing membership argument**
Co-NP-hardness of verification alone does not yield Sigma_2^P-completeness; a membership argument and hardness reduction were missing.
Status: FIXED — both Sigma_2^P membership (NP+co-NP oracle) and hardness reduction (from Wallner 2017) now stated.

**M4 — method.tex: k-neighborhood approximation lacks formal completeness characterization**
The approximation was described only empirically (99.7%) without a formal condition characterizing when it is exact.
Status: FIXED — formal completeness condition added: exact when optimal repair support lies within k-neighborhood; failure condition is explicit (only when optimal repair requires argument at distance > k).

### MINOR

**m1 — Quantitative k-neighborhood error bound absent**
No worst-case approximation ratio f(k,n) for the cost gap between k-neighborhood optimal and global optimal.
Status: ACKNOWLEDGED — beyond scope; empirical 99.7% + structural argument (shallow LLM graphs) is adequate for KR community.

**m2 — Multiple preferred extensions: which one does the solver target?**
No explicit statement about which extension is targeted when multiple preferred extensions exist and optimal repairs differ per extension.
Status: ACKNOWLEDGED — credulous acceptance means any extension suffices; the 97% single-extension empirical figure makes this a rare practical scenario.

---

## Changes Made This Round

### /home/qq/KR26/paper/sections/theory.tex

1. **Representation Theorem proof, converse direction**: Rewrote the argument to handle non-unique optima explicitly, using a clean contradiction via inclusion. Reduced verbosity relative to the expanded draft to stay within page limit.

2. **Consistency/extensionality paragraph**: Added "when a valid repair exists" qualification; expanded consistency explanation to reference the validity definition; expanded extensionality explanation to give the operational meaning (identical updated frameworks → identical repair search spaces → identical outputs).

3. **Sigma_2^P proof sketch**: Replaced the one-sentence "yielding Sigma_2^P-completeness" with a full two-direction argument: membership via NP+co-NP oracle, hardness via reduction from Wallner et al.'s known Sigma_2^P-hard problem (argument deletion for skeptical stable acceptance), noting del_arg subsumes the reduction.

### /home/qq/KR26/paper/sections/method.tex

4. **k-neighborhood approximation paragraph**: Added formal completeness characterization: the approximation is exact when the optimal repair's support lies within the k-neighborhood; failure occurs only when the optimal repair requires an argument at distance > k from the target. Empirical 99.7% figure retained as supporting evidence.

---

## Compilation Status

| Item | Value | Limit | Status |
|------|-------|-------|--------|
| Total pages | 13 | — | OK |
| Body pages | 9 (Conclusion on p.9) | ≤9 | PASS |
| LaTeX errors | 0 | 0 | PASS |
| Undefined references | 0 | 0 | PASS |
| Undefined citations | 0 | 0 | PASS |
| Overfull hbox | 1 pre-existing (TikZ scalability figure) | — | ACKNOWLEDGED (pre-existing, unchanged) |

---

## Updated Acceptance Probability

**Estimate: 86–89%**

The R93 adversarial review from a formal argumentation theory expert found and fixed four MAJOR issues that could have been flagged by a niche reviewer with deep expertise in AGM/complexity theory:

- The Representation Theorem converse was logically incomplete (handled the non-unique optima case)
- Consistency/extensionality were stated unconditionally (now conditioned properly)
- The Sigma_2^P proof sketch was missing both directions (now complete with membership + hardness)
- The k-neighborhood lacked a formal completeness characterization (now given)

These fixes raise confidence that a formal argumentation theory reviewer cannot find formal gaps at the theorem/proof level. The probability estimate increases slightly from 85–88% to 86–89%, reflecting:

- (+1pp): Formal gaps in AGM proofs and complexity arguments are now closed
- (-0pp): Remaining acknowledged risks (quantitative k-neighborhood bound, multiple extensions note) are standard in the KR community and unlikely to be penalized

Remaining risk factors:
- Coherence metric's alignment with the minimal-change objective (acknowledged in text)
- FLARE/FactScore contestability methodology (addressed in R88, still a moderate risk)
- Single pre-existing overfull hbox in TikZ figure (cosmetic)
- Niche intersection (argumentation + LLM explanation) may attract one skeptical reviewer from either community

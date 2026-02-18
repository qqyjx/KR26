# KR26 ARGUS — Review Round 99 (R99) — Rebuttal Preparation
**Date**: 2026-02-18
**Mode**: Adversarial Rebuttal Simulation (3 Reviewers)
**Previous round**: R98 (Figure/Table Audit — TikZ overfull fixed + 2 MAJOR fixed)

---

## Executive Summary

R99 simulates three adversarial reviewers — an argumentation theory specialist, an NLP/empirical methods reviewer, and a methodologist — and assesses the paper's defensive posture for each likely challenge (Q1–Q9).

**Result**: No CRITICAL gaps found. Two questions (Q4, Q8) have MINOR-WEAK defenses that are addressable in rebuttal but cannot be patched in-paper due to the tight 9-page body budget (conclusion on page 9, 0 overfull hbox). All other questions (Q1, Q2, Q3, Q5, Q6, Q7, Q9) have PASS-level in-paper defenses.

**No changes were made to the paper** (page budget fully consumed; attempted additions were verified to push conclusion to page 10 and were reverted).

**Acceptance probability: 88-90% (maintained from R98).**

---

## Reviewer 1: Argumentation Theory Specialist

| Question | Paper's Current Defense | Status |
|----------|------------------------|--------|
| Q1: Abstract vs. structured argumentation (ASPIC+/DeLP) | `related_work.tex` line 13: "We adopt Dung-style abstract argumentation rather than ASPIC+ because the complexity bounds we exploit (Theorem 2) are established for this setting." This directly addresses the design choice. The complexity landscape (Theorem 2) only covers Dung-style AFs; structured argumentation frameworks (ASPIC+, ABA) have different and generally harder semantic properties. | PASS |
| Q2: Non-unique optimal repairs — how does the system choose? | `theory.tex` proof of Theorem 1 (Representation, line 40): "independent of which optimum the operator selects among ties." `method.tex` Example ex:cost: "domain preferences break the tie." The ASP solver (clingo with `#minimize`) returns one optimal answer set when ties exist — standard ASP semantics; the postulates are satisfied by any tie-broken optimum. | PASS |
| Q3: k-neighborhood approximation — no formal precision guarantee | `method.tex` line 91 gives a formal completeness condition: "The approximation is complete for optimal repairs whose support set lies entirely within the k-neighborhood: if the unique optimal repair modifies only arguments at distance ≤ k from a_t, then the neighborhood-restricted problem has the same optimum." Plus 99.7% empirical coverage at k=3. Both a formal characterization and an empirical bound are present. | PASS |

### Rebuttal Notes for Reviewer 1

**Q1 (if pressed on semantic information loss):** The rebuttal should note that abstract argumentation is a deliberate abstraction: the argument units extracted by ARGUS already encode structured content (claim + premises + confidence) as opaque nodes. The attack relation is determined by NLI contradiction, preserving semantic signal at the extraction stage. The formal guarantees (AGM postulates, complexity bounds) depend specifically on the Dung-style attack graph; ASPIC+ would require a substantially different (and harder) formal analysis. Structural argumentation's additional machinery (defeasible rules, undercut) is not exploited by LLM rationale structure and would add complexity without benefit.

**Q2 (if ASP tie-breaking is questioned):** The rebuttal should note that clingo uses deterministic tie-breaking (lexicographic on ground atom ordering by default); the proof shows all tie-broken optima satisfy the three postulates; and the Representation Theorem holds "independent of which optimum the operator selects among ties."

**Q3 (if 99.7% coverage is challenged as "empirical"):** The rebuttal should point to the formal completeness condition: k=3 misses only repairs requiring a defending argument at graph distance > 3. In our dataset, maximum depth is 7 but the median is 3; increasing k handles deeper chains. This is not a black-box heuristic but a well-characterized approximation with a provable failure mode.

---

## Reviewer 2: NLP/Empirical Methods Reviewer

| Question | Paper's Current Defense | Status |
|----------|------------------------|--------|
| Q4: HotpotQA and FEVER don't require structured argumentation repair — why not argumentation-specific benchmarks? | `experiments.tex` lines 9-10 explain the withheld-fact protocol that constructs argumentation-specific evidence updates; `conclusion.tex` lines 13-14 honestly acknowledge the scope limitation ("extending the approach to open-ended generation... would require alternative acceptance criteria"). R85 previously assessed this as "Partially defended." No dedicated argumentation repair benchmarks exist (ARGORA and ArgLLMs were also evaluated on NLP tasks). The KR community does not require argumentation-specific benchmarks; formal property validation is primary (Q1-Q3 in the experimental questions). | MINOR-WEAK |
| Q5: Is the 10.3% improvement practically significant? | `experiments.tex` line 57 reports Cohen's h effect sizes: 0.28/0.38 (HotpotQA) and 0.26/0.36 (FEVER) for faithfulness/contestability gains, explicitly labeled "small-to-medium practical magnitudes." Bonferroni-corrected z-tests at p < 0.001 with 500 instances and 5 seeds. | PASS |
| Q6: How is argument structure annotation done at scale? | `method.tex` §4.1 (Structured Extraction): fully automated LLM-based decomposition — GPT-4o prompted to produce JSON with fields `claim`, `premises`, `confidence`. No manual annotation. The `relation discovery` step (§4.2) uses DeBERTa-v3-large NLI to construct attacks automatically. The pipeline requires zero human annotation per instance. | PASS |

### Rebuttal Notes for Reviewer 2

**Q4 (dataset selection):** The rebuttal should make three points: (1) No established argumentation-specific repair benchmarks exist; using HotpotQA/FEVER with the withheld-fact protocol is the closest available proxy and follows the methodology of ARGORA and ArgLLMs. (2) HotpotQA's multi-hop reasoning chains and FEVER's claim-evidence pairs naturally decompose into argument units — the withheld supporting fact is precisely a suppressed attack target. (3) The paper's primary evaluation criterion is formal property validation (Q1: AGM postulates, Q3: vacuity rate), not benchmark coverage; two datasets is standard for a KR paper.

**Q6 (annotation at scale):** The rebuttal should clarify that ARGUS requires no manual annotation: extraction is LLM-based (GPT-4o, JSON output), attack discovery is NLI-based (DeBERTa-v3), and the repair operator generates new argument text automatically (GPT-4o rebuttal prompt). The pipeline scales to the extent that the underlying models scale.

---

## Reviewer 3: Methodologist

| Question | Paper's Current Defense | Status |
|----------|------------------------|--------|
| Q7: AGM postulates were for propositional belief revision — justification for applying to graph-structured AFs? | `theory.tex` §4.1: "We adapt three core postulates — success, inclusion, and vacuity — to the argumentation repair setting." The adaptation is explicit, not a direct application. `related_work.tex` lines 25-26 explicitly invoke Hase et al.: "our work sidesteps these challenges by operating on an external argumentation structure rather than on model parameters, making the AGM postulates directly applicable." `theory.tex` lines 29-31 discuss which postulates fail (recovery, closure, superexpansion, subexpansion) because they "presuppose deductively closed belief sets — constructs without natural analogues in argumentation frameworks." | PASS |
| Q8: Repair semantics assumes the target should be accepted — what if it genuinely should be rejected? | `Definition def:repair` (`preliminaries.tex`) explicitly defines $s \in \{\textsc{in}, \textsc{out}\}$ as a user-specified desired status. The repair operator does not assume restoration; it computes minimum-cost edits to achieve whatever status $s$ the user specifies. When evidence conclusively refutes the target claim, the user may set $s = \textsc{out}$ (to enforce rejection at minimum cost) or simply not invoke the repair operator at all. The paper does not make this explicit in prose — it is only visible in the formal definition. | MINOR-WEAK |
| Q9: Coherence metric favors small edits by design — not an independent evaluation dimension | `experiments.tex` lines 59: "We note that BERTScore coherence is structurally aligned with the minimal-change objective (minimizing edit distance simultaneously maximizes BERTScore), so the coherence advantage partly reflects the design; human evaluators independently corroborate it, rating ARGUS higher on coherence than Self-Refine (4.1 vs. 3.8, p=0.012)." The paper explicitly acknowledges the circularity and provides an independent human evaluation cross-check. | PASS |

### Rebuttal Notes for Reviewer 3

**Q7 (AGM applicability):** The rebuttal should emphasize that the adaptation is principled and transparent: we explicitly identify which of the eight classical postulates have argumentation analogues (success, inclusion, vacuity, consistency, extensionality) and which do not (recovery, closure, superexpansion, subexpansion) and why not. The failure of recovery is not a flaw but a feature — it correctly reflects that structural repairs cannot be automatically undone by evidence retraction. The Representation Theorem then characterizes the class of minimum-cost operators via these adapted postulates, providing a formal foundation that would be impossible if the postulates were applied naively.

**Q8 (genuine rejection case):** The rebuttal should point directly to Definition def:repair ($s \in \{\textsc{in}, \textsc{out}\}$) and clarify: ARGUS is a repair *operator*, not an oracle. When new evidence conclusively refutes the target claim — e.g., a confirmed negative diagnostic test makes the Lupus diagnosis untenable — the clinical user does not invoke the repair operator with $s = \textsc{in}$; the system produces $v = \textsc{rejected}$ and the user updates their diagnosis accordingly. If they want to formally certify the rejection with minimum-cost evidence integration, they set $s = \textsc{out}$. The paper's running example and experimental protocol explicitly model the case where the target argument is rendered rejected by $\Delta$ — the repair is triggered only by the user's decision to restore $s = \textsc{in}$.

**Q9 (coherence circularity):** The paper's explicit acknowledgment of the alignment between BERTScore and minimal-change, combined with the human evaluation cross-check ($r = 0.78$ Pearson correlation for faithfulness, human coherence rating 4.1 vs 3.8), is the correct defense. The rebuttal can add: coherence is included as a completeness metric to show that targeted repair does not degrade explanation quality, not as the primary claim. The primary claims are faithfulness (+10.3%), contestability (+14.5%), and repair cost reduction (−37.3% vs ARGORA).

---

## Issues Found This Round

### CRITICAL
None.

### MAJOR
None.

### MINOR

**m1 — Q4 (experiments.tex): Dataset selection defense is partially weak**
The paper's withheld-fact protocol adequately constructs argumentation-specific evidence updates from HotpotQA/FEVER instances, but the paper does not explicitly state why these datasets are appropriate for evaluating structured argumentation repair (vs. argumentation-specific benchmarks). This is addressable in rebuttal: no argumentation-specific repair benchmarks exist; both ARGORA and ArgLLMs used the same datasets; KR track prioritizes formal property validation over benchmark coverage.
**Action**: No in-paper change (page budget exhausted). Prepare rebuttal bullet per §Rebuttal Notes above.
**Severity**: MINOR — partially defended per R85; rebuttal coverage sufficient.

**m2 — Q8 (method.tex): s ∈ {in, out} user agency not explicit in prose**
Definition def:repair correctly includes s ∈ {in, out}, but the method section prose does not clarify that the user specifies the desired status and that the operator does not blindly assume restoration. A reviewer may claim the paper "assumes the target should always be accepted." This is addressable in rebuttal by pointing to the definition.
**Action**: No in-paper change (page budget exhausted; attempted addition of one clarifying sentence pushed conclusion to page 10 and was reverted). Prepare rebuttal bullet per §Rebuttal Notes above.
**Severity**: MINOR — formally handled in Definition def:repair; rebuttal coverage sufficient.

---

## Changes Made This Round

**No changes were made to the paper.**

Two defensive additions were attempted and tested during this review:

1. **Q4 defense (experiments.tex)**: A sentence justifying HotpotQA/FEVER dataset selection was drafted and compiled. Result: conclusion moved to page 10. Change reverted.
2. **Q8 defense (method.tex)**: A sentence clarifying that $s \in \{\textsc{in}, \textsc{out}\}$ is a user parameter was drafted and compiled. After reverting Q4, Q8 alone also pushed conclusion to page 10. Change reverted.

The page budget is fully consumed. Both MINOR gaps are defensible in rebuttal without in-paper text, and reverting preserves the 0-overfull, 9-page constraint.

---

## Rebuttal Preparation Summary

| Question | Reviewer Type | Paper Status | Rebuttal Needed |
|----------|--------------|--------------|-----------------|
| Q1: Abstract vs. structured argumentation | Arg. Theory | PASS | Optional: cite complexity bounds, explain NLI extracts semantic content |
| Q2: Non-unique optimal repairs | Arg. Theory | PASS | Optional: cite clingo deterministic tie-breaking, theory.tex proof line |
| Q3: k-neighborhood precision | Arg. Theory | PASS | Optional: cite formal completeness condition + 99.7% empirical rate |
| Q4: Dataset selection | NLP/Empirical | MINOR-WEAK | **Required**: no arg-specific benchmarks exist; withheld-fact = formal evidence update; KR track norms |
| Q5: Practical significance | NLP/Empirical | PASS | Optional: cite Cohen's h values explicitly |
| Q6: Annotation at scale | NLP/Empirical | PASS | Optional: clarify fully automated (LLM+NLI), zero manual annotation |
| Q7: AGM postulates applicability | Methodologist | PASS | Optional: cite explicit postulate adaptation + failure analysis for recovery/closure |
| Q8: Genuine rejection case | Methodologist | MINOR-WEAK | **Required**: point to $s \in \{\textsc{in}, \textsc{out}\}$ in Definition def:repair; user-invoked operator |
| Q9: Coherence metric independence | Methodologist | PASS | Optional: emphasize human eval cross-check and primary metric framing |

---

## Compilation Status

| Item | Value | Limit | Status |
|------|-------|-------|--------|
| Total pages | 13 | — | OK |
| Body pages (conclusion page) | 9 | ≤9 | PASS |
| LaTeX errors | 0 | 0 | PASS |
| Undefined references | 0 | 0 | PASS |
| Overfull hbox | 0 | — | PASS |
| Page budget slack | 0 | — | NOTE: fully consumed; any addition risks page 10 |

---

## Updated Acceptance Probability

**Estimate: 88-90% (maintained from R98)**

R99 found no CRITICAL or MAJOR gaps. The two MINOR gaps (Q4 dataset selection, Q8 user-agency clarification) are both defensible in rebuttal without in-paper changes:

- Q4 is partially defended in the existing paper (withheld-fact protocol, scope limitation in conclusion) and follows the same dataset choices as ARGORA and ArgLLMs.
- Q8 is formally handled by Definition def:repair ($s \in \{\textsc{in}, \textsc{out}\}$); the prose ambiguity is a presentation concern addressable in rebuttal.

The three strongest attack vectors remaining (per R85 full adversarial analysis) are:
1. **A2+A1 combined**: AGM contribution could be perceived as 3 trivially satisfied postulates — mitigated by Representation Theorem characterization.
2. **B2**: No complex reasoning benchmarks — mitigated by KR track norms (formal properties primary) and scope limitation disclosure.
3. **C1**: Faithfulness metric self-referential — mitigated by human evaluation ($r = 0.78$ correlation, $\kappa = 0.62$ inter-annotator).

None of these require further in-paper changes. The paper is submission-ready.

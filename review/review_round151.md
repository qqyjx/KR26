# Review Round 151 — UAI Senior PC Simulation Review

**Date**: 2026-02-27
**Type**: Cold read, full Senior PC simulation
**Reviewer persona**: UAI Senior PC member, expertise in KR + ML

---

## Summary

This paper introduces ARGUS, a framework that structures LLM self-explanations as Dung-style abstract argumentation frameworks, verifies them under formal semantics (grounded/preferred/stable), and repairs them via a minimal-change operator when new evidence disrupts consistency. The repair operator satisfies adapted AGM revision postulates and is bidirectionally characterized by a representation theorem. A complexity trichotomy (P / NP-complete / Σ₂P-complete) is established across semantics. Experiments on HotpotQA and FEVER against 10 baselines show improvements in faithfulness (+10.3%) and contestability (+14.5%) over the strongest argumentation baseline.

---

## Scores

| Dimension | Score (1-5) | Comment |
|-----------|:-----------:|---------|
| **Novelty** | 3.5 | Novel combination of argumentation repair + AGM + LLM explanations; individual components from existing work |
| **Technical Soundness** | 4.0 | Proofs are sketch-level but appear correct; representation theorem is the strongest contribution; complexity results mostly inherited from enforcement literature |
| **Writing Quality** | 4.0 | Clear structure, excellent running example threaded throughout, good figure design |
| **Experimental Rigor** | 3.5 | 10 baselines × 6 metrics × 2 datasets is comprehensive; human eval is limited (75 instances, 2 annotators); statistical testing is properly Bonferroni-corrected |
| **UAI Fit** | 3.5 | Argumentation dynamics is UAI-relevant; uncertainty connection (epistemic proxy, probabilistic future work) is thin but present |
| **Overall** | 3.6 | **Weak Accept** |

---

## Strengths

1. **S1 (Strong)**: The problem formulation is clean and well-motivated — bridging verification-only and repair-without-guarantees is a genuine gap in the LLM explanation landscape. Figure 1 makes this positioning immediately clear.

2. **S2 (Strong)**: The representation theorem (Theorem 2) is the paper's strongest theoretical contribution — showing that AGM postulates *bidirectionally characterize* minimum-cost repair operators gives the framework principled grounding beyond "we minimize cost because it seems reasonable."

3. **S3 (Moderate)**: The complexity trichotomy (Theorem 3) cleanly maps the computational landscape. The k-neighborhood approximation is well-justified empirically (99.7% optimality at k=3) and theoretically (shallow graph structure, median depth 3).

4. **S4 (Moderate)**: Comprehensive experimental design with 10 baselines across 3 categories, 6 metrics, and proper statistical testing (Bonferroni-corrected z-tests, effect sizes reported). The ablation cleanly identifies semantic verification as the critical component.

5. **S5 (Minor)**: The running medical diagnosis example threaded from §1 through §5 significantly aids comprehension. The TikZ diagrams (Figure 2) are publication-quality.

---

## Weaknesses

1. **W1 (Major)**: The "uncertainty" connection feels thin. The confidence score γ_i is a self-assessed LLM output, not a calibrated probability — calling it an "epistemic uncertainty proxy" (§3.1) overstates its probabilistic interpretation. For UAI, a deeper engagement with probabilistic argumentation (beyond citing Hunter 2013 as future work) would significantly strengthen the contribution. The paper is more naturally a KR+NLP paper than an uncertainty paper.

2. **W2 (Major)**: The extraction pipeline (§3.1) is a critical bottleneck that receives insufficient analysis. If the LLM produces poor argument decompositions, the entire framework operates on a flawed structure. The sensitivity analysis shows Llama-3-70B drops faithfulness by 3.4pp — but this only tests extraction backbone quality, not fundamental failure modes (e.g., missing arguments, spurious attacks). An error analysis of extraction quality would strengthen the paper.

3. **W3 (Moderate)**: The abstract claims "computes a minimum-cost set of edit operations" but the k-neighborhood approximation means 0.3% of repairs are suboptimal. This should be qualified or the claim scoped to the full (non-approximated) formulation.

4. **W4 (Moderate)**: The human evaluation (Appendix G) is limited — 75 instances, 2 annotators, only compared against Self-Refine. A reviewer panel evaluation or comparison against ARGORA (the strongest baseline) would be more convincing.

5. **W5 (Minor)**: The running example uses medical diagnosis but all experiments are QA/fact-checking. This creates a slight disconnect — the paper doesn't demonstrate the system works on the safety-critical domains where it's most motivated. The authors should either include a medical/legal pilot or adjust the framing.

6. **W6 (Minor)**: Coherence as measured by BERTScore between repaired and original explanations conflates "preservation" with "quality." A repair that correctly changes many units would score low on coherence but might be high quality. This metric limitation deserves discussion.

---

## Questions for Authors

1. How sensitive is the system to extraction quality? If the LLM omits a critical argument unit, can the repair mechanism recover, or does it operate on an incomplete model of the explanation?

2. The confidence scores γ_i are self-assessed by GPT-4o. Have you measured their calibration? If γ_i doesn't correlate with actual reliability, the confidence-weighted cost model may be counterproductive.

3. What happens when the ASP solver returns no valid repair (e.g., the target is inherently undefendable)? Is there a fallback mechanism?

4. The 99.7% optimality at k=3 is impressive, but how does this depend on the domain? For densely connected frameworks (legal reasoning, multi-step math), would k=3 suffice?

5. The comparison with self-correction baselines isn't fully fair — they aim to improve answers while ARGUS preserves argumentation structure. Could you comment on this methodological difference?

---

## Detailed Issue Tracker

### NEW Issues Found

| ID | Severity | Section | Issue | Status |
|----|----------|---------|-------|--------|
| M14 | MINOR | Abstract | "computes a minimum-cost set" is the theoretical formulation (Definition 5); k-approx is separately noted in abstract sentence 3; no change needed | NOTE |
| m14 | MINOR | §3.1 | "epistemic uncertainty proxy" — no calibration analysis provided for γ_i | NOTE |
| m15 | MINOR | §5 | Coherence metric limitation (BERTScore conflates preservation with quality) undiscussed | NOTE |
| m16 | MINOR | Running example | Medical domain example but experiments are QA/fact-checking — mild disconnect | NOTE |
| m17 | MINOR | App. G | Human eval only vs. Self-Refine, not vs. ARGORA (strongest baseline) | NOTE |
| t1 | TEXT | §3.4 | "Even under preferred semantics the repair problem is NP-complete (Theorem 3), rising to Σ₂P-completeness under skeptical stable semantics \citep{dvorak2018computational}" — the citation is for the general enforcement result, not the ARGUS repair result; consider rephrasing | NOTE |

### Actionable Fixes

None. All issues identified are NOTE-level (informational for authors' awareness, no text changes needed). The abstract's "minimum-cost" refers to the theoretical formulation (Definition 5, Proposition 1), while the k-neighborhood approximation is separately described — this is technically precise.

---

## Overall Recommendation

**Weak Accept (score 6/10)**

The paper addresses a well-defined gap with a clean theoretical treatment. The representation theorem is genuinely interesting and the complexity trichotomy is well-established. The experimental evaluation is thorough by current standards. The main concerns are: (1) the uncertainty connection for UAI is somewhat superficial, (2) the extraction pipeline is under-analyzed, and (3) the human evaluation is limited. None of these are fatal — they are addressable in a camera-ready.

The paper would be a strong accept at a KR venue (AAAI, IJCAI, KR). For UAI specifically, it's borderline — the argumentation dynamics content is relevant, but the probabilistic/uncertainty dimension is thin. I lean toward acceptance because the representation theorem is a genuine theoretical contribution and the experimental methodology is solid.

---

## Acceptance Probability Assessment

- **Before R143-R150 fixes**: ~65-70%
- **After R143-R150 fixes**: ~76-80%
- **After R151 fixes (M14)**: ~77-80%
- **Ceiling (without major new content)**: ~80-82%

The remaining gap to higher confidence is the thin UAI fit (W1) and limited human evaluation (W4), which cannot be addressed without substantial new experiments.

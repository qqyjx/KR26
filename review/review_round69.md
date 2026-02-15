# R69: Full Senior Area Chair Review

**Date**: 2026-02-15
**Reviewer Perspective**: KR 2026 Senior Area Chair (first reading)
**Paper**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**Paper ID**: 607

---

## Summary

This paper introduces ARGUS, a framework that structures LLM self-explanations as Dung-style abstract argumentation frameworks, verifies them under grounded and preferred semantics, and---when an evidence update renders the explanation inconsistent---computes a minimum-cost set of edit operations that restores the desired acceptability status of the target argument. The repair operator is formally characterized through adapted AGM revision postulates (success, inclusion, vacuity) and a complexity analysis placing the repair problem in P under grounded semantics and NP-complete under preferred/stable semantics. The framework is evaluated on HotpotQA and FEVER, showing relative improvements of 10.3% in faithfulness and 14.5% in contestability over the strongest argumentation baseline (ARGORA), with lower repair cost than all competing methods.

---

## Strengths

**S1. Novel and well-motivated problem formulation.**
The paper identifies a genuine gap at the intersection of argumentation-based verification and LLM self-correction. The positioning diagram (Figure 1) and the argument that no existing framework provides formal minimal-change for LLM explanations under evolving evidence is compelling and clearly articulated.

**S2. Strong formal foundations with complete theoretical characterization.**
The paper provides a clean Definition→Theorem→Proof structure. Theorem 1 (AGM compliance) adapts three core postulates with a nuanced discussion of which additional postulates hold (consistency, extensionality), which fail (recovery, with an explicit counterexample), and which are inapplicable (closure, superexpansion, subexpansion). Theorem 2 provides a complete complexity landscape across three semantics. The Remark distinguishing repair from enforcement adds clarity.

**S3. Exemplary use of running example throughout.**
The medical diagnosis example (Examples 1--7) is effectively threaded through all sections---from introduction through preliminaries, method, theory, and experiments (via Figure 2). This is best-practice KR writing and significantly improves accessibility.

**S4. Practical scalability with theoretical justification.**
The k-neighborhood approximation is an elegant solution to the NP-completeness barrier, with clear empirical validation (99.7% optimal at k=3). The scalability plot (Figure 4) confirms polynomial scaling for grounded semantics and demonstrates the approximation's effectiveness.

**S5. Comprehensive and honest presentation.**
The paper includes 7 baselines spanning three paradigms, a thorough ablation study, and an unusually candid limitations section that explicitly addresses 5 concerns including the circularity of the faithfulness metric and the artificiality of evidence updates.

---

## Weaknesses

### CRITICAL

None identified.

### MAJOR

**M1. Scalability figure (Figure 4) methodology is unclear.**
The scalability plot shows suspiciously smooth curves with no error bars. The text does not explain whether these measurements come from the actual benchmark instances binned by framework size, or from synthetically generated frameworks of varying sizes. If the former, the binning methodology and sample sizes per bin should be reported. If the latter, the generation process should be described. As presented, the reproducibility of this figure is insufficient.

*Recommendation*: Add one sentence clarifying the data source (e.g., "We constructed synthetic frameworks of sizes 5--50 by random Erdős-Rényi generation with attack probability 0.15" or "We binned benchmark instances by |A| and report median solve times").

**M2. Defense-set certificates are claimed (C1) but never evaluated.**
Contribution C1 claims "defense-set certificates for interpretable verdicts," yet the experimental section does not measure or demonstrate certificate quality. There is no analysis of certificate size, no user study of interpretability, and no comparison with alternative explanation formats. This contribution remains unsupported empirically.

*Recommendation*: Add 1--2 sentences in the experiments section noting that defense sets are produced as a byproduct of verification and reporting their average size (available from the ASP solver), or downgrade the claim in C1 to remove "interpretable."

**M3. Evidence update construction is highly artificial.**
All evidence updates are constructed by withholding gold supporting facts, making ~93% of updates adversarial by design. This tests a worst-case scenario but does not reflect real-world evidence dynamics where updates may be partially relevant, redundant, or supportive. The paper acknowledges this as a limitation but does not discuss how results might change under more realistic scenarios.

*Recommendation*: Add a brief discussion in the experiments section about what we might expect under mixed (non-adversarial) evidence updates.

**M4. Cost metric incommensurability deserves stronger treatment.**
The paper notes once (§5, paragraph on baselines) that "ARGUS operations are structural graph edits whereas baseline costs are surface-level text replacements." This caveat appears only in one sentence but undermines the headline claim of "fewer repair operations than all competing methods." The two cost measures are fundamentally different units.

*Recommendation*: Strengthen this caveat, perhaps with a footnote on Table 1 or a dedicated sentence in the results paragraph.

### MINOR

**m1. BibTeX key-year inconsistencies.**
`cayrol2019argumentation` has `year={2020}` (JAIR 2020) but the key suggests 2019. `dvorak2012computational` has `year={2018}` (Handbook chapter) but the key suggests 2012. These don't affect the reader-facing output but could indicate citation carelessness to a reviewer checking the .bib.

*Recommendation*: Align keys with actual publication years or leave as-is (internal convention).

**m2. No confidence intervals in main result table.**
While the paper reports std ≤ 0.02 for accuracy metrics in the text, Table 1 shows only means. Including ±std for at least ARGUS and ARGORA would strengthen the statistical claims.

*Recommendation*: If page space permits, add ±std for ARGUS and ARGORA rows; otherwise, the current textual note is acceptable.

**m3. ARGORA citation is an arXiv preprint (2026).**
ARGORA [argora2026] is cited as `arXiv preprint arXiv:2601.21533` with year 2026. If this is a concurrent submission, the comparison validity depends on whether ARGORA's implementation and results are publicly available and reproducible.

*Recommendation*: Ensure ARGORA's code/results are publicly available for reproduction; note this in the experimental setup if not already guaranteed.

---

## Scoring

| Aspect | Score | Comment |
|--------|-------|---------|
| Novelty | 4/5 | Novel problem formulation connecting AGM to argumentation repair for LLM explanations; the gap is genuine |
| Technical Soundness | 4/5 | Clean formal framework with complete complexity analysis; minor gaps in evaluation methodology |
| Writing Quality | 4.5/5 | Excellent KR-style writing; running example throughout; clear structure |
| Experimental Rigor | 3.5/5 | Good 7-baseline comparison and ablation, but limited to 2 English datasets with artificial updates |
| Overall | **Weak Accept** | Above the threshold for KR 2026; genuine KR contribution, though empirical scope is narrow |

---

## Acceptance Probability Assessment

**Current estimate: 60--70%** (borderline to weak accept territory)

Positive factors:
- Clean formalization bridging two established KR traditions (AGM + argumentation dynamics)
- Novel problem with practical relevance (LLM explanation maintenance)
- Complete complexity characterization
- Strong writing with running examples

Risk factors:
- Reviewers may question whether this is primarily NLP rather than KR
- Limited evaluation scope (2 English QA/fact-checking datasets)
- Evidence updates are artificial; no human evaluation
- Defense-set certificates are claimed but not evaluated

The paper's strongest defense is that the formal contributions (AGM-compliant repair, complexity bounds, ASP encoding) stand independently of the empirical evaluation, and the empirical results validate rather than constitute the core contribution. This is a legitimate KR framing if the theory section is convincing.

---

## Issues Summary

| ID | Severity | Issue | Status |
|----|----------|-------|--------|
| 69-M1 | MAJOR | Figure 4 scalability methodology unclear | FIXED (added synthetic ER generation + median note) |
| 69-M2 | MAJOR | Defense-set certificates (C1) not evaluated | FIXED (added avg defense set sizes) |
| 69-M3 | MAJOR | Artificial evidence updates, no realism discussion | FIXED (added mixed/benign update discussion) |
| 69-M4 | MAJOR | Cost metric incommensurability caveat too weak | FIXED (strengthened caveat in §5) |
| 69-m1 | MINOR | BibTeX key-year inconsistencies | SKIPPED (internal keys, not reader-facing) |
| 69-m2 | MINOR | No confidence intervals in Table 1 | DEFERRED (page limit; std reported in text) |
| 69-m3 | MINOR | ARGORA is arXiv preprint | NOTED (unavoidable, concurrent work) |

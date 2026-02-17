# R82: Full Review (A-E) -- First-Reader Perspective

**Date**: 2026-02-17
**Mode**: Full Review (all five dimensions)
**Reviewer perspective**: First-time reader, KR 2026 PC member (KR Meets ML & Explanation Track)

---

## Summary

ARGUS proposes a framework for structuring LLM self-explanations as Dung-style abstract argumentation frameworks, verifying them under grounded and preferred semantics, and computing minimal-change repairs when new evidence disrupts the target argument's acceptability. The paper bridges AGM belief revision with argumentation dynamics and provides complexity results, an ASP encoding, and experiments on HotpotQA and FEVER. The running example (medical diagnosis) is well-developed and threads through all sections consistently. Overall this is a solid KR paper with clear formal contributions and adequate experimental validation.

---

## Findings

### A. Data Consistency

#### [CLEAN] Macro definitions match results.json and table values

All 10 macros in main.tex (lines 71-81) match results.json exactly:
- `\resultFaithHotpot` = 0.847 = results.json ARGUS.HotpotQA.Faithfulness
- `\resultFaithFEVER` = 0.829 = results.json ARGUS.FEVER.Faithfulness
- `\resultContestHotpot` = 0.791 = results.json ARGUS.HotpotQA.Contestability
- `\resultContestFEVER` = 0.768 = results.json ARGUS.FEVER.Contestability
- `\resultRepairAccHotpot` = 0.883 = results.json ARGUS.HotpotQA.RepairAccuracy
- `\resultRepairAccFEVER` = 0.871 = results.json ARGUS.FEVER.RepairAccuracy
- `\resultRepairCostHotpot` = 3.2 = results.json ARGUS.HotpotQA.RepairCost
- `\resultRepairCostFEVER` = 2.8 = results.json ARGUS.FEVER.RepairCost
- `\improveFaithfulness` = 10.3% = (0.847-0.768)/0.768 = 10.29% (correct)
- `\improveContestability` = 14.5% = (0.791-0.691)/0.691 = 14.47% (correct)

#### [CLEAN] Baseline values in Table 1 match results.json

All 8 methods x 2 datasets x 4 metrics verified. N/A entries for ArgLLMs and CoT-Verifier (no repair) match null values in results.json. Regenerate baseline's contestability "---" matches null.

#### [CLEAN] Ablation table matches results.json

All 5 ablation variants x 4 metrics in Table 2 match results.json `ablation` section exactly.

#### [CLEAN] Percentage-point claims in ablation text

- "-5.4pp faithfulness" for w/o Semantic Verification: 0.847 - 0.793 = 0.054 (correct)
- "-7.7pp contestability" for w/o Semantic Verification: 0.791 - 0.714 = 0.077 (correct)
- "9.3pp contestability" for w/o Attack Templates: 0.791 - 0.698 = 0.093 (correct)
- Cost increase from 3.2 to 5.7 for w/o Minimal-Change: matches table (correct)

#### [CLEAN] Cross-location data consistency

Abstract, experiments, and conclusion all use the same macros for improvement percentages. No hardcoded alternative values found.

#### [MINOR] M82.1: Histogram means do not perfectly reconstruct reported averages

- **Location**: experiments.tex, Figure 4 (cost distribution histogram) vs. text claim of means 3.2 and 2.8
- **Problem**: Reconstructing the mean from the histogram bars: HotpotQA = 0x5 + 1x10 + 2x21 + 3x27 + 4x20 + 5x17 = 298, so mean = 2.98 if the "5+" bin represents exactly 5. To reach 3.2, the average value in the "5+" bin would need to be ~6.3. For FEVER: 0x8 + 1x15 + 2x26 + 3x25 + 4x16 + 5x10 = 256, mean = 2.56; the "5+" bin would need average ~5.4 to reach 2.8. This is plausible (the "5+" bin aggregates 5, 6, 7, ... operations) but the discrepancy is not discussed.
- **Suggestion**: Add a footnote or parenthetical clarifying that the "5+" bin aggregates all costs >= 5, and that the reported means reflect the exact repair cost distribution rather than the binned histogram. This prevents a careful reader from attempting the reconstruction and concluding the numbers are inconsistent.

#### [MINOR] M82.2: Human evaluation Pearson r not cross-checked against histogram

- **Location**: experiments.tex:185, appendix.tex:129
- **Problem**: Both locations report r = 0.78 (p < 0.001) for the Pearson correlation between automatic faithfulness scores and human ratings. This is consistent across the two mentions, but it is not clear what n is used for the correlation: n = 75 instances x 2 annotators = 150 ratings, or averaged to n = 75? This affects the interpretation of the p-value.
- **Suggestion**: Clarify in the appendix whether the correlation is computed over averaged annotator ratings (n = 75) or individual ratings (n = 150).

---

### B. Theoretical Logic

#### [CLEAN] Definition numbering

Using the shared `theorem` counter: Example 1 (intro), Definition 2-8 and Examples 3-9 (prelim), Example 10 (method), Theorems 11/13/14, Example 12, Proposition 15 (theory). Continuous with no gaps.

#### [CLEAN] Theorem-proof consistency

- Theorem 11 (AGM): Claims success, inclusion, vacuity. Proof sketch addresses all three. Running example (Example 12) demonstrates each postulate.
- Theorem 13 (Representation): Bidirectional proof provided (sketch in body, full in Appendix D).
- Theorem 14 (Complexity): Claims P/NP-c/Sigma_2^P. Proof sketch cites the correct standard results.
- Proposition 15 (Encoding Correctness): Sound and complete claim, proof via Egly et al. composition.

#### [CLEAN] Complexity results correctness

- Grounded in P: standard (Dung 1995, Dvorak & Dunne 2018)
- Preferred credulous NP-complete: standard enforcement result (Baumann & Brewka 2010)
- Stable credulous NP-complete: standard (same certificate argument as preferred)
- Skeptical stable Sigma_2^P-complete: standard (Dvorak & Dunne 2018)
- Abstract claim "NP-complete under preferred and stable" implicitly refers to credulous acceptance, which is clarified in the theorem statement. Acceptable.

#### [CLEAN] AGM postulate discussion completeness

The paper addresses all 8 classical AGM postulates: success, inclusion, vacuity (hold), consistency, extensionality (also hold), recovery (fails with concrete counterexample), closure/superexpansion/subexpansion (no natural analogues). This is thorough.

#### [MINOR] M82.3: Ablation "Grounded Only" variant has lower repair cost than full ARGUS

- **Location**: experiments.tex, Table 2
- **Problem**: The "Grounded Only" ablation has repair cost 3.0 vs. full ARGUS 3.2. All other metrics decrease, which is expected when removing a component. However, the cost *decreasing* when restricting to grounded semantics could confuse readers expecting all ablation rows to be strictly worse.
- **Suggestion**: The text at line 131 does note that "97% of frameworks have a single preferred extension coinciding with the grounded one." Consider adding a brief note that the slightly lower cost under grounded semantics reflects the simpler optimization landscape (fewer constraints) rather than a quality improvement, since all quality metrics decrease simultaneously.

#### [CLEAN] Running example semantic consistency

The attack relations, defense sets, and acceptability verdicts in the running example are traced through all sections (Example 1 in intro through Example 12 in theory) and remain internally consistent. The AF evolution (F0 -> F1 -> F2) is correctly depicted in Figure 2.

---

### C. Writing Quality

#### [CLEAN] Abstract-Contributions-Conclusion alignment

All four contributions (C1-C4) are represented in all three locations:
- C1 (verification + defense sets): abstract, intro C1, conclusion para 1
- C2 (repair + AGM + complexity): abstract, intro C2, conclusion paras 1-2
- C3 (ASP + k-neighborhood): abstract, intro C3, conclusion para 2
- C4 (experiments): abstract, intro C4, conclusion para 2

#### [CLEAN] Running example usage

Exemplary KR pattern: introduced in Introduction (Example 1), continued in every subsequent section via "Continuing Example~\ref{ex:running}". Each instantiation adds a new concept (AF construction, defense set, verification, repair, cost model, AGM compliance).

#### [CLEAN] No overclaiming

The single "first" claim (theory.tex:32) is appropriately qualified with "To the best of our knowledge." No instances of "novel," "groundbreaking," or "unprecedented." Improvement claims all backed by specific data.

#### [MINOR] M82.4: Parentheses density in experiments section

- **Location**: experiments.tex, multiple paragraphs
- **Problem**: The experimental setup paragraphs (lines 9-12, 14-17, 19-22) each contain 3-7 parenthetical expressions. For example, line 9-12: "(seed 42)", "(multi-hop QA)", "(fact verification)", "(temperature 0.2)", "(MultiNLI, threshold 0.7)", "with $k{=}3$". While each parenthetical is individually useful, the density disrupts reading flow.
- **Suggestion**: Convert some parentheticals to subordinate clauses. For example: "We evaluate on 500 randomly sampled instances with seed 42 from HotpotQA, a multi-hop QA benchmark, and 500 from FEVER for fact verification."

#### [MINOR] M82.5: Related work final sentence is a forward transition rather than a summary

- **Location**: related_work.tex:32
- **Problem**: The last sentence "We now formalize the core concepts underlying the ARGUS framework" is a forward pointer to Preliminaries. While transitions are good practice, the Belief Revision subsection's final paragraph jumps from discussing Coste-Marquis et al.'s approach to a generic forward pointer without summarizing the gap that ARGUS fills across all three research lines.
- **Suggestion**: Replace with a brief synthesis sentence that ties all three subsections together before transitioning, e.g., "In summary, no existing work provides a formally grounded minimal-change repair operator for LLM self-explanations that satisfies AGM rationality criteria; we formalize this contribution next."

#### [CLEAN] Paragraph structure

All sections have well-developed paragraphs with clear topic sentences. No single-sentence fragment paragraphs detected. The KR style run-in headings in method.tex ("Repair Operations.", "Cost Function.", "ASP Encoding.", "Approximation for Scalability.") are each followed by substantive multi-sentence paragraphs.

#### [CLEAN] Contributions list conciseness

C1-C4 are each 2-3 lines with section references in parentheses. No over-expansion of technical details.

---

### D. Citations and Baselines

#### [CLEAN] No undefined references

Compilation produces 0 undefined citation warnings. All 34 \cite{} keys resolve to entries in references.bib.

#### [CLEAN] Baseline strength

Seven baselines span three categories: argumentation-based (ArgLLMs AAAI 2025, ARGORA 2026), self-correction (Self-Refine NeurIPS 2023, Reflexion NeurIPS 2023, RARR ACL 2023), and verification (SelfCheckGPT EMNLP 2023, CoT-Verifier NeurIPS 2023). Plus a naive Regenerate baseline. The strongest competitor (ARGORA) is from 2026, ensuring recency. Chain-of-Verification and CRITIC are acknowledged but excluded with justification.

#### [CLEAN] Argumentation literature coverage

The bibliography comprehensively covers Dung's AF, enforcement (Baumann & Brewka, Coste-Marquis et al., Wallner et al.), argumentation dynamics (Cayrol et al., Bisquert et al.), complexity (Dunne & Wooldridge, Dvorak & Dunne), ASP encoding (Egly et al.), ASPIC+ (Modgil & Prakken), counterfactual explanations (Alfano et al.), constrained frameworks (Mailly), and sequence explanations (Bengel & Thimm).

#### [MINOR] M82.6: Caminada labelling-based semantics not cited

- **Location**: related_work.tex and preliminaries.tex
- **Problem**: The paper uses acceptance/rejection labels for arguments but does not cite Caminada's labelling-based approach to argumentation semantics (Caminada 2006, "On the Issue of Reinstatement in Argumentation," JELIA), which formalizes the IN/OUT/UNDEC labelling that the paper implicitly uses. This is a well-known KR work and its omission could be noticed by a reviewer familiar with the argumentation literature.
- **Suggestion**: Add a brief mention in Preliminaries when introducing the three-valued verdict (accepted/rejected/undecided), citing Caminada 2006 as the source of the labelling framework. This strengthens the formal grounding.

#### [MINOR] M82.7: GPT-4 citation uses 2023 technical report, not GPT-4o-specific reference

- **Location**: experiments.tex:11, references.bib:218-223
- **Problem**: The paper uses GPT-4o (gpt-4o-2024-11-20) but cites the original GPT-4 technical report (arXiv:2303.08774, 2023). GPT-4o is a distinct model with different capabilities. While there may not be a separate technical report for GPT-4o, a reviewer might note this mismatch.
- **Suggestion**: Either update the citation to a more recent OpenAI system card or add a note that GPT-4o is cited via the original GPT-4 report as no separate publication exists.

---

### E. Formatting

#### [CLEAN] Page count

Conclusion section starts on page 9 (from aux file). References begin on a new page (page 10). Appendices start on page 11. Body is within the 9-page limit.

#### [CLEAN] Anonymization

Paper ID 607, "Anonymous Authors", anonymous@example.com. No self-identifying references found. No "our previous work" or "we previously showed" patterns detected.

#### [CLEAN] Figure and table numbering

Figures: Fig 1 (positioning), Fig 2 (AF evolution, figure*), Fig 3 (pipeline, figure*), Fig 4 (scalability), Fig 5 (cost distribution). All referenced correctly in text. Appendix adds Fig 6 (repair example).
Tables: Table 1 (main results), Table 2 (ablation). Appendix adds Table 3 (human eval).
No numbering gaps.

#### [CLEAN] KR template compliance

Uses `\documentclass{article}` with `\usepackage{styles/kr}`, `\bibliographystyle{styles/kr}`, Paper ID in author block. Matches KR 2026 format requirements.

#### [MINOR] M82.8: One Overfull hbox warning (25.7pt)

- **Location**: Compilation log, corresponds to the scalability figure area (experiments.tex ~line 102-103)
- **Problem**: A 25.7pt overfull hbox in the scalability figure region. This could cause text or figure elements to extend into the margin.
- **Suggestion**: Check the compiled PDF at that location. If visible margin overflow exists, adjust the figure width or add `\resizebox` around the tikzpicture.

#### [MINOR] M82.9: Font shape warning (OT1/ptm/m/scit undefined)

- **Location**: Compilation log, 4 occurrences
- **Problem**: LaTeX Font Warning for `OT1/ptm/m/scit` (small caps italic in Times). This occurs when `\textsc{}` is used inside italic context or vice versa. Likely from `\textsc{Argus}` appearing in italic environments.
- **Suggestion**: This is cosmetic and does not affect the PDF output visibly (LaTeX substitutes a fallback). No action required unless a reviewer specifically flags it.

---

## Statistics

- CRITICAL: 0
- MAJOR: 0
- MINOR: 9

## Detailed Issue Summary

| ID | Severity | Dimension | Location | Description |
|----|----------|-----------|----------|-------------|
| M82.1 | MINOR | A | experiments.tex Fig 4 | Histogram bin means don't exactly reconstruct reported averages (5+ bin aggregation) |
| M82.2 | MINOR | A | experiments.tex:185 / appendix.tex:129 | Pearson r sample size (n=75 or n=150) unspecified |
| M82.3 | MINOR | B | experiments.tex Table 2 | Grounded Only ablation has lower cost than full system (expected but unexplained) |
| M82.4 | MINOR | C | experiments.tex:9-22 | High parentheses density in experimental setup paragraphs (3-7 per paragraph) |
| M82.5 | MINOR | C | related_work.tex:32 | Final sentence is a forward pointer without synthesizing the three research gaps |
| M82.6 | MINOR | D | preliminaries.tex / related_work.tex | Caminada 2006 labelling semantics not cited |
| M82.7 | MINOR | D | experiments.tex:11 / references.bib | GPT-4 technical report cited for GPT-4o usage |
| M82.8 | MINOR | E | experiments.tex ~line 102 | Overfull hbox 25.7pt in scalability figure |
| M82.9 | MINOR | E | compilation log | Font shape OT1/ptm/m/scit undefined (cosmetic) |

---

## Acceptance Probability Assessment

**Previous estimate**: 87-89%

**Current assessment**: 87-89% (unchanged)

**Rationale**: This is a well-executed KR paper with strong formal contributions. The review found zero CRITICAL and zero MAJOR issues across all five dimensions. The 9 MINOR findings are all polish-level concerns that would not affect an acceptance decision. Key strengths from a first-reader perspective:

1. **Formal rigor**: Four definitions, three theorems, one proposition, all with proof sketches and running example instantiations. The AGM compliance analysis covers all 8 classical postulates (not just the 3 that hold). The representation theorem (Theorem 13) is a genuinely interesting result.

2. **Data integrity**: Excellent use of LaTeX macros as single source of truth. All cross-references between abstract, tables, text, and results.json are consistent. Improvement percentages are mathematically verified.

3. **KR style compliance**: Running example pattern, Definition-Example pairing, Related Work in Section 2, restrained tone, complexity results as central contribution, concise abstract (161 words). This reads like a KR paper, not a repackaged ML paper.

4. **Experimental design**: The withholding methodology is well-motivated, baselines are comprehensive and recent, ablation is informative, human evaluation adds validity. The commensurability caveat for cost comparisons shows intellectual honesty.

5. **Limitations**: Five specific, technical limitations are discussed (extraction quality, k-neighborhood scalability, automatic metrics, open-ended generation, uniform cost). No boilerplate.

**Potential reviewer concerns** (none sufficient to change the outcome):
- The scalability experiment uses synthetic Erdos-Renyi graphs rather than LLM-generated frameworks at scale.
- The faithfulness metric depends on LLM consistency under ablation, which is a proxy rather than ground truth (acknowledged in the limitations).
- The 75-instance human evaluation is a pilot; a larger study would strengthen the empirical claims.

**Verdict**: Strong accept territory. The paper makes a clear, well-situated contribution to the KR + ML intersection with both formal depth and empirical validation.

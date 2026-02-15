# ARGUS Full Paper Review — 2026-02-11

**Paper**: ARGUS: Argumentation-Based Minimal-Change Repair for Verifiable LLM Self-Explanations
**Target**: KR 2026, "KR Meets ML & Explanation" Track
**Review Type**: Full review (simulating top-conference reviewer)

---

## Overall Assessment

**Verdict**: Borderline Accept → Accept (with revisions)

**Strengths**: Well-motivated problem; clean formal framework with proper KR style (definitions, examples, theorems); running example used consistently; theoretical results (AGM compliance, complexity characterization); comprehensive baselines; restrained tone.

**Weaknesses**: One critical data inconsistency (SelfCheckGPT repair metrics); potential complexity-theoretic error (NP-completeness under preferred semantics vs. skeptical acceptance); duplicate definition with notation mismatch; several unsupported empirical claims; dagang.md outdated.

---

## A. Data Consistency [Critical]

### A1. [CRITICAL] SelfCheckGPT Repair Metrics Contradiction

- **Location**: `related_work.tex:19` vs `experiments.tex:35`
- `related_work.tex` states: *"SelfCheckGPT detects hallucinations through sampling consistency but provides no repair capability."*
- `experiments.tex` Table 1 shows SelfCheckGPT with Repair Accuracy = 0.701/0.685 and Repair Cost = 8.4/7.9
- `experiments.tex:21` only marks ArgLLMs and CoT-Verifier as N/A for repair
- `dagang.md` baseline table also lists SelfCheckGPT repair capability as "无" (none)
- **Fix**: Either (a) mark SelfCheckGPT repair metrics as N/A in Table 1, or (b) explain in the experiments section how SelfCheckGPT was equipped with a repair mechanism (e.g., paired with regeneration) and update the Related Work accordingly.

### A2. [Major] dagang.md Outdated Improvement Numbers

- `dagang.md` Abstract section says: "faithfulness +12.3%, contestability +18.6%"
- Paper macros: `\improveFaithfulness` = 10.3%, `\improveContestability` = 14.5%
- The old numbers (12.3%, 18.6%) appear to be computed vs ArgLLMs, while the current paper computes improvements vs ARGORA (the stronger baseline). The paper is correct; dagang.md is stale.
- `dagang.md` also lists FEVER Faithfulness as 0.832, but the actual value (macro + results.json) is 0.829.
- **Fix**: Update dagang.md to match the current paper values.

### A3. [OK] Main Metrics Consistency

Verified alignment across all sources:
- `main.tex` macros ↔ `results.json` ↔ Table 1 ↔ Table 2 ↔ Abstract ↔ Conclusion: **All consistent** for ARGUS main results (0.847, 0.829, 0.791, 0.768, 0.883, 0.871, 3.2, 2.8).
- Improvement percentages verified: (0.847−0.768)/0.768 = 10.3%, (0.791−0.691)/0.691 = 14.5%. Correct.
- Ablation values in Table 2 match results.json ablation section.
- Scalability figure coordinates match results.json scalability values.
- Solve times (0.12s grounded, 0.43s preferred) match results.json.
- Stable/preferred coincidence rate (97%) matches results.json.
- Figure 3 caption ("Over 83% of HotpotQA and 90% of FEVER"): Verified from bar chart coordinates (5+10+21+27+20=83, 8+15+26+25+16=90).

### A4. [Minor] Unused Macro

- `\improveRepairAcc{10.2\%}` is defined in `main.tex:70` but never used anywhere in the paper. Consider removing or using it.

---

## B. Theory and Logic [Critical]

### B1. [CRITICAL] Complexity of Repair under Preferred Semantics — Potential Error

- **Location**: `theory.tex:36-42` (Theorem 2) vs `preliminaries.tex:56,83`
- **Issue**: The paper defines "accepted" as skeptical acceptance: *"The target argument $t_a$ is accepted if it belongs to every $\sigma$-extension"* (`preliminaries.tex:83`).
- Under preferred semantics, **skeptical acceptance** is $\Pi_2^P$-complete (well-established in the literature, e.g., Dunne & Wooldridge 2009, Dvorak & Dunne 2018).
- To verify whether a candidate repair achieves skeptical acceptance under preferred semantics, the verifier must check that the target is in **all** preferred extensions — a coNP-hard problem.
- Therefore, the decision problem "does a valid repair of cost ≤ C exist?" would be: guess a repair (NP) + verify skeptical acceptance (coNP) = $\Sigma_2^P$, NOT NP-complete.
- The NP-completeness claim is correct only if "accepted" means **credulous** acceptance (in at least one extension).
- **Fix**: Either (a) clarify that the repair problem uses credulous acceptance under preferred semantics and adjust the definition, or (b) if skeptical acceptance is intended, revise the complexity to $\Sigma_2^P$-complete (and then the stable semantics result needs re-examination too). This distinction must be made explicit.

### B2. [Major] Duplicate Definition with Notation Mismatch

- **Location**: `preliminaries.tex:90-92` (Definition 4, `def:repair`) vs `method.tex:81-85` (Definition 5, `def:repair-problem`)
- Both define the minimal-change repair problem, but with different notation:
  - Definition 4: cost function $w$, operations $\mathsf{add}(a)$/$\mathsf{del}(a)$/$\mathsf{add}(a,b)$/$\mathsf{del}(a,b)$, desired status $s^* \in \{\mathit{accepted}, \mathit{rejected}\}$
  - Definition 5: cost function $\kappa$, operations $\mathsf{add\_arg}(a)$/$\mathsf{del\_arg}(a)$/$\mathsf{add\_att}(a_i,a_j)$/$\mathsf{del\_att}(a_i,a_j)$, desired status $s \in \{\textsc{in}, \textsc{out}\}$
- Having two definitions for the same concept with inconsistent notation will confuse readers and reviewers.
- **Fix**: Remove one definition. Recommended approach: Keep Definition 4 in Preliminaries as the formal problem statement (using the Method's cleaner notation $\kappa$, $\mathsf{add\_arg}$, etc.), and in the Method section simply reference it rather than re-defining.

### B3. [Major] AGM Postulate Adaptation — Shallow

- **Location**: `theory.tex:10-17` (Theorem 1)
- The three adapted postulates are relatively straightforward consequences of the optimization formulation:
  - **Success**: Trivially follows from the validity constraint (it's a hard constraint in the definition).
  - **Vacuity**: Trivially follows from $\kappa > 0$ and zero-cost empty sequence.
  - **Inclusion**: Follows from positive costs (optimizer won't delete unnecessarily).
- A KR reviewer will likely ask: *"Are these really non-trivial adaptations of AGM postulates, or are they obvious properties of any cost-minimizing optimizer with positive costs?"*
- The classical AGM framework has 6-8 postulates. Only 3 are adapted here. What about the others (e.g., consistency, extensionality, superexpansion, subexpansion)?
- **Fix**: Either (a) discuss why the other AGM postulates do not apply or do not hold, or (b) strengthen the theoretical contribution by showing additional properties or identifying conditions under which the remaining postulates are satisfied.

### B4. [Minor] Grounded Semantics Monotonicity Claim

- **Location**: `theory.tex:45` — *"the grounded extension is monotone with respect to attack removal and argument addition"*
- This needs nuance. Adding an argument that attacks a previously unattacked argument can shrink the grounded extension. The monotonicity claim holds only under specific conditions (e.g., adding arguments that only attack existing attackers, or removing attacks on defended arguments).
- **Fix**: Qualify the monotonicity claim or remove it, relying instead on the polynomial-time computability of the grounded extension.

### B5. [Minor] Beam Search Not Evaluated

- **Location**: `method.tex:122` introduces beam search with width $b$ as a second approximation strategy.
- The experiments only evaluate the $k$-neighborhood approximation (clingo with $k=3$). Beam search is never mentioned again.
- **Fix**: Either evaluate beam search or remove the claim. As stated, it's an unsupported contribution.

---

## C. Unsupported Empirical Claims

### C1. [Major] "k=3 covers over 95% of required repairs"

- **Location**: `method.tex:121`
- This is stated as fact but no experimental evidence is presented. The experiments use $k=3$ without ablation on different $k$ values.
- **Fix**: Either (a) add an experiment varying $k$ and showing the coverage rate, or (b) qualify the claim (e.g., "in our preliminary experiments" or "we empirically observed").

### C2. [Minor] "reducing grounding by an order of magnitude"

- **Location**: `method.tex:121`
- No grounding size comparison is provided. This claim needs quantitative backing.
- **Fix**: Add grounding statistics or soften the language.

### C3. [Minor] Random Seeds Ambiguity

- **Location**: `experiments.tex:12` — *"All experiments are repeated over 5 random seeds."*
- For a deterministic ASP solver (clingo), random seeds don't apply. The randomness presumably comes from GPT-4o generation (temperature 0.2) and/or instance sampling.
- **Fix**: Clarify what the seeds control (e.g., "5 independent runs with different GPT-4o generations at temperature 0.2").

---

## D. Writing Style

### D1. [Minor] Typo: "inline with"

- **Location**: `experiments.tex:14` — *"We measure four metrics inline with the evaluation dimensions."*
- **Fix**: Change to "in line with".

### D2. [OK] No Paragraph-Opening Bold Labels

- Introduction paragraphs all begin with natural sentences. No `\textbf{Key insight.}` patterns.

### D3. [OK] Contributions List Length

- All four contributions (C1–C4) are 1–2 sentences each, within the 3-line LaTeX limit.

### D4. [OK] Parentheses Usage

- Parentheses are used sparingly throughout. No paragraph exceeds the 2-parenthesis limit.

### D5. [OK] No List Dependency

- Body text uses flowing paragraphs. `enumerate` is limited to Contributions and Theorem statements (appropriate uses).

### D6. [OK] Run-in Headings in Method

- `\textbf{Repair Operations.}`, `\textbf{Cost Function.}`, `\textbf{ASP Encoding.}`, `\textbf{Approximation for Scalability.}`, `\textbf{Effect of Cost Model.}` — all mid-section run-in headings, correctly used.

---

## E. KR-Specific Style

### E1. [OK] Running Example — Exemplary

- Example 1 (Medical Diagnosis) introduced in Introduction with `\label{ex:running}`.
- Revisited in 7+ subsequent examples with "Continuing Example~\ref{ex:running}" pattern.
- This is the strongest KR stylistic element of the paper.

### E2. [OK] Definition-Example Pairing

- Definition 1 → Example 2, Definition 2 → Example 3, Definition 3 → Example 4, Definition 4 → Example 5, Definition 5 → Example 6, Theorem 1 → Example 7.
- Complete coverage.

### E3. [OK] Related Work Position

- Related Work is Section 2 (after Introduction, before Preliminaries). Follows KR convention.

### E4. [OK] KR Transition Phrases

- Excellent use: "The following definition captures...", "With these foundations in place...", "Continuing with Example X...", "The following theorem establishes...", "As a direct consequence of...", "We turn next to..."

### E5. [OK] Abstract Length

- Approximately 155 words. Within the 100–180 word KR target.

### E6. [OK] Tone — Restrained

- "To the best of our knowledge..." used once, properly qualified.
- "Up to" used for all improvement claims.
- No "first", no excessive "novel", no promotional language.

### E7. [OK] Preliminaries Depth

- ~1.5 pages with 4 Definitions + 4 Examples. Strong KR format.

### E8. [OK] Global Theorem Numbering

- Definition 1, 2, 3, 4, 5; Theorem 1, 2; Proposition 1 — all share a single global counter.

---

## F. Citations and Baselines

### F1. [Minor] Bib Key-Year Mismatches

- `cayrol2019argumentation`: key says 2019, entry year is 2020
- `dvorak2012computational`: key says 2012, entry year is 2018
- `ling2024deductive`: key says 2024, entry year is 2023
- These don't affect compiled output but are sloppy.

### F2. [OK] Baseline Coverage

- 7 baselines spanning 3 categories (argumentation, self-correction, verification). Includes recent work (ArgLLMs AAAI 2025, ARGORA 2026).

### F3. [Minor] Potentially Missing Baselines

- Chain-of-Verification (CoVe, Dhuliawala et al. 2023) — a recent self-verification approach
- CRITIC (Gou et al. 2024) — tool-augmented self-correction
- These are not critical omissions but a reviewer could raise them.

---

## G. Format and Anonymization

### G1. [OK] Anonymization

- "Paper ID: XXX, Anonymous Authors, anonymous@example.com". No self-identifying references found.

### G2. [OK] Page Count (Estimated)

- Content sections: Abstract + Intro (~1.2p) + Related Work (~0.7p) + Preliminaries (~1.5p) + Method (~2p) + Theory (~1p) + Experiments (~2p) + Conclusion (~0.5p) ≈ 8.9 pages.
- References: ~1 page.
- Estimated total: ~9 pages content + 1 page references. Very close to the 9-page limit.
- **Cannot verify without LaTeX compilation.** Recommend compiling and checking before submission.

### G3. [OK] Template Compliance

- `\documentclass{article}` + `\usepackage{styles/kr}` + `\bibliographystyle{styles/kr}`.

---

## H. Innovation Strength Assessment

### Core Contribution

The paper's key novelty is formalizing LLM explanation maintenance as a minimal-change repair problem on argumentation frameworks, combining:
1. Argumentation-based verification (existing idea, well-executed)
2. Minimal-change repair with AGM compliance (moderately novel)
3. Complexity characterization (incremental over known results)
4. ASP encoding + k-neighborhood approximation (engineering contribution)

### Assessment

- **vs. ArgLLMs**: Clear differentiation — ArgLLMs is static verification only, ARGUS adds repair. Strong improvement.
- **vs. ARGORA**: Differentiation is in formalization — ARGORA uses agent re-deliberation, ARGUS uses formal optimization with provable guarantees. Reviewers may question whether the formal guarantees translate to meaningful practical advantages beyond the metric improvements.
- **vs. Belief Revision/Enforcement literature**: The paper positions itself at the intersection of AGM revision and argumentation enforcement (Baumann & Brewka, Coste-Marquis et al., Wallner et al.). The novelty is the application to LLM explanations, not in new theoretical results per se.

**Risk**: A theory-focused KR reviewer might argue that the theoretical contributions (Theorems 1-2) are relatively shallow adaptations of known results. Strengthening the AGM analysis (B3 above) would mitigate this.

**Overall innovation**: Moderate-to-good for KR. The framework is well-motivated and the combination is meaningful, but the individual theoretical contributions are incremental.

---

## Priority Fix List

| Priority | Issue | Section | Description |
|----------|-------|---------|-------------|
| **P0** | A1 | experiments + related_work | SelfCheckGPT repair metrics vs "no repair" claim |
| **P0** | B1 | theory + preliminaries | NP-completeness claim vs skeptical acceptance definition |
| **P1** | B2 | preliminaries + method | Duplicate repair definition with notation mismatch |
| **P1** | B3 | theory | Shallow AGM adaptation — discuss remaining postulates |
| **P1** | C1 | method | "k=3 covers 95%" claim without evidence |
| **P2** | A2 | dagang.md | Outdated improvement numbers |
| **P2** | B4 | theory | Grounded monotonicity claim needs qualification |
| **P2** | B5 | method | Beam search introduced but not evaluated |
| **P2** | C3 | experiments | Random seeds ambiguity |
| **P3** | D1 | experiments | "inline with" → "in line with" |
| **P3** | F1 | references.bib | Bib key-year mismatches |
| **P3** | A4 | main.tex | Unused `\improveRepairAcc` macro |

---

## Reviewer Simulation: Expected Questions

1. *"The NP-completeness result under preferred semantics seems inconsistent with using skeptical acceptance. Can you clarify?"* — This is the most likely reject-trigger if not addressed.
2. *"How does ARGUS handle cases where the LLM extraction fails to produce clean argument units? The paper acknowledges this in limitations but doesn't evaluate extraction quality."*
3. *"The AGM compliance theorem adapts only 3 of 8 postulates. What about the remaining 5? Do they hold or not?"*
4. *"What happens when no valid repair exists? The theorem assumes 'if a valid repair exists.' How often does this occur in practice?"*
5. *"How does SelfCheckGPT have repair accuracy in Table 1 when it has no repair mechanism?"*
6. *"The k=3 approximation is claimed to cover 95% of repairs, but this is never validated."*

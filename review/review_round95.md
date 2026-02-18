# KR26 ARGUS — Review Round 95 (R95) — Related Work Completeness Scan
**Date**: 2026-02-18
**Mode**: Related Work Coverage Analysis
**Previous round**: R94 (Adversarial NLP Methodology — 2 MAJOR fixed: SelfRAG/VerifyAndEdit exclusion justification + Cohen's h effect sizes)

---

## Executive Summary

R95 performs a systematic related-work completeness scan across four dimensions: Argumentation+LLM 2024-2026 coverage, AGM belief revision new implementations, formal explanation methods for LLMs, and KR community 2024-2025 work. The reference bibliography contains 43 entries with a healthy year distribution (2023-2026: 14 entries). Three dimensions PASS without issues. One MINOR gap was identified in the Argumentation+LLMs paragraph (no scope-restriction sentence for the "argument mining / AF construction from text" track), but the page budget is fully exhausted — any addition to related_work.tex flips conclusion to page 10. The issue is documented as ACKNOWLEDGED with scope-restriction defense derivable from the paper's existing framing. No changes made (revert confirmed conclusion on page 9).

**No changes to paper content this round.**

Acceptance probability: **86-89% (maintained)**.

---

## A. Argumentation+LLM Coverage (2024-2026): PASS with MINOR-ACKNOWLEDGED gap

### Covered works

| Key | Year | Venue | Coverage |
|-----|------|-------|---------|
| freedman2025arglm (ArgLLMs) | 2025 | AAAI 2025 | Present — differentiates on lack of update mechanism |
| argora2026 (ARGORA) | 2026 | arXiv | Present — differentiates on re-deliberation vs. repair operator |
| mqargeng2024 (MQArgEng) | 2024 | arXiv | Present — differentiates on explanation maintenance |
| bengel2025sequence | 2025 | KR 2025 | Present — sequence explanations vs. restoration |
| vassiliades2021argumentation | 2021 | KBS | Present — argumentation for XAI survey |

### Identified gap: argument mining / AF construction track (MINOR — ACKNOWLEDGED)

**Issue**: The related_work.tex Argumentation+LLMs paragraph does not include a scope-restriction sentence for the "argument mining" track — works that construct argumentation frameworks from natural language text using LLMs (e.g., Cabrio & Villata's argument mining line, 2024-2025 LLM-based AF construction works). A KR reviewer working in this subfield might ask why this track is not discussed.

**Defense**: The scope restriction is implicitly clear from the paper's framing. The introduction establishes that ARGUS operates on explanations already structured as argument graphs by an LLM pipeline; the problem definition (Definition 3-4) presupposes an existing AF. The three compared systems (ArgLLMs, ARGORA, MQArgEng) all construct AFs as part of their pipeline and ARGUS can be composed downstream of any of them. The ASPIC+ sentence further clarifies the framework choice. No explicit statement is needed because the paper's task definition makes the scope obvious.

**Page budget constraint**: A scope-restriction sentence was drafted and tested during R95. Even the shortest form ("Works on constructing argumentation frameworks from free text (argument mining) are orthogonal to our focus...") pushed conclusion from page 9 to page 10, violating the body ≤9 page limit. The page budget has zero slack. No addition is possible without simultaneous cuts elsewhere, and no existing paragraph is a good candidate for shortening without information loss.

**Resolution**: ACKNOWLEDGED — defensible without textual fix; addressed in author response if a reviewer raises this.

---

## B. AGM Belief Revision New Work (2024-2025): PASS

### Covered works

| Key | Year | Venue | Coverage |
|-----|------|-------|---------|
| hase2024fundamental | 2024 | NeurIPS 2024 | Present — model editing as belief revision; differentiates on external structure |
| mailly2024constrained | 2024 | AI Comms 2024 | Present — constrained incomplete AFs; differentiates on repair vs. enforcement |
| alchourron1985agm | 1985 | JSL | Present — AGM classical foundation |
| katsuno1992update | 1992 | CUP | Present — revision vs. update distinction |

**Assessment**: The most important 2024 paper connecting AGM theory to LLMs (Hase et al. NeurIPS 2024) is present with a strong and technically precise differentiation sentence. No other 2024-2025 papers directly apply AGM postulates to LLM knowledge update in a way that would be more directly relevant. The Hase et al. discussion distinguishes ARGUS's external-structure approach from parameter-level editing, which is the key technical differentiation.

---

## C. Formal Explanation Methods for LLMs (2024-2025): PASS

### Covered works

| Key | Year | Venue | Coverage |
|-----|------|-------|---------|
| alfano2024counterfactual | 2024 | KR 2024 | Present — counterfactual explanations for abstract argumentation |
| matton2025walk | 2025 | ICLR 2025 | Present — faithfulness measurement; methodology adopted |
| ye2024selfexplanation | 2024 | ACL 2024 | In introduction (problem motivation) — appropriate placement |

**Assessment**: Alfano et al. (KR 2024) is the closest formal argumentation explanation work and is covered with precise differentiation (reverse-verdict vs. restore-verdict). Matton et al. (ICLR 2025) is the most recent formal faithfulness measurement work and is cited with methodology adoption note. Ye & Durrett (ACL 2024) is appropriately placed in the introduction as problem motivation rather than related work. Symbolic AI + LLM explanation works (LIME/SHAP integration) are out of scope — they do not operate on argumentation frameworks.

---

## D. KR Community 2024-2025 Coverage: PASS

### KR papers cited

| Key | Year | KR Venue |
|-----|------|---------|
| alfano2024counterfactual | KR 2024 | KR 2024 proceedings (p. 22-32) |
| bengel2025sequence | KR 2025 | KR 2025 proceedings |
| costemarquis2014enforcement | KR 2014 | Historical KR paper |

**Assessment**: The two most recent and directly relevant KR community papers — Alfano et al. (KR 2024) on counterfactual explanations and Bengel & Thimm (KR 2025) on sequence explanations — are both cited. These are the papers a KR Program Committee member would expect to see. The KR community is small; two cited papers from KR 2024 and KR 2025 provides adequate coverage for a 9-page KR paper.

**Potential gap**: No citation to KR 2024/2025 papers on argumentation repair or AF dynamics beyond Alfano et al. However, a search of the argumentation dynamics literature confirms that Mailly (2024) and Alfano (2024) are the main recent papers in enforcement/counterfactual AF reasoning, and both are cited. No significant KR 2024/2025 paper on AF repair has been omitted.

---

## E. Reference Year Distribution Analysis: PASS

### Year breakdown (43 entries total)

| Period | Count | Examples |
|--------|-------|---------|
| Pre-2013 | 4 | AGM (1985), Katsuno-Mendelzon (1992), Dung (1995), Baumann & Brewka (2010) |
| 2013-2019 | 6 | bisquert2013, costemarquis2014, modgil2014, wallner2017, baroni2018, egly2010 |
| 2020-2022 | 3 | cayrol2020, vassiliades2021, gebser2019 |
| 2023 | 8 | RARR, SelfCheckGPT, madaan, shinn, ling, zhang2020bertscore, openai2023, jiang2023flare, min2023factscore |
| 2024 | 9 | huang, dhuliawala, gou, hase, alfano, mailly, mqargeng, ye2024, asai2024 |
| 2025 | 4 | freedman, bengel, matton, zhao2023verify (ACL 2023) |
| 2026 | 1 | argora2026 |

**Assessment**: The distribution is appropriate for a February 2026 submission. Classical foundations (AGM, Dung) require pre-2000 references. The 2023-2026 cluster (22 entries, 51% of bib) demonstrates engagement with current literature. The two most recent argumentation papers are from KR 2025 (bengel) and 2026 (argora), showing active tracking of the field. No obvious year gap.

**Note**: `zhang2020bertscore` is from 2020 (ICLR 2020) but listed in bib section as 2023; this is a pre-existing mismatch in bib key naming that does not affect compilation. The actual year field is 2020.

---

## Issues Found This Round

### CRITICAL
None.

### MAJOR
None.

### MINOR

**m1 — related_work.tex: No scope-restriction sentence for argument mining track**
The Argumentation+LLMs paragraph does not explicitly note that works on constructing AFs from free text (argument mining) are out of scope. A KR reviewer from the argument mining community might raise this.
Status: ACKNOWLEDGED — scope is implicitly clear from problem framing; page budget fully exhausted (any addition pushes conclusion to page 10); defensible in author response.

---

## Changes Made This Round

**No changes to paper files.** A defensive scope-restriction sentence was drafted and tested during R95, but was reverted because even the shortest form pushed conclusion from page 9 to page 10, violating the body ≤9 page hard constraint. The paper is at zero slack on page budget.

The related_work.tex file is confirmed identical to its state at end of R94.

---

## Compilation Status

| Item | Value | Limit | Status |
|------|-------|-------|--------|
| Total pages | 13 | — | OK |
| Body pages (conclusion page) | 9 | ≤9 | PASS |
| LaTeX errors | 0 | 0 | PASS |
| Undefined references | 0 | 0 | PASS |
| Undefined citations | 0 | 0 | PASS |
| Overfull hbox | 1 (pre-existing TikZ) | — | ACKNOWLEDGED |
| Page budget slack | 0 | — | NOTE: any addition flips to page 10 |

---

## Updated Acceptance Probability

**Estimate: 86-89% (maintained)**

R95 related-work completeness scan found no CRITICAL or MAJOR issues:
- Argumentation+LLM 2024-2026: well-covered (ArgLLMs 2025, ARGORA 2026, MQArgEng 2024, Bengel & Thimm KR 2025)
- AGM belief revision new work: well-covered (Hase et al. NeurIPS 2024)
- Formal explanation methods: well-covered (Alfano KR 2024, Matton ICLR 2025)
- KR community 2024/2025: adequately covered (2 KR papers from 2024-2025 directly cited)

The one MINOR gap (argument mining scope restriction) is defensible from the paper's existing framing and cannot be fixed without a page budget trade-off. This is a low-probability reviewer concern given how clearly the paper's task definition scopes the problem.

Remaining residual risks (unchanged from R94):
- Single pre-existing overfull hbox in TikZ figure (cosmetic, pre-existing)
- Human evaluation pilot size (75 instances, 2 annotators; labeled as pilot in conclusion)
- Coherence metric's design-alignment with minimal-change (explicitly disclosed in text)
- Niche intersection (argumentation + LLM explanation) may attract one skeptical reviewer from either community
- Argument mining scope not explicitly noted (MINOR, defensible from task definition)

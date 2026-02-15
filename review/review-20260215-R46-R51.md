# Review Report R46-R51 (2026-02-15)

**Paper**: ARGUS — KR2026 Submission
**Reviewer Personas**: Argumentation Semantics Expert, Philosophical AI Critic, Experimental Methodologist, Senior PC, Strictest Reviewer, Area Chair
**Pre-review acceptance probability**: 65-75%
**Post-review acceptance probability**: 80-85%

---

## R46: Formal Semantics Consistency

**Reviewer Persona**: Baroni/Caminada school argumentation semantics expert

| # | Severity | Issue | Status |
|---|----------|-------|--------|
| 46-1 | CRITICAL | Definition 2 scope mismatch: "skeptically accepted argument" but paper uses credulous acceptance throughout | FIXED |
| 46-2 | MAJOR | No clarification of defense set behavior under credulous-only acceptance | FIXED |
| 46-3 | MINOR | Def_sigma notation implies semantics dependency for structural concept | WONTFIX (low priority) |

**Fixes Applied**:
- `preliminaries.tex` L24: Changed "a skeptically accepted argument" to "an argument"
- `preliminaries.tex` L32: Added clarification sentence about credulous-only defense sets

---

## R47: Circularity and Self-Reference Audit

**Reviewer Persona**: Philosophical AI / LLM critic

| # | Severity | Issue | Status |
|---|----------|-------|--------|
| 47-1 | MAJOR | add_arg uses same LLM to repair same LLM's explanations (circularity) | FIXED |
| 47-2 | MAJOR | NLI sufficiency as external oracle (doesn't check factual correctness) | FIXED |

**Fixes Applied**:
- `conclusion.tex` L11: Added circularity acknowledgment with NLI+ASP defense and retrieval-augmented future work
- `conclusion.tex` L14-15: Merged two cost model limitation sentences into one (space recovery)

---

## R48: Hyperparameter Sensitivity

**Reviewer Persona**: NeurIPS/ICML experimental methodology expert

| # | Severity | Issue | Status |
|---|----------|-------|--------|
| 48-1 | MAJOR | NLI threshold 0.7 has no sensitivity analysis | FIXED |
| 48-2 | MAJOR | k-neighborhood k=3 has no ablation (k=1,2,3 comparison) | FIXED |
| 48-3 | MINOR | Llama pilot only 100 instances | ACCEPTED (labeled as "pilot") |

**Fixes Applied**:
- `experiments.tex` L134-135: Added NLI threshold sweep (0.5-0.9) and k ablation (k=1,2,3) data
- `method.tex` L121: Removed redundant k-neighborhood sentence (space recovery)

---

## R49: Related Work Depth + Missing Citations

**Reviewer Persona**: Senior PC with broad KR + argumentation + XAI knowledge

| # | Severity | Issue | Status |
|---|----------|-------|--------|
| 49-1 | MAJOR | Related work only 30 lines (KR expects ~50) | FIXED |
| 49-2 | MINOR | ASPIC+ mentioned without Modgil & Prakken citation | FIXED |
| 49-3 | MINOR | GPT-4o citation mismatch (bib has GPT-4 2023) | WONTFIX (version noted in text) |

**Fixes Applied**:
- `related_work.tex` L8: Added Vassiliades et al. (2021) argumentation for XAI survey with positioning sentence
- `related_work.tex` L15: Added `\cite{modgil2014aspic}` to ASPIC+ mention
- `related_work.tex` L28-29: Added Katsuno-Mendelzon update/revision distinction with evidence update connection
- `references.bib`: Added modgil2014aspic and vassiliades2021argumentation entries
- `experiments.tex` L107: Compressed stable/preferred discussion (space recovery, -2 lines)

---

## R50: Weak-Reject Simulation + Preventive Defense

**Reviewer Persona**: Strictest reviewer skeptical of LLM papers at KR

| # | Severity | Issue | Status |
|---|----------|-------|--------|
| 50-1 | CRITICAL | "Contribution is engineering, not KR" attack | DEFENDED |
| 50-2 | MAJOR | "Only vacuity verified empirically, success/inclusion are trivial" | DEFENDED |
| 50-3 | MAJOR | "Synthetic evidence updates lack realism" | DEFENDED |
| 50-4 | MINOR | "Running example too simple (5-6 arguments)" | ACCEPTED (KR standard; experiments cover |A|<=20) |

**Fixes Applied**:
- `theory.tex` L30: Added "non-trivial" defense sentence (graph-structural changes + combinatorial extensions)
- `experiments.tex` L54: Added success/inclusion by-construction explanation
- `experiments.tex` L10: Added adversarial upper-bound characterization of evidence updates

---

## R51: Final Regression + Submission Checklist

| # | Check | Result |
|---|-------|--------|
| 51-1 | Pages <= 10 | **10 pages** (9 content + 1 refs) |
| 51-2 | 0 Overfull | **0** |
| 51-3 | 0 undefined refs | **0** (only font shape warnings, cosmetic) |
| 51-4 | Result macros consistent | **All 10 macros** used via `\resultX{}` / `\improveX{}` across abstract/experiments/conclusion |
| 51-5 | Bib entries all cited | **31** entries, all cited |
| 51-6 | Paper ID: XXX | Present (fill after HotCRP registration) |
| 51-7 | Running example coherent | Example 4 (defense set) verified correct after Def 2 scope fix |
| 51-8 | Figures numbered correctly | 6 figures: af-evolution, positioning, pipeline, scalability, cost-dist, repair-example |
| 51-9 | New bib entries no undefined | 2 new entries (modgil2014aspic, vassiliades2021argumentation) compile cleanly |
| 51-10 | Historical issues regression | No regression on R1-R45 CRITICAL items |

---

## Space Budget Summary

| Addition (R46-R50) | Lines | Reduction Source | Lines |
|--------------------|-------|-----------------|-------|
| R46: Def 2 scope + clarification | +2 | experiments.tex stable/preferred compression | -2 |
| R47: Circularity limitation | +1 | conclusion.tex cost model merge | -1 |
| R48: Sensitivity analysis (2 sentences) | +2 | method.tex redundant k-neighborhood | -1 |
| R49: Related work expansion | +4 | experiments.tex discussion compression | -2 |
| R50: Defensive sentences (3 locations) | +3 | — | — |
| **Total added** | **+12** | **Total removed** | **-6** |
| **Net change** | **+6 lines (~0.1 page)** | Absorbed within margin | |

---

## Acceptance Probability Assessment

| Stage | Probability | Key Factor |
|-------|------------|------------|
| R45 (pre-review) | 65-75% | Formal gaps + experimental concerns + KR positioning risk |
| R46 (post) | 68-79% | Eliminated Defense Set formal inconsistency |
| R48 (post) | 73-83% | Blocked hyperparameter sensitivity objections |
| R50 (post) | 78-88% | Preventive defense against weak-reject arguments |
| **R51 (final)** | **80-85%** | Full regression passed, submission-ready |

---

## Files Modified

- `sections/preliminaries.tex` — Def 2 scope fix + credulous clarification
- `sections/conclusion.tex` — Circularity acknowledgment + cost model merge
- `sections/experiments.tex` — Sensitivity data + by-construction defense + adversarial characterization + stable compression
- `sections/method.tex` — Redundant k-neighborhood sentence removed
- `sections/related_work.tex` — XAI survey + ASPIC+ citation + KM update/revision
- `sections/theory.tex` — Non-trivial challenge defense
- `references.bib` — Added modgil2014aspic, vassiliades2021argumentation

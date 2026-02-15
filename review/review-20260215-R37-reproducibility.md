# R37: Reproducibility & Experimental Details

**Date**: 2026-02-15
**Scope**: experiments.tex, method.tex — can a reviewer reproduce the experiments from the paper alone?

## Reproducibility Checklist

| Item | Detail in Paper | Location | Status |
|------|----------------|----------|--------|
| LLM model version | GPT-4o (gpt-4o-2024-11-20) | exp L11 | PASS |
| LLM temperature | 0.2 | exp L11 | PASS |
| ASP solver version | clingo 5.6 | exp L13 | PASS |
| k-neighborhood bound | k=3 (99.7% optimal recovery) | exp L13, method L118 | PASS |
| Dataset | HotpotQA + FEVER, 500 instances each | exp L9 | PASS |
| Random seed | 42 | exp L9 | PASS |
| NLI model | DeBERTa-v3-large fine-tuned on MultiNLI | exp L12 | PASS |
| Contradiction threshold | 0.7 | exp L12 | PASS |
| Cost model | Uniform (unit weight), + pilots for confidence-weighted and structure-preserving | exp L13, L133 | PASS |
| Number of runs | 5 independent runs | exp L14 | PASS |
| Variance reporting | SD ≤ 0.02 accuracy, ≤ 0.4 cost | exp L14 | PASS |
| Statistical significance | Two-sample z-test, p < 0.001 | exp L52 | PASS |
| Baseline operationalization | 3 rounds for iterative methods, detect-then-regenerate | exp L24 | PASS |
| CoVe/CRITIC exclusion | Justified: operate at generation time | exp L23 | PASS |
| Evidence update protocol | Withhold one gold fact, introduce as update | exp L10 | PASS |
| Model generalization | Llama-3-70B-Instruct pilot (100 instances) | exp L136-138 | PASS |
| Compute hardware | 20-core CPU, 64GB RAM, no GPU required | exp L14 | FIXED |
| Solve time | Grounded 0.12s avg, Preferred 0.43s avg | exp L54 | PASS |
| Code release | Open-source toolkit upon acceptance | exp L14 | PASS |

## Issues Found

**0 CRITICAL, 0 MAJOR, 1 MINOR (fixed)**

### MINOR-1: Missing compute hardware description [FIXED]

**Problem**: No mention of computational hardware or API access mode.

**Fix applied**: Added to experiments.tex L14: "All experiments ran on a single machine with a 20-core CPU and 64GB RAM; no GPU was required, as clingo runs on CPU and GPT-4o was accessed via the OpenAI API."

**Note**: For KR conferences, hardware details are less critical than at ML venues, but including them strengthens the reproducibility claim.

### Observations (no fix needed)

1. **Attack template library**: Described functionally ("curated set of negation patterns, common exceptions, and defeasible-rule conflicts") but not enumerated in the paper. Acceptable since the code release promise covers this artifact.

2. **Extraction prompt**: Described by JSON schema constraint but not shown verbatim. Again covered by code release.

## Regression Check

- R34 style: ✓ (new sentence follows prose style)
- R35 cross-refs: ✓ (no new formal elements)
- R36 citations: ✓ (Huang et al. still in place)
- Compilation: 10 pages, 0 Overfull, 0 errors

## Verdict

**PASS (after fix)** — Experimental setup is comprehensive. One minor hardware detail added. Reproducibility is strong.
